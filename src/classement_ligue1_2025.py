# -------------------------------
# IMPORTATION DES LIBRAIRIES
# -------------------------------
import mysql.connector  # Pour se connecter et interroger une base MySQL
import pandas as pd      # Pour manipuler les données sous forme de DataFrame
from rich.console import Console  # Pour afficher du texte et des tableaux stylés dans le terminal
from rich.table import Table      # Pour créer et styliser des tableaux

# -------------------------------
# CONNEXION À LA BASE DE DONNÉES MYSQL
# -------------------------------
conn = mysql.connector.connect(
    host="localhost",   # Adresse du serveur MySQL
    user="root",        # Nom d'utilisateur
    password="",        # Mot de passe
    database="sport_manager"  # Base de données à utiliser
)

# -------------------------------
# REQUÊTE SQL POUR RÉCUPÉRER LE CLASSEMENT DE LA LIGUE 1 2025-2026
# -------------------------------
query = """
SELECT 
    e.nom_equipe,  -- Nom de l'équipe
    COUNT(r.id_rencontre) AS matchs,  -- Nombre de matchs joués

    -- Calcul des victoires : 1 point si l'équipe gagne à domicile ou à l'extérieur
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS victoires,

    -- Calcul des matchs nuls
    SUM(
        CASE WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1 ELSE 0 END
    ) AS nuls,

    -- Calcul des défaites
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 < r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 < r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS defaites,

    -- Calcul des buts marqués
    SUM(
        CASE WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 ELSE r.score_equipe_2 END
    ) AS buts_pour,

    -- Calcul des buts encaissés
    SUM(
        CASE WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_2 ELSE r.score_equipe_1 END
    ) AS buts_contre,

    -- Calcul du goal average (différence de buts)
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 - r.score_equipe_2
            ELSE r.score_equipe_2 - r.score_equipe_1
        END
    ) AS goal_average,

    -- Calcul des points : 3 points pour une victoire, 1 pour un match nul, 0 pour une défaite
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 3
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 3
            WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1
            ELSE 0
        END
    ) AS points

FROM EQUIPE e
JOIN RENCONTRE r ON e.id_equipe = r.id_equipe OR e.id_equipe = r.id_equipe_1  -- Lier chaque équipe à ses matchs
JOIN _composer comp ON comp.id_journee = r.id_journee                        -- Lier les rencontres à la saison et compétition
JOIN SAISON s ON comp.id_saison = s.id_saison
JOIN COMPETITION c ON comp.id_competition = c.id_competition
WHERE s.libelle_saison = '2025-2026'             -- Filtrer sur la saison 2025-2026
  AND c.libelle_competition = 'Ligue 1'          -- Filtrer sur la compétition Ligue 1
GROUP BY e.nom_equipe                              -- Regrouper les résultats par équipe
ORDER BY points DESC, goal_average DESC;          -- Trier : points décroissants, puis goal average
"""

# -------------------------------
# LECTURE DES DONNÉES DANS UN DATAFRAME PANDAS
# -------------------------------
df = pd.read_sql(query, conn)  # Exécute la requête SQL et récupère le résultat dans un DataFrame
conn.close()                   # Ferme la connexion à la base MySQL

# -------------------------------
# AFFICHAGE AVEC RICH
# -------------------------------
console = Console()  # Crée un objet Console pour afficher du texte et des tableaux stylés

# Création du tableau avec un titre
table = Table(title="🏆 Classement Ligue 1 — Saison 2025-2026", show_lines=False)

# Définition des colonnes du tableau
table.add_column("Équipe", style="bold cyan", justify="left")   # Nom de l'équipe
table.add_column("MJ", justify="center")                        # Matchs joués
table.add_column("V", justify="center", style="green")          # Victoires
table.add_column("N", justify="center", style="yellow")         # Matchs nuls
table.add_column("D", justify="center", style="red")            # Défaites
table.add_column("BP", justify="center")                        # Buts pour
table.add_column("BC", justify="center")                        # Buts contre
table.add_column("GA", justify="center")                        # Goal average
table.add_column("Pts", justify="center", style="bold magenta") # Points

# -------------------------------
# REMPLISSAGE DU TABLEAU
# -------------------------------
for index, row in df.iterrows():  # Parcourt chaque ligne du DataFrame
    # Appliquer un style spécial pour le top 3 : vert gras
    style = "bold green" if index < 3 else None

    # Ajout de la ligne dans le tableau
    table.add_row(
        row["nom_equipe"],          # Nom de l'équipe
        str(row["matchs"]),         # Matchs joués (converti en chaîne)
        str(row["victoires"]),      # Victoires
        str(row["nuls"]),           # Matchs nuls
        str(row["defaites"]),       # Défaites
        str(row["buts_pour"]),      # Buts marqués
        str(row["buts_contre"]),    # Buts encaissés
        str(row["goal_average"]),    # Goal average
        str(row["points"]),         # Points
        style=style                 # Style appliqué si top 3
    )

# Affiche le tableau complet dans le terminal
console.print(table)
