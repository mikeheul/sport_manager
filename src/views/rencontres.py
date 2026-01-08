from rich.console import Console
from rich.table import Table
import pandas as pd

def display_rencontres(df: pd.DataFrame):
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