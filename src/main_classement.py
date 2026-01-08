from services.classement import fetch_classement
from views.classement import display_classement


def main():
    df = fetch_classement()
    display_classement(df)


if __name__ == "__main__":
    main()