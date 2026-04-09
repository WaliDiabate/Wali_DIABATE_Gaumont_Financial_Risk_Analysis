-- GAUMONT RELATIONAL SCHEMA (ELITE BUSINESS VERSION)

CREATE TABLE Director (
    director_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    nationality TEXT,
    popularity_score REAL -- Métrique TMDB (Notoriété du talent)
);

CREATE TABLE Film (
    film_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    production_budget REAL, 
    total_revenue REAL,      
    theme TEXT,              
    release_date DATE,
    letterboxd_rating REAL,  -- Note moyenne (Qualité perçue)
    review_count INTEGER     -- Nombre de reviews (Volume social)
);

-- Table de liaison pour la co-réalisation (Many-to-Many)
CREATE TABLE Film_Direction (
    film_id INTEGER,
    director_id INTEGER,
    PRIMARY KEY (film_id, director_id),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);

-- Suivi des performances hebdomadaires
CREATE TABLE Weekly_Entries (
    entry_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    week_number INTEGER,
    tickets_sold INTEGER, -- Volume d'entrées
    weekly_revenue REAL,  -- Recettes monétaires
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

-- Structure détaillée du financement
CREATE TABLE Financing (
    financing_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    source_type TEXT, -- e.g., 'Equity', 'Bank Loan', 'Tax Credit'
    amount REAL,
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

-- VUE STRATÉGIQUE FINALE : ROI, ENGAGEMENT & BANKABILITY
CREATE VIEW View_Gaumont_Business_Intelligence AS
SELECT 
    f.title,
    d.full_name AS director,
    d.popularity_score AS talent_notoriety,
    
    -- Calcul du ROI classique
    ((f.total_revenue - f.production_budget) / f.production_budget) AS ROI_Ratio,
    
    -- Calcul du Taux d'Engagement (Reviews Letterboxd / Total Entrées cumulées)
    -- On multiplie par 100 pour avoir un pourcentage
    (CAST(f.review_count AS REAL) / (SELECT SUM(tickets_sold) FROM Weekly_Entries WHERE film_id = f.film_id)) * 100 AS Engagement_Rate,
    
    -- Statut financier basé sur le ROI
    CASE 
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 3 THEN 'Blockbuster Hit'
        WHEN ((f.total_revenue - f.production_budget) / f.production_budget) > 0 THEN 'Profitable'
        ELSE 'Financial Risk'
    END AS financial_status

FROM Film f
JOIN Film_Direction fd ON f.film_id = fd.film_id
JOIN Director d ON fd.director_id = d.director_id;

-- Cette ligne permet de vérifier que la vue fonctionne
SELECT * FROM View_Gaumont_Business_Intelligence;
