import mysql.connector
import pandas as pd
from rich.console import Console
from rich.table import Table

# Connexion MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="sport_manager"
)

query = """
SELECT 
    r.id_rencontre,
    e1.nom_equipe AS equipe_domicile,
    e2.nom_equipe AS equipe_exterieur,
    r.score_equipe_1 AS score_domicile,
    r.score_equipe_2 AS score_exterieur
FROM RENCONTRE r
JOIN EQUIPE e1 ON r.id_equipe = e1.id_equipe
JOIN EQUIPE e2 ON r.id_equipe_1 = e2.id_equipe
ORDER BY r.id_rencontre;
"""

df = pd.read_sql(query, conn)
conn.close()

# -------------------------------
# AFFICHAGE AVEC RICH
# -------------------------------

console = Console()

table = Table(title="⚽ Résultats des rencontres", show_lines=True)

table.add_column("ID", justify="center", style="bold")
table.add_column("Domicile", justify="left", style="cyan")
table.add_column("Score", justify="center", style="bold yellow")
table.add_column("Extérieur", justify="left", style="magenta")

for _, row in df.iterrows():
    # Mise en forme du score
    score = f"{row['score_domicile']} - {row['score_exterieur']}"

    # Couleur selon le résultat
    if row["score_domicile"] > row["score_exterieur"]:
        score_style = "bold green"
    elif row["score_domicile"] < row["score_exterieur"]:
        score_style = "bold red"
    else:
        score_style = "bold white"

    table.add_row(
        str(row["id_rencontre"]),
        row["equipe_domicile"],
        score,
        row["equipe_exterieur"],
        style=score_style
    )

console.print(table)
