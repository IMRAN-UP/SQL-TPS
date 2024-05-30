CREATE DATABASE Gestion_Scolaire;

USE Gestion_Scolaire;

CREATE TABLE Professeur (
    IdProf INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Tel VARCHAR(15),
    Specialite VARCHAR(100)
);

CREATE TABLE Etudiant (
    IdEtudiant INT PRIMARY KEY,
    CIN VARCHAR(10),
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Tel VARCHAR(15),
    Ville VARCHAR(50)
);

CREATE TABLE Cours (
    IdCours INT PRIMARY KEY,
    Intitule VARCHAR(100),
    Niveau VARCHAR(50),
    IdProf INT,
    FOREIGN KEY (IdProf) REFERENCES Professeur (IdProf) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Inscription (
    IdEtudiant INT,
    IdCours INT,
    DateInscription DATE,
    PRIMARY KEY (IdEtudiant, IdCours),
    FOREIGN KEY (IdEtudiant) REFERENCES Etudiant (IdEtudiant) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (IdCours) REFERENCES Cours (IdCours) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Evaluation (
    IdEtudiant INT,
    IdCours INT,
    Note DECIMAL(3, 2),
    PRIMARY KEY (IdEtudiant, IdCours),
    FOREIGN KEY (IdEtudiant) REFERENCES Etudiant (IdEtudiant) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (IdCours) REFERENCES Cours (IdCours) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE Bibliotheque (
    IdLivre INT PRIMARY KEY,
    Titre VARCHAR(100),
    Auteur VARCHAR(100),
    QTE INT
);

CREATE TABLE Emprunt (
    IdLivre INT,
    IdEtudiant INT,
    DateEmprunt DATE,
    DateRetour DATE,
    PRIMARY KEY (IdLivre, IdEtudiant),
    FOREIGN KEY (IdLivre) REFERENCES Bibliotheque (IdLivre) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (IdEtudiant) REFERENCES Etudiant (IdEtudiant) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO Professeur (IdProf, Nom, Prenom, Tel, Specialite)
VALUES(
        1,
        'Dupont',
        'Jean',
        '0612345678',
        'Mathematiques'
    ),
(2, 'Martin', 'Marie', '0698765432', 'Physique');

INSERT INTO
    Etudiant (
        IdEtudiant,
        CIN,
        Nom,
        Prenom,
        Tel,
        Ville
    )
VALUES (
        1,
        'C123456',
        'Durand',
        'Pierre',
        '0612345678',
        'Paris'
    ),
    (
        2,
        'C789012',
        'Leroy',
        'Sophie',
        '0698765432',
        'Lyon'
    );

INSERT INTO
    Cours (
        IdCours,
        Intitule,
        Niveau,
        IdProf
    )
VALUES (1, 'Algebre', 'L1', 1),
    (2, 'Mecanique', 'L2', 2);

INSERT INTO
    Inscription (
        IdEtudiant,
        IdCours,
        DateInscription
    )
VALUES (1, 1, '2024-01-10'),
    (2, 2, '2024-01-12');

INSERT INTO
    Evaluation (IdEtudiant, IdCours, Note)
VALUES (1, 1, 15.5),
    (2, 2, 12.0);

INSERT INTO
    Bibliotheque (IdLivre, Titre, Auteur, QTE)
VALUES (
        1,
        'SQL pour les Nuls',
        'Author1',
        3
    ),
    (
        2,
        'Apprendre MySQL',
        'Author2',
        5
    );

INSERT INTO
    Emprunt (
        IdLivre,
        IdEtudiant,
        DateEmprunt,
        DateRetour
    )
VALUES (
        1,
        1,
        '2024-05-01',
        '2024-05-15'
    ),
    (2, 2, '2024-05-10', NULL);

-- 6.
SELECT Etudiant.Nom , Etudiant.Prenom 
FROM Etudiant 
NATURAL JOIN Cours ;
-- 7.
UPDATE Etudiant SET Tel = '0623456789' WHERE IdEtudiant = 1 ;
-- 8.
DELETE FROM Etudiant WHERE IdEtudiant = 1 ;
-- 9.
CREATE VIEW V_Prof_Cours  AS SELECT Professeur.Nom , Professeur.Prenom , CourS.Intitule
FROM Professeur 
NATURAL JOIN Cours ;
-- 10
SELECT * FROM v_prof_cours ;
-- 12.
ALTER TABLE etudiant ADD COLUMN Email VARCHAR(100) ;
-- 13.
ALTER TABLE etudiant CHANGE Tel Telephone VARCHAR(15) ;
-- 14.
SELECT * FROM etudiant WHERE Ville  = 'Paris' ;
-- 15.
SELECT * FROM Etudiant 
NATURAL JOIN evaluation 
WHERE evaluation.Note >= 15 ;
-- 16.
SELECT * FROM professeur ORDER BY Nom ASC ;
-- 17.
SELECT Cours.Intitule , SUM(evaluation.Note) / COUNT(evaluation.Note) AS Moyenne 
FROM Cours 
NATURAL JOIN evaluation 
GROUP BY Cours.Intitule ;
-- 18.
SELECT titre , QTE FROM bibliotheque ;
-- 19.
SELECT Titre FROM bibliotheque WHERE Auteur = '%n'; 
-- 20.
SELECT * FROM emprunt 
NATURAL JOIN bibliotheque 
WHERE emprunt.DateEmprunt = '2024-05-01';
-- 21.
SELECT * FROM emprunt 
NATURAL JOIN etudiant ;
-- 22.
SELECT count(IdLivre) FROM bibliotheque AS number_of_books ;
-- 23.
SELECT etudiant.Nom , DAY(emprunt.DateRetour) - DAY(emprunt.DateEmprunt) 
FROM emprunt 
NATURAL JOIN etudiant ;
-- 24.
SELECT * 
FROM etudiant 
LEFT JOIN emprunt 
ON etudiant.IdEtudiant = emprunt.IdEtudiant 
WHERE emprunt.IdEtudiant IS NULL;
-- 25.
SELECT * FROM etudiant 
JOIN etudiant AS et 
ON etudiant.Nom = et.Nom
WHERE etudiant.IdEtudiant != et.IdEtudiant ;

-- 26.
DELETE FROM emprunt WHERE IdLivre = 1 ;
-- 27.
SELECT * FROM professeur WHERE Specialite = 'Mathematiques' ;
-- 29.
INSERT INTO professeur VALUES (3, 'Bernard', 'Alice', '0611122233', 'Informatique') ;
-- 30.
SELECT Professeur.* , COUNT(IdCours) AS number_of_courses FROM 
Cours NATURAL JOIN
professeur
GROUP BY professeur.Nom ;
