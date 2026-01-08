from services.service_rencontres import fetch_rencontres
from views.view_rencontres import display_rencontres


def main():
    df = fetch_rencontres()
    display_rencontres(df)


if __name__ == "__main__":
    main()