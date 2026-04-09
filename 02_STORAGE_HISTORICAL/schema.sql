-- ==========================================
-- 02 - STORAGE & HISTORICAL LAYER (SGBDR)
-- Type : Base de données Relationnelle 
-- ==========================================

CREATE TABLE DIRECTOR (
    director_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    nationality TEXT,
    popularity_score REAL -- Source: TMDB/Letterboxd (Le "Talent Notoriety")
);

CREATE TABLE FILM (
    film_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    production_budget REAL, -- Source: FactSet
    total_revenue REAL,      -- Source: CNC
    theme_topic TEXT,        -- Nom exact sur ton schéma
    release_date DATE,
    letterboxd_rating REAL,
    review_count INTEGER
);

-- Table Pivot pour la structure Many-to-Many
CREATE TABLE FILM_DIRECTION (
    film_id INTEGER,
    director_id INTEGER,
    PRIMARY KEY (film_id, director_id),
    FOREIGN KEY (film_id) REFERENCES FILM(film_id),
    FOREIGN KEY (director_id) REFERENCES DIRECTOR(director_id)
);

-- Renommé pour coller au schéma : WEEKLY_DIRECTION
CREATE TABLE WEEKLY_DIRECTION (
    entry_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    week_number INTEGER,
    tickets_sold INTEGER,
    weekly_revenue REAL,
    FOREIGN KEY (film_id) REFERENCES FILM(film_id)
);

-- Table Financing (Source: FactSet / Financing sur ton schéma)
CREATE TABLE FINANCING (
    financing_id INTEGER PRIMARY KEY,
    film_id INTEGER,
    source_type TEXT, 
    amount REAL,
    FOREIGN KEY (film_id) REFERENCES FILM(film_id)
);
