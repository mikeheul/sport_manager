from rich.console import Console
from rich.table import Table
import pandas as pd

def display_classement(df: pd.DataFrame) -> None:
    """Affiche le classement sous forme de table formatée avec Rich."""
    console = Console()
    table = Table(title="🏆 Classement Ligue 1 — Saison 2025-2026")

    table.add_column("Équipe", style="bold cyan")
    table.add_column("MJ", justify="center")
    table.add_column("V", justify="center", style="green")
    table.add_column("N", justify="center", style="yellow")
    table.add_column("D", justify="center", style="red")
    table.add_column("BP", justify="center")
    table.add_column("BC", justify="center")
    table.add_column("GA", justify="center")
    table.add_column("Pts", justify="center", style="bold magenta")

    for index, row in df.iterrows():
        style = "bold green" if index < 3 else None

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