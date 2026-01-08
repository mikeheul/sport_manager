# -------------------------------
# IMPORTATION DES LIBRAIRIES
# -------------------------------
import mysql.connector  # Pour se connecter à une base de données MySQL
import pandas as pd      # Pour manipuler les données sous forme de DataFrame
from rich.console import Console  # Pour afficher du texte stylé dans le terminal
from rich.table import Table      # Pour créer des tableaux stylés dans le terminal
from db import get_connection

# -------------------------------
# CONNEXION À LA BASE DE DONNÉES MYSQL
# -------------------------------
conn = get_connection()

# -------------------------------
# REQUÊTE SQL POUR RÉCUPÉRER LES RENCONTRES
# -------------------------------
query = """
SELECT 
    r.id_rencontre,                         -- ID unique de la rencontre
    e1.nom_equipe AS equipe_domicile,       -- Nom de l'équipe à domicile
    e2.nom_equipe AS equipe_exterieur,      -- Nom de l'équipe à l'extérieur
    r.score_equipe_1 AS score_domicile,     -- Score de l'équipe à domicile
    r.score_equipe_2 AS score_exterieur     -- Score de l'équipe à l'extérieur
FROM RENCONTRE r
JOIN EQUIPE e1 ON r.id_equipe = e1.id_equipe       -- Récupère les infos de l'équipe à domicile
JOIN EQUIPE e2 ON r.id_equipe_1 = e2.id_equipe    -- Récupère les infos de l'équipe extérieure
ORDER BY r.id_rencontre;                           -- Trie les résultats par ID de rencontre
"""

# -------------------------------
# LECTURE DES DONNÉES AVEC PANDAS
# -------------------------------
df = pd.read_sql(query, conn)  # Exécute la requête SQL et stocke le résultat dans un DataFrame
conn.close()                   # Ferme la connexion à la base de données

# -------------------------------
# AFFICHAGE DES DONNÉES AVEC RICH
# -------------------------------
console = Console()  # Crée un objet console pour afficher le tableau stylé

# Création du tableau avec un titre et des lignes séparées
table = Table(title="⚽ Résultats des rencontres", show_lines=True)

# Définition des colonnes du tableau
table.add_column("ID", justify="center", style="bold")          # ID de la rencontre
table.add_column("Domicile", justify="left", style="cyan")      # Nom de l'équipe à domicile
table.add_column("Score", justify="center", style="bold yellow")# Score de la rencontre
table.add_column("Extérieur", justify="left", style="magenta")  # Nom de l'équipe extérieure

# -------------------------------
# REMPLISSAGE DU TABLEAU
# -------------------------------
for _, row in df.iterrows():  # Parcourt chaque ligne du DataFrame
    # Mise en forme du score sous forme "domicile - extérieur"
    score = f"{row['score_domicile']} - {row['score_exterieur']}"

    # Détermination du style (couleur + gras) selon le résultat
    if row["score_domicile"] > row["score_exterieur"]:   # Victoire de l'équipe à domicile
        score_style = "bold green"
    elif row["score_domicile"] < row["score_exterieur"]: # Défaite de l'équipe à domicile
        score_style = "bold red"
    else:                                               # Match nul
        score_style = "bold white"

    # Ajout d'une ligne dans le tableau avec le style choisi
    table.add_row(
        str(row["id_rencontre"]),       # ID de la rencontre
        row["equipe_domicile"],         # Nom de l'équipe à domicile
        score,                          # Score formaté
        row["equipe_exterieur"],        # Nom de l'équipe extérieure
        style=score_style               # Style appliqué à toute la ligne
    )

# -------------------------------
# AFFICHAGE DU TABLEAU DANS LE TERMINAL
# -------------------------------
console.print(table)  # Affiche le tableau stylé avec Rich
