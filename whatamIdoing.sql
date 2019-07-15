CREATE DATABASE sports_hiver;

CREATE TABLE articles (
  refart char(8) NOT NULL,
  designation varchar(80) NOT NULL,
  codeGam char(5) NOT NULL,
  codeCate char(5) NOT NULL,
  PRIMARY KEY (refart),
  FOREIGN KEY (codeGam) REFERENCES grilletarifs(codeGam),
  FOREIGN KEY (codeCate) REFERENCES grilletarifs(codeCate)
)


CREATE TABLE categories (
  codeCate char(5) NOT NULL,
  libelle varchar(30) NOT NULL,
  PRIMARY KEY (codeCate),
  UNIQUE (libelle)
)


CREATE TABLE client (
  noCli int(6) NOT NULL,
  nom varchar(30) NOT NULL,
  prenom varchar(30) NOT NULL,
  adresse varchar(120) NOT NULL,
  cpo char(5) NOT NULL,
  ville varchar(80) NOT NULL DEFAULT 'Nantes',
  PRIMARY KEY (noCli)
)


CREATE TABLE fiches (
  noFic int(6) NOT NULL,
  noCli int(6) NOT NULL,
  dateCrea timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  datePaye timestamp NULL DEFAULT NULL,
  etat ENUM ('EC','RE','SO','') NOT NULL DEFAULT 'EC',
  PRIMARY KEY (noFic),
  FOREIGN KEY fk_client_in_fiches (noCli) REFERNCES client(noCli)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE gammes (
  codeGam char(5) NOT NULL,
  libelle varchar(30) NOT NULL,
  PRIMARY KEY (codeGam),
  UNIQUE KEY libelle (libelle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE grilletarifs (
  codeGam char(5) NOT NULL,
  codeCate char(5) NOT NULL,
  codeTarif char(5) NOT NULL,
  PRIMARY KEY (codeGam,codeCate),
  KEY codeCate (codeCate),
  KEY FK_tarifs_in_grilletarifs (codeTarif)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE lignesfic (
  noFic int(6) NOT NULL,
  noLig int(3) NOT NULL,
  refart char(8) NOT NULL,
  depart timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, --NOTE: don't actually use timestamps, they're bad.
  retour timestamp NULL DEFAULT NULL,
  PRIMARY KEY (noFic,noLig),
  KEY FK_articles_in_lignesfic (refart)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE tarifs (
  codeTarif char(5) NOT NULL,
  libelle varchar(30) NOT NULL,
  prixJour decimal(5,2) NOT NULL,
  PRIMARY KEY (codeTarif),
  UNIQUE KEY libelle (libelle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO client
VALUES (1, 'Albert', 'Anatole', 'Rue des accacias', 61000, 'Amiens'),
(2, 'Bernard', 'Barnabé', 'Rue du Bar', 01000, 'Bourg en Bresse'),
(3, 'Dupond', 'Camille', 'Rue Crébillon', 44000, 'Nantes'),
(4, 'Desmoulin', 'Daniel', 'Rue descendante', 21000, 'Dijon'),
(5, 'Ernest', 'Etienne', "Rue de l'échafaud", 42000, 'Saint Etienne'),
(6, 'Ferdinand', 'François', 'Rue de la convention', 44100, 'Nantes'),
(9, 'Dupond', 'Jean', 'Rue des mimosas', 75018, 'Paris'),
(14, 'Boutaud', 'Sabine', 'Rue des platanes', 75002, 'Paris')

--requests--

SELECT * FROM client WHERE LEFT(nom, 1) = 'D' 

SELECT nom, prenom FROM client

SELECT noFic, etat, nom, prenom FROM client INNER JOIN fiches ON client.noCli = fiches.noCli WHERE LEFT(cpo, 2) = '44' 

SELECT fiches.noFic, nom, prenom, articles.refart, designation, depart, retour, prixJour
FROM (((((client
JOIN fiches ON client.noCli = fiches.noCli)
JOIN lignesfic ON fiches.noFic = lignesfic.noFic)
JOIN articles ON lignesfic.refart = articles.refart)
JOIN grilletarifs ON ((articles.codeGam = grilletarifs.codeGam) & (articles.codeCate = grilletarifs.codeCate)))
JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif)
WHERE fiches.noFic = 1006

SELECT codeGam, AVG(prixJour) FROM grilletarifs JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif GROUP BY codeGam

SELECT articles.refart, designation, COUNT(noLig) AS nbrLocation
FROM (lignesfic
JOIN articles ON lignesfic.refart = articles.refart)
GROUP BY articles.refart
HAVING nbrLocation >= 3

SELECT codeGam, codeCate, grilletarifs.codeTarif, prixJour
FROM (grilletarifs
JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif)

SELECT COUNT(noLig) AS Nombre_de_locations, articles.refart, designation
FROM (lignesfic
JOIN articles ON lignesfic.refart = articles.refart)
WHERE codeCate = SURF
--will only display one line--

SELECT AVG(NbArticles)
FROM(
SELECT MAX(noLig)AS NbArticles --alias to link names--
FROM lignesfic
GROUP BY noFic) AS NbArticlesTable --needs an alias or it bugs out--

SELECT COUNT(noFic), libelle
FROM lignesfic
JOIN articles ON lignesfic.refart = articles.refart
JOIN categories ON articles.codeCate = categories.codeCate
WHERE categories.libelle IN ('Ski alpin','Patinette','Surf')
GROUP BY libelle

SELECT nom, prenom, cpo, ville
FROM client
JOIN fiches ON fiches.noCli = client.noCli
WHERE fiches.etat != 'SO'

SELECT articles.designation, lignesfic.depart, lignesfic.retour
FROM lignesfic
JOIN fiches ON lignesfic.noFic = fiches.noFic
JOIN client ON fiches.noCli = client.noCli
JOIN articles ON articles.refart = lignesfic.refart
WHERE client.nom = 'Dupond' AND client.prenom = 'Jean' AND client.ville = 'Paris'

SELECT designation, refart, libelle
FROM articles
JOIN categories ON categories.codeCate = articles.codeCate
WHERE INSTR(libelle, 'ski')>0

SELECT COUNT(noLig)
FROM lignesfic
JOIN fiches ON fiches.noFic = lignesfic.noFic
WHERE etat != 'SO'

SELECT COUNT(noLig), nom, prenom
FROM lignesfic
JOIN fiches ON fiches.noFic = lignesfic.noFic
JOIN client ON client.noCli = fiches.noCli
GROUP BY client.noCli

SELECT COUNT(noLig), articles.refart
FROM lignesfic
JOIN articles ON articles.refart = lignesfic.refart
GROUP BY articles.refart
ORDER BY COUNT(noLig)