import mysql.connector
import pandas as pd
from rich.console import Console
from rich.table import Table

# Connexion à la base MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="sport_manager"
)

# Requête SQL (classement Ligue 1 2025-2026)
query = """
SELECT 
    e.nom_equipe,
    COUNT(r.id_rencontre) AS matchs,
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS victoires,
    SUM(
        CASE WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1 ELSE 0 END
    ) AS nuls,
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 < r.score_equipe_2 THEN 1
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 < r.score_equipe_1 THEN 1
            ELSE 0
        END
    ) AS defaites,
    SUM(
        CASE WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 ELSE r.score_equipe_2 END
    ) AS buts_pour,
    SUM(
        CASE WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_2 ELSE r.score_equipe_1 END
    ) AS buts_contre,
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe THEN r.score_equipe_1 - r.score_equipe_2
            ELSE r.score_equipe_2 - r.score_equipe_1
        END
    ) AS goal_average,
    SUM(
        CASE
            WHEN r.id_equipe = e.id_equipe AND r.score_equipe_1 > r.score_equipe_2 THEN 3
            WHEN r.id_equipe_1 = e.id_equipe AND r.score_equipe_2 > r.score_equipe_1 THEN 3
            WHEN r.score_equipe_1 = r.score_equipe_2 THEN 1
            ELSE 0
        END
    ) AS points
FROM EQUIPE e
JOIN RENCONTRE r ON e.id_equipe = r.id_equipe OR e.id_equipe = r.id_equipe_1
JOIN _composer comp ON comp.id_journee = r.id_journee
JOIN SAISON s ON comp.id_saison = s.id_saison
JOIN COMPETITION c ON comp.id_competition = c.id_competition
WHERE s.libelle_saison = '2025-2026'
  AND c.libelle_competition = 'Ligue 1'
GROUP BY e.nom_equipe
ORDER BY points DESC, goal_average DESC;
"""

# Charger les données dans un DataFrame
df = pd.read_sql(query, conn)
conn.close()

# -------------------------------
# AFFICHAGE AVEC RICH
# -------------------------------

console = Console()

table = Table(title="🏆 Classement Ligue 1 — Saison 2025-2026", show_lines=False)

# Colonnes
table.add_column("Équipe", style="bold cyan", justify="left")
table.add_column("MJ", justify="center")
table.add_column("V", justify="center", style="green")
table.add_column("N", justify="center", style="yellow")
table.add_column("D", justify="center", style="red")
table.add_column("BP", justify="center")
table.add_column("BC", justify="center")
table.add_column("GA", justify="center")
table.add_column("Pts", justify="center", style="bold magenta")

# Lignes
for index, row in df.iterrows():
    style = "bold green" if index < 3 else None  # Top 3 en vert
    table.add_row(
        row["nom_equipe"],
        str(row["matchs"]),
        str(row["victoires"]),
        str(row["nuls"]),
        str(row["defaites"]),
        str(row["buts_pour"]),
        str(row["buts_contre"]),
        str(row["goal_average"]),
        str(row["points"]),
        style=style
    )

console.print(table)
