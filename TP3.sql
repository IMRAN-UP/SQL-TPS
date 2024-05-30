-- 1.
CREATE DATABASE GESTION_BIBLIO ;
USE GESTION_BIBLIO ;
-- 2.
SELECT * FROM livre WHERE qte = 2 ;
SELECT * FROM livre  ;
-- 3.
SELECT * FROM livre WHERE titre = 'Unix' AND qte BETWEEN 5 AND 8 ;
-- 4.
SELECT titre , qte FROM livre  ;
-- 5.
SELECT titre , qte FROM livre WHERE qte > 5 ;
-- 6.
SELECT * FROM livre ORDER BY auteur DESC ; 
-- 7.
SELECT * FROM livre WHERE auteur LIKE '%n'; 
-- 8.
SELECT titre , auteur FROM livre WHERE titre LIKE '_a%'; 
-- 9.
SELECT titre , auteur FROM livre WHERE titre LIKE '____'; 
-- 10.
SELECT * FROM livre JOIN pret 
ON livre.num_livre = pret.num_livre where pret.date_pret = "2007-10-03";
-- 11.
SELECT distinct livre.titre FROM livre JOIN pret 
ON livre.num_livre = pret.num_livre ;
-- 12.
SELECT * FROM livre LEFT JOIN pret 
ON livre.num_livre = pret.num_livre 
WHERE pret.num_livre IS NULL ;
-- 13.
SELECT * FROM abonne WHERE quartier != (SELECT quartier FROM abonne WHERE nom = 'Benali') ;
-- 14.
SELECT distinct * FROM abonne JOIN abonne as ab 
ON abonne.nom = ab.nom WHERE abonne.num_abonne != ab.num_abonne ;
-- 15.
SELECT * FROM livre LEFT JOIN pret 
ON livre.num_livre = pret.num_livre 
WHERE pret.num_livre IS NULL ;
-- 16.
SELECT count(*) AS number_book FROM livre ;
-- 17.
SELECT * FROM pret ;
SELECT livre.* , DAY(pret.date_retour) - DAY(pret.date_pret) AS number_days FROM 
livre JOIN pret ON livre.num_livre = pret.num_livre group by pret.num_livre ;
-- 18.
SELECT abonne.* , count(abonne.num_abonne) as number_book FROM abonne  JOIN pret ON 
abonne.num_abonne = pret.num_abonne group by pret.num_abonne ;
-- 19.
SELECT livre.* , count(livre.num_livre) as fois_pret FROM livre  JOIN pret ON 
livre.num_livre = pret.num_livre group by pret.num_livre ;
-- 20.
SELECT titre FROM livre WHERE qte = ( SELECT max(qte) FROM livre ) ;