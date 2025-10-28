-- 1) Quais são os 10 diretores com maior números de filmes ou séries no catálogo da Netflix? --

SELECT director_name, COUNT(id_movie) AS n_filmes
FROM Director AS d
JOIN Director_Movies AS dm ON dm.id_director=d.id_director
GROUP BY director_name 
ORDER BY n_filmes DESC
LIMIT 10;

-- 2) Qual foi o mês e o ano em que a Netflix adicionou mais conteúdo ao seu catálogo? --

SELECT YEAR(date_added), MONTH(date_added), COUNT(id_movie) AS total_filmes
FROM Movies
GROUP BY YEAR(date_added), MONTH(date_added)
ORDER BY total_filmes DESC
LIMIT 1;

-- 3) Qual a duração média, em minutos, dos filmes(apenas tipo Movie) por cada ano de lançamento?

SELECT 
	release_year,
	AVG(CAST(REPLACE(duration, ' min ', '')AS SIGNED)) AS duracao_media
FROM Movies
WHERE type = 'Movie' AND duration LIKE '%min'
GROUP BY release_year
ORDER BY release_year ASC;

-- 4) Proporção de filmes vs séries no catálogo --

SELECT type, COUNT(id_movie) AS total
FROM Movies
GROUP BY type;

-- 5) Qual o elenco com mais obras no catálogo? --

SELECT actor_name, count(id_movie) AS total_filmes
FROM Cast AS c
JOIN Cast_Movies AS cm ON c.id_cast=cm.id_cast
GROUP BY actor_name
ORDER BY total_filmes DESC
LIMIT 10;

-- 6) Como evoluiu o número de lançamentos de conteúdo ao longo dos anos? --

SELECT release_year, COUNT(id_movie) AS total_conteudo
FROM Movies
GROUP BY release_year
ORDER BY release_year DESC;

-- 7) Qual é a distribuição do conteúdo pela classificação etária? --

SELECT rating, COUNT(id_movie) AS total_conteudo
FROM Movies
WHERE rating IS NOT NULL AND rating !=''
GROUP BY rating
ORDER BY total_conteudo DESC;




