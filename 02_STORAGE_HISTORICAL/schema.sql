-- ==========================================
-- 02 - STORAGE & HISTORICAL LAYER (SGBDR)
-- Type : Base de données Relationnelle 
-- ==========================================

CREATE TABLE Director (
    director_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    nationality TEXT,
    popularity_score REAL -- Source: TMDB/Letterboxd
);

CREATE TABLE Film (
    film_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    production_budget REAL, -- Source: FactSet
    total_revenue REAL,      -- Source: CNC
    theme TEXT,               
    release_date DATE,
    letterboxd_rating REAL,
    review_count INTEGER
);

-- Table Pivot pour la structure Many-to-Many
CREATE TABLE Film_Direction (
    film_id INTEGER,
    director_id INTEGER,
    PRIMARY KEY (film_id, director_id),
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);

CREATE TABLE Weekly_Entries (
    entry_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    week_number INTEGER,
    tickets_sold INTEGER,
    weekly_revenue REAL,
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);

CREATE TABLE Financing (
    financing_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    source_type TEXT, 
    amount REAL,
    FOREIGN KEY (film_id) REFERENCES Film(film_id)
);
