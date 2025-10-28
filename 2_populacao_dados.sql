-- Agora cabe popular as tabelas --
INSERT INTO Movies
(id_movie, type, title, date_added, release_year, rating, duration, description)
SELECT 
	show_id,
    type,
    title,
    date_added,
    CAST(release_year AS SIGNED),
    rating,
    duration,
    description
FROM Netflix_Dados_Brutos
WHERE LENGTH(release_year) =4;

-- Para ficar num formato mais correto quis alterar o tipo de dados da data --

ALTER TABLE Movies ADD COLUMN data_convertida DATE;

UPDATE Movies
SET data_convertida= STR_TO_DATE(TRIM(date_added), '%M %d, %Y')
WHERE STR_TO_DATE(TRIM(date_added), '%M %d, %Y') IS NOT NULL;

ALTER TABLE Movies DROP COLUMN date_added;
ALTER TABLE Movies RENAME COLUMN data_convertida TO date_added;

INSERT INTO Director
(director_name)
SELECT DISTINCT director
FROM Netflix_Dados_Brutos
WHERE director IS NOT NULL AND director!='';

INSERT INTO Cast
(actor_name)
SELECT DISTINCT cast
FROM Netflix_Dados_Brutos
WHERE cast IS NOT NULL AND cast!='';

INSERT INTO Country
(country_name)
SELECT DISTINCT country
FROM Netflix_Dados_Brutos
WHERE country IS NOT NULL AND country!='';

INSERT INTO Genres
(genre_name)
SELECT DISTINCT listed_in
FROM Netflix_Dados_Brutos
WHERE listed_in IS NOT NULL AND listed_in!='';

INSERT INTO Director_Movies
(id_movie, id_director)
SELECT m.id_movie, d.id_director
FROM Netflix_Dados_Brutos AS db
JOIN Director AS d ON d.director_name=db.director
JOIN Movies AS m ON m.id_movie=db.show_id
WHERE db.director IS NOT NULL AND db.director!='';

INSERT INTO Cast_Movies
(id_movie, id_cast)
SELECT m.id_movie, c.id_cast
FROM Netflix_Dados_Brutos AS db
JOIN Movies AS m ON m.id_movie=db.show_id
JOIN Cast AS c ON c.actor_name=db.cast
WHERE db.cast IS NOT NULL AND db.cast!='';

INSERT INTO Country_Movies
(id_movie, id_country)
SELECT m.id_movie, c.id_country
FROM Netflix_Dados_Brutos AS db
JOIN Movies AS m ON m.id_movie=db.show_id
JOIN Country AS c ON c.country_name=db.country
WHERE db.country IS NOT NULL AND db.country!=''; 

INSERT INTO Genres_Movies
(id_movie, id_genre)
SELECT m.id_movie, g.id_genre
FROM Netflix_Dados_Brutos AS db
JOIN Movies AS m ON m.id_movie=db.show_id
JOIN Genres AS g ON g.genre_name=db.listed_in
WHERE listed_in IS NOT NULL AND listed_in!='';








