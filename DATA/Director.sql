CREATE TABLE Film_Direction (
    film_id INTEGER,
    director_id INTEGER,
    role VARCHAR(50) DEFAULT 'Director', -- Optionnel : permet de distinguer Co-Director / Lead Director
    PRIMARY KEY (film_id, director_id), -- Clé primaire composée : un duo film-réalisateur est unique
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);
