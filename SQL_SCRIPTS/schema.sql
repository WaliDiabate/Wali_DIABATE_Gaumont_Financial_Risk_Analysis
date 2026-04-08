-- GAUMONT RELATIONAL SCHEMA (ULTIMATE VERSION)

CREATE TABLE Director (
    director_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    nationality TEXT,
    popularity_score REAL -- Ajout : Score TMDB/Première (ex: 525 pour Nolan)
);

CREATE TABLE Film (
    film_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    production_budget REAL, 
    total_revenue REAL,      
    theme TEXT,              
    release_date DATE,
    -- Ajout des métriques Letterboxd pour l'analyse de sentiment
    letterboxd_rating REAL,  -- Note moyenne sur 5
    review_count INTEGER     -- Volume de discussions (Popularité sociale)
);

-- Table de liaison (Gère la co-réalisation)
CREATE TABLE Film_Direction (
    film_id INTEGER,
    director_id INTEGER,
    PRIMARY KEY (film_id, director_id),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);

-- Historique hebdomadaire
CREATE TABLE Weekly_Entries (
    entry_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    week_number INTEGER,
    tickets_sold INTEGER,
    weekly_revenue REAL, -- Ajout pour plus de précision financière
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

-- Détails du financement
CREATE TABLE Financing (
    financing_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    source_type TEXT, 
    amount REAL,
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

-- VUE SQL FINALE : Analyse ROI vs Popularité (Le cerveau du projet)
CREATE VIEW View_Strategic_Analysis AS
SELECT 
    f.title,
    d.full_name AS director,
    d.popularity_score AS dir_popularity,
    f.letterboxd_rating AS audience_score,
    ((f.total_revenue - f.production_budget) / f.production_budget) AS ROI_Ratio,
    CASE 
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 2 THEN 'High Success'
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 0 THEN 'Profitable'
        ELSE 'Loss'
    END AS financial_status
FROM Film f
JOIN Film_Direction fd ON f.film_id = fd.film_id
JOIN Director d ON fd.director_id = d.director_id;
