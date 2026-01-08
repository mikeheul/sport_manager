import seaborn as sns                     # Importe la bibliothèque Seaborn, qui facilite la création de graphiques statistiques
import matplotlib.pyplot as plt           # Importe le module pyplot de Matplotlib pour gérer les figures, axes et affichage
from services.classement import fetch_classement  # Importe la fonction fetch_classement() qui récupère les données du classement depuis la base

def display_graphique(df):                # Définition d'une fonction qui prend un DataFrame Pandas en entrée et affiche un graphique

# Créer un barplot : points par équipe
    plt.figure(figsize=(10,6))           # Crée une nouvelle figure de graphique de taille 10 pouces x 6 pouces
    sns.barplot(x="points", y="nom_equipe", data=df, palette="viridis")  
                                          # Crée un graphique à barres horizontales
                                          # x = nombre de points, y = noms des équipes
                                          # data=df indique la source des données
                                          # palette="viridis" applique une palette de couleurs dégradée

    plt.title("Classement Ligue 1 – Saison 2025-2026")  
                                          # Ajoute un titre au graphique
    plt.xlabel("Points")                  # Ajoute un label à l’axe horizontal
    plt.ylabel("Équipe")                  # Ajoute un label à l’axe vertical
    plt.tight_layout()                    # Ajuste automatiquement l’espacement pour que les labels, titres et barres ne se chevauchent pas
    plt.show()                            # Affiche le graphique dans une fenêtre interactive