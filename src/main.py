from rich.console import Console
from rich.prompt import Prompt
from rich.panel import Panel

from services.service_classement import fetch_classement
from services.service_rencontres import fetch_rencontres
from views.view_classement import display_classement
from views.view_rencontres import display_rencontres


console = Console()


def show_menu():
    console.print(
        Panel.fit(
            "[bold cyan]Sport Manager[/bold cyan]\n\n"
            "1️⃣  Afficher le classement\n"
            "2️⃣  Afficher les rencontres\n"
            "0️⃣  Quitter",
            title="Menu principal"
        )
    )


def main():
    while True:
        show_menu()
        choice = Prompt.ask(
            "Votre choix",
            choices=["1", "2", "0"],
            default="0"
        )

        console.clear()

        if choice == "1":
            df = fetch_classement()
            display_classement(df)

        elif choice == "2":
            df = fetch_rencontres()
            display_rencontres(df)

        elif choice == "0":
            console.print("\n👋 Au revoir !", style="bold green")
            break

        console.print("\n[dim]Appuyez sur Entrée pour revenir au menu...[/dim]")
        input()
        console.clear()


if __name__ == "__main__":
    main()