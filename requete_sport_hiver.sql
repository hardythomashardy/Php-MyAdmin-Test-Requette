--------------------------------------------------------
-- A
--------------------------------------------------------

SELECT
    *
FROM
    clients
WHERE
    nom LIKE 'D__%';

--------------------------------------------------------
-- B
--------------------------------------------------------

SELECT
    nom,
    prenom
FROM
    clients

--------------------------------------------------------
-- C
--------------------------------------------------------

SELECT
    noFic,
    etat,
    clients.nom,
    clients.prenom
FROM
    fiches
INNER JOIN clients ON clients.noCli = fiches.noCli
WHERE
    clients.cpo LIKE '44%';

--------------------------------------------------------
-- D
--------------------------------------------------------

SELECT
    lignesfic.noFic,
    clients.nom,
    clients.prenom,
    lignesfic.refart,
    articles.designation,
    lignesfic.depart,
    lignesfic.retour,
    tarifs.prixJour,
    tarifs.prixJour*TIMESTAMPDIFF(day,depart,retour) AS Montant
FROM
    lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN grilletarifs ON articles.codeGam = grilletarifs.codeGam AND articles.codeCate = grilletarifs.codeCate
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif
WHERE lignesfic.noFic = 1006;

--------------------------------------------------------
-- E
--------------------------------------------------------

SELECT
    codeGam,
    ROUND(AVG(tarifs.prixJour),2)
FROM
    grilletarifs
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif
GROUP BY codeGam

--------------------------------------------------------
-- F
--------------------------------------------------------

SELECT
    articles.refart,
    articles.designation,
    COUNT(lignesfic.refart) AS NombreLocations
FROM
    articles
INNER JOIN lignesfic ON articles.refart = lignesfic.refart
GROUP BY lignesfic.refart
HAVING COUNT(lignesfic.refart) >= 3

--------------------------------------------------------
-- G
--------------------------------------------------------
SELECT
    'Fiche N°',
    lignesfic.noFic,
    '',
    '',
    '',
    ''
FROM
    lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN grilletarifs ON articles.codeGam = grilletarifs.codeGam AND articles.codeCate = grilletarifs.codeCate
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif
WHERE
    lignesfic.noFic = 1006
UNION
SELECT
    'NOM Prénom du client',
    clients.nom,
    clients.prenom,
    '',
    '',
    ''
FROM
    lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN grilletarifs ON articles.codeGam = grilletarifs.codeGam AND articles.codeCate = grilletarifs.codeCate
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif
WHERE
    lignesfic.noFic = 1006
UNION
SELECT
    lignesfic.refart,
    articles.designation,
    lignesfic.depart,
    lignesfic.retour,
    tarifs.prixJour,
    tarifs.prixJour * TIMESTAMPDIFF(DAY, depart, retour) AS Montant
FROM
    lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN grilletarifs ON articles.codeGam = grilletarifs.codeGam AND articles.codeCate = grilletarifs.codeCate
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif
WHERE
    lignesfic.noFic = 1006
UNION
SELECT
    '',
    '',
    '',
    '',
    'TOTAL',
    SUM(tarifs.prixJour*TIMESTAMPDIFF(day,depart,retour)) AS Total
    
FROM
    lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic
INNER JOIN clients ON fiches.noCli = clients.noCli
INNER JOIN articles ON lignesfic.refart = articles.refart
INNER JOIN grilletarifs ON articles.codeGam = grilletarifs.codeGam AND articles.codeCate = grilletarifs.codeCate
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif
WHERE
    lignesfic.noFic = 1006

--------------------------------------------------------
-- H
--------------------------------------------------------

SELECT
    codeGam,
    codeCate,
    tarifs.libelle,
    tarifs.prixJour
FROM
    grilletarifs
INNER JOIN tarifs ON grilletarifs.codeTarif = tarifs.codeTarif

--------------------------------------------------------
-- J
--------------------------------------------------------

SELECT
    COUNT(lignesfic.noLig)/COUNT(DISTINCT fiches.noFic) AS Moyenne
FROM
    lignesfic
INNER JOIN fiches ON lignesfic.noFic = fiches.noFic