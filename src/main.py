from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel

from rich.spinner import Spinner
from rich.live import Live 

from services.classement import fetch_classement
from services.rencontres import fetch_rencontres
from views.classement import display_classement
from views.rencontres import display_rencontres
from views.graphique import display_graphique

import time

console = Console()


def show_menu():
    console.print(
        Panel.fit(
            "[bold cyan]Sport Manager[/bold cyan]\n\n"
            "1️⃣  Afficher le classement\n"
            "2️⃣  Afficher les rencontres\n"
            "3️⃣  Afficher le graphique du classement\n"
            "0️⃣  Quitter",
            title="Menu principal"
        )
    )


def main():
    while True:
        show_menu()
        choice = Prompt.ask(
            "Votre choix",
            choices=["1", "2", "3", "0"],
            default="0"
        )

        console.clear()

        # Spinners : dots, line, bouncingBall, earth, moon

        if choice == "1":
            with console.status("[bold green]Chargement du classement...", spinner="dots"):
                time.sleep(1.5)  
                df = fetch_classement()
                display_classement(df)

        elif choice == "2":
            with console.status("[bold green]Chargement des rencontres...", spinner="dots"):
                time.sleep(1.5)  
                df = fetch_rencontres()
                display_rencontres(df)
        
        elif choice == "3":
            with console.status("[bold green]Chargement du graphique...", spinner="dots"):
                time.sleep(1.5)
                df = fetch_classement()
                display_graphique(df)

        elif choice == "0":
            console.print("\n👋 Au revoir !", style="bold green")
            break

        console.print("\n[dim]Appuyez sur Entrée pour revenir au menu...[/dim]")
        input()
        console.clear()


if __name__ == "__main__":
    main()