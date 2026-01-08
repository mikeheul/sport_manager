from rich.console import Console
from rich.progress import BarColumn, Progress
from services.classement import fetch_classement

df = fetch_classement()
console = Console()

max_points = df["points"].max()

console.print("[bold cyan]Classement Ligue 1[/bold cyan]")
for index, row in df.iterrows():
    bar_length = int(row["points"] / max_points * 20)  # 20 caractères max
    bar = "█" * bar_length
    console.print(f"{row['nom_equipe']:15} | {bar} {row['points']} pts")