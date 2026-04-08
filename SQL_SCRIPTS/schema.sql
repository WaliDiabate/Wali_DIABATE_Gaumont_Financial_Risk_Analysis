-- GAUMONT RELATIONAL SCHEMA (OPTIMIZED)

CREATE TABLE Director (
    director_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    nationality TEXT
);

CREATE TABLE Film (
    film_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    production_budget REAL, -- Budget
    total_revenue REAL,      -- Recettes
    theme TEXT,              -- Thématique
    release_date DATE
);

-- Table de liaison pour la co-réalisation
CREATE TABLE Film_Direction (
    film_id INTEGER,
    director_id INTEGER,
    PRIMARY KEY (film_id, director_id),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);

-- Historisation des entrées semaine par semaine
CREATE TABLE Weekly_Entries (
    entry_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    week_number INTEGER,
    tickets_sold INTEGER,
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

-- Typer les sources de financement et montants
CREATE TABLE Financing (
    financing_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    source_type TEXT, -- e.g., 'CNC', 'TV Rights', 'Equity'
    amount REAL,
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

-- Vue SQL pour le calcul du ROI
CREATE VIEW View_Project_ROI AS
SELECT title, (total_revenue - production_budget) / production_budget AS ROI_Ratio
FROM Film;
