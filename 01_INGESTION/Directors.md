# 🎬 Sources : Réalisateurs & Talents
Ce module capture les données relatives aux créatifs pour mesurer leur influence sur le succès d'un film.

* **Origine :** TMDB API (The Movie Database) & IMDb Pro.
* **Données récupérées :**
    * `full_name` : Identité du talent.
    * `popularity_score` : Score dynamique basé sur les recherches et l'actualité.
    * `notoriety_index` : Classement presse.

**Objectif SGBD :** Alimenter la table `Director` pour corréler la notoriété du réalisateur avec le ROI final.
