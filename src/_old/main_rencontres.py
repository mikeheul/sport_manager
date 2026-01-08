from services.rencontres import fetch_rencontres
from views.rencontres import display_rencontres


def main():
    df = fetch_rencontres()
    display_rencontres(df)


if __name__ == "__main__":
    main()