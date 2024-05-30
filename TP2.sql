USE commerce_gestion;
-- 1:
SELECT * FROM employe ;
-- 2:
SELECT * FROM employe WHERE Prenom = 'Ahmed' ;
-- 4. 
SELECT * FROM employe WHERE salaire > 4500;
-- 5. 
SELECT DISTINCT bureau FROM employe;
-- 6.
SELECT * FROM employe WHERE YEAR(Embauche) = 1993 ;
-- 7.
SELECT * FROM employe WHERE Nom LIKE "M%";
-- 8.
SELECT * FROM employe WHERE Prenom LIKE "___a";
-- 9.
SELECT * FROM employe WHERE Commission BETWEEN 2300 AND 4700 ORDER BY Commission ASC ;
-- 10.
SELECT * FROM employe WHERE Commission > 6000 ;
-- 11.
SELECT * FROM employe WHERE Permanence = 'oui' ORDER BY Permanence ASC; 
-- 12.
SELECT * FROM employe WHERE Bureau != 'Casa' ;
-- 13.
SELECT * FROM employe WHERE Poste = 'vendeur' AND Bureau = 'Safi';
-- 14.
SELECT * FROM employe WHERE Commission + Salaire > 4500 ;
-- 15.
SELECT * FROM employe WHERE Poste = "gérant" ;
SELECT * FROM employe WHERE Commentaire = "" ;
-- 16.
SELECT Num_employe , Prenom, Nom , Commission*1.2 AS New_Commission FROM employe WHERE Poste = "vendeur" ;
-- 17.
SELECT Num_employe , Prenom, Nom , year(current_date()) - year(Embauche) AS Diff_Year  FROM employe ;
-- 18.
INSERT INTO employe (Num_employe ,Nom, prenom, Poste) VALUES (8,'ADAM', 'CHEF', 'vendeur');
-- 19.
UPDATE employe SET salaire = 7000 WHERE Nom = 'Radi' AND Prenom = 'Ahmed' ;
-- 20.
DELETE FROM employe WHERE Nom = 'Idrissi' AND Prenom = 'Nabil' ;
-- 21.
SELECT facture.Num_facture , employe.Num_employe , facture.Date FROM facture JOIN employe 
ON employe.Num_employe = facture.Num_employe JOIN client 
ON client.Num_client = facture.Num_client 
WHERE client.Nom = 'Jad Imad' ;
-- 22.
SELECT * FROM employe JOIN facture ON 
employe.Num_employe =  facture.Num_employe WHERE 
facture.Date = '1999-11-27';
-- 23.
SELECT * FROM facture JOIN quantite_commandee ON
facture.Num_facture = quantite_commandee.Num_facture JOIN
produit ON produit.Num_produit = quantite_commandee.Num_produit
WHERE facture.Num_facture = 3;
-- 24.
SELECT employe.* FROM employe JOIN facture
ON employe.Num_employe = facture.Num_employe
WHERE facture.Num_facture = 2 ;
-- 25.
SELECT MAX(Salaire) AS max_salaire , MAX(commission) AS max_commission FROM employe ;
-- 26.
SELECT SUM(Salaire) AS revenu FROM employe WHERE Poste = 'gérant';
-- 27.
SELECT SUM(commission) AS revenu FROM employe WHERE Poste = 'vendeur';
-- 28.
SELECT Poste , SUM(Salaire) , SUM(commission) FROM employe group by Poste ;
-- 29.
SELECT Bureau ,Poste , SUM(Salaire) , SUM(commission) FROM employe group by Bureau , Poste  ;
-- 30.
SELECT COUNT(Bureau) AS number_employe , Bureau FROM employe group by Bureau ; 
-- 31.
SELECT COUNT(Poste) AS number_employe , Poste FROM employe group by Poste ; 
 -- 32.
 SELECT COUNT(Poste) AS number_employe1, COUNT(Bureau) AS number_employe , Poste ,Bureau FROM employe group by Poste , Bureau ; 


