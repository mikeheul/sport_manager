import seaborn as sns
import matplotlib.pyplot as plt
from services.classement import fetch_classement

def display_graphique(df):

    # Créer un barplot : points par équipe
    plt.figure(figsize=(10,6))
    sns.barplot(x="points", y="nom_equipe", data=df, palette="viridis")

    plt.title("Classement Ligue 1 – Saison 2025-2026")
    plt.xlabel("Points")
    plt.ylabel("Équipe")
    plt.tight_layout()
    plt.show()