import sqlite3
import pandas as pd

# Connexion à la base Gaumont
conn = sqlite3.connect('gaumont_database.db')

# Appel de la vue SQL "Elite" que nous avons créée
query = "SELECT * FROM View_Gaumont_Business_Intelligence"
df = pd.read_sql_query(query, conn)

# --- STATISTIQUES RAPIDES ---
print("=== ANALYSE DE PERFORMANCE GAUMONT ===")
print(f"ROI Moyen du catalogue : {df['ROI_Ratio'].mean():.2f}")
print(f"Engagement moyen (Letterboxd) : {df['Engagement_Rate'].mean():.2f}%")

# Identification du Top Film
top_film = df.loc[df['ROI_Ratio'].idxmax()]
print(f"\nFilm le plus rentable : {top_film['title']} ({top_film['financial_status']})")

conn.close()
