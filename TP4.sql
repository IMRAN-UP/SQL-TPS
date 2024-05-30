USE gestion_film ;
-- 2.
SELECT * FROM acteur ;
SELECT idFilm , titre , annee 
FROM film 
ORDER BY titre ASC ;
-- 3.
SELECT * 
FROM film 
WHERE score >= 9 ;
-- 4.
SELECT titre , annee , score 
FROM film 
WHERE score > 100 ;
-- 5.
SELECT * 
FROM film 
WHERE titre LIKE "%the%" ;
-- 6.
SELECT * 
FROM film 
NATURAL JOIN distribution
NATURAL JOIN acteur 
WHERE film.idFilm = 11 ;
-- 7.
SELECT DISTINCT realisateur.nom 
FROM film 
NATURAL JOIN distribution
NATURAL JOIN realisateur 
WHERE film.annee > 1970 AND film.titre Like "%n" ;
-- 8.
SELECT acteur.idActeur , acteur.nom 
FROM film 
NATURAL JOIN distribution
NATURAL JOIN acteur 
WHERE film.annee = 2000 ORDER BY  acteur.nom ASC ;
-- 9.
SELECT idFilm , titre  
FROM film 
WHERE score = (SELECT max(score) FROM film ) ;
-- 10.
SELECT COUNT(realisateur.idRealisateur) 
FROM film 
NATURAL JOIN realisateur 
WHERE realisateur.idRealisateur = 11 ;
-- 11. 
SELECT realisateur.nom , count(film.idFilm) AS numberFilms 
FROM realisateur 
LEFT JOIN film ON film.idRealisateur = realisateur.idRealisateur 
GROUP BY realisateur.nom ;
-- 12.
SELECT film.idFilm , film.titre , count(distribution.idActeur) AS numberActeur 
FROM film 
LEFT JOIN distribution ON film.idFilm = distribution.idActeur 
GROUP BY film.titre ;
-- 13.
SELECT acteur.nom, COUNT(distribution.idFilm) AS numberFilm
FROM acteur
NATURAL JOIN distribution 
GROUP BY acteur.nom
HAVING COUNT(numberFilm) >= 5;
-- 14.
SELECT film.idFilm , film.titre , count(distribution.idActeur) AS numberActeur 
FROM film 
LEFT JOIN distribution ON film.idFilm = distribution.idActeur 
GROUP BY film.titre 
HAVING 1 = count(distribution.idActeur);
-- 15.
SELECT acteur.nom, COUNT(distribution.idFilm) AS numberFilm
FROM acteur
LEFT JOIN distribution ON acteur.idActeur = distribution.idActeur
GROUP BY acteur.nom
HAVING COUNT(distribution.idFilm) = 0 ;
-- 16.
SELECT acteur.idActeur , acteur.nom 
FROM distribution 
NATURAL JOIN acteur 
WHERE distribution.rang > 3 ;
-- 17.
SELECT realisateur.nom, COUNT(film.idFilm) AS numberFilms 
FROM realisateur 
LEFT JOIN film ON film.idRealisateur = realisateur.idRealisateur 
GROUP BY realisateur.nom 
HAVING COUNT(film.idFilm) = (
    SELECT MAX(film_count)
    FROM (
        SELECT COUNT(film.idFilm) AS film_count
        FROM realisateur 
        LEFT JOIN film ON film.idRealisateur = realisateur.idRealisateur
        GROUP BY realisateur.nom
    ) AS film_counts
);
-- 18.
CREATE VIEW V_Film_1999 AS SELECT film.idFilm , film.titre, film.annee , film.score , realisateur.nom 
FROM film NATURAL JOIN realisateur 
WHERE film.annee = 1999 ;
-- 19.
-- 2.19
SELECT idFilm , titre , annee 
FROM v_film_1999 
ORDER BY titre ASC ;
-- 3.19
SELECT * 
FROM v_film_1999  
WHERE score >= 9 ;
-- 4.19
SELECT titre , annee , score 
FROM v_film_1999 
WHERE score > 100 ;
-- 5.19
SELECT * 
FROM v_film_1999 
WHERE titre LIKE "%the%" ;
-- 20.
CREATE VIEW v_film_realisateur AS
SELECT * FROM
film NATURAL JOIN realisateur ;
-- 21.
-- you can't insert into a view 
SELECT * FROM v_film_1999;
INSERT INTO v_film_1999(Idfilm , titre , score , annee , nom) VALUES
(1000000,'game of thrones' , 9 , '2005-10-31','imrane')  ;
-- 22.
-- you can't insert into a view 
SELECT * FROM v_film_realisateur;
INSERT INTO v_film_realisateur(idRealisateur , nom , Idfilm , titre , score , annee) VALUES
(1000000,'imrane',1000000000,'game of thrones' , 9 , '2005-10-31')  ;
-- 23.
CREATE USER 'IMRANE'@'localhost' IDENTIFIED BY '0707';
-- 24.
GRANT SELECT ON gestion_film.v_film_1999 TO 'IMRANE'@'localhost';
USE gestion_film ;
-- 25.
SELECT * FROM v_film_1999 ;
SELECT * FROM v_film_realisateur ;
-- 26.
-- you can't insert into a view 
INSERT INTO v_film_realisateur(idRealisateur , nom , Idfilm , titre , score , annee) VALUES
(1000000,'imrane',1000000000,'game of thrones' , 9 , '2005-10-31')  ;
-- you can't insert into a view 
INSERT INTO v_film_1999(Idfilm , titre , score , annee , nom) VALUES
(1000000,'game of thrones' , 9 , '2005-10-31','imrane')  ;
GRANT SELECT ON gestion_film.v_film_realisateur TO 'IMRANE'@'localhost';
-- 27.
REVOKE SELECT ON gestion_film.v_film_1999 FROM 'IMRANE'@'localhost';

