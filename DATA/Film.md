# 📊 Data Pipeline & Sources

Pour garantir la fiabilité de l'outil de décision Gaumont, les données sont extraites des sources professionnelles suivantes :

* **Financials (Revenue/Budget) :** `FactSet` / `Bloomberg API` (Données certifiées).
* **Talent Notoriety :** `TMDB API` (Popularity Score mis à jour en temps réel).
* **Social Sentiment :** `Letterboxd` = https://letterboxd.com (Scraping/API pour le Rating et Review Count).
* **Box-Office :** `CNC` / `Comscore` (Entrées hebdomadaires).

> **Note technique :** Les IDs de la base de données sont alignés sur les standards TMDB pour permettre une synchronisation automatisée via API.
