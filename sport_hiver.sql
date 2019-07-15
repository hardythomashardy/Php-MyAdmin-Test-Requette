-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  lun. 15 juil. 2019 à 14:08
-- Version du serveur :  5.7.23
-- Version de PHP :  7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `sport_hiver`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `refart` char(8) NOT NULL,
  `designation` varchar(80) NOT NULL,
  `codeGam` char(5) NOT NULL,
  `codeCate` char(5) NOT NULL,
  PRIMARY KEY (`refart`),
  KEY `FK_articles_grille_tarifs` (`codeGam`),
  KEY `FK_articles_grille_tarifs_2` (`codeCate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`refart`, `designation`, `codeGam`, `codeCate`) VALUES
('A01', 'Salomon 24X+Z12', 'EG', 'SA'),
('A02', 'Salomon 24X+Z12', 'EG', 'SA'),
('A03', 'Salomon 24X+Z12', 'EG', 'SA'),
('A04', 'Salomon 24X+Z12', 'EG', 'SA'),
('A05', 'Salomon 24X+Z12', 'EG', 'SA'),
('A10', 'Salomon Pro Link Equipe 4S', 'PR', 'SA'),
('A11', 'Salomon Pro Link Equipe 4S', 'PR', 'SA'),
('A21', 'Salomon 3V RACE JR+L10', 'PR', 'SA'),
('F01', 'Fischer Cruiser', 'EG', 'FOA'),
('F02', 'Fischer Cruiser', 'EG', 'FOA'),
('F03', 'Fischer Cruiser', 'EG', 'FOA'),
('F04', 'Fischer Cruiser', 'EG', 'FOA'),
('F05', 'Fischer Cruiser', 'EG', 'FOA'),
('F10', 'Fischer Sporty Crown', 'MG', 'FOA'),
('F20', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
('F21', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
('F22', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
('F23', 'Fischer RCS Classic GOLD', 'PR', 'FOA'),
('F50', 'Fischer SOSSkating VASA', 'HG', 'FOP'),
('F60', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
('F61', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
('F62', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
('F63', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
('F64', 'Fischer RCS CARBOLITE Skating', 'PR', 'FOP'),
('P01', 'Décathlon Allegre junior 150', 'EG', 'PA'),
('P10', 'Fischer mini ski patinette', 'MG', 'PA'),
('P11', 'Fischer mini ski patinette', 'MG', 'PA'),
('S01', 'Décathlon Apparition', 'EG', 'SURF'),
('S02', 'Décathlon Apparition', 'EG', 'SURF'),
('S03', 'Décathlon Apparition', 'EG', 'SURF');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `codeCate` char(5) NOT NULL,
  `libelle` varchar(30) NOT NULL,
  PRIMARY KEY (`codeCate`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`codeCate`, `libelle`) VALUES
('MONO', 'Monoski'),
('PA', 'Patinette'),
('SA', 'Ski alpin'),
('FOA', 'Ski de fond alternatif'),
('FOP', 'Ski de fond patineur'),
('SURF', 'Surf');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `noCli` int(6) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) DEFAULT NULL,
  `adresse` varchar(120) DEFAULT NULL,
  `cpo` char(5) NOT NULL,
  `ville` varchar(80) NOT NULL DEFAULT 'Nantes',
  PRIMARY KEY (`noCli`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`noCli`, `nom`, `prenom`, `adresse`, `cpo`, `ville`) VALUES
(1, 'Albert', 'Anatole', 'Rue des accacias', '61000', 'Amiens'),
(2, 'Bernard', 'Barnabé', 'Rue du bar', '1000', 'Bourg en Bresse'),
(3, 'Dupond', 'Camille', 'Rue Crébillon', '44000', 'Nantes'),
(4, 'Desmoulin', 'Daniel', 'Rue descendante', '21000', 'Dijon'),
(5, 'Ernest', 'Etienne', 'Rue de l’échaffaud', '42000', 'Saint Étienne'),
(6, 'Ferdinand', 'François', 'Rue de la convention', '44100', 'Nantes'),
(9, 'Dupond', 'Jean', 'Rue des mimosas', '75018', 'Paris'),
(14, 'Boutaud', 'Sabine', 'Rue des platanes', '75002', 'Paris');

-- --------------------------------------------------------

--
-- Structure de la table `fiches`
--

DROP TABLE IF EXISTS `fiches`;
CREATE TABLE IF NOT EXISTS `fiches` (
  `noFic` int(6) NOT NULL AUTO_INCREMENT,
  `noCli` int(6) DEFAULT NULL,
  `dateCrea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datePaye` datetime DEFAULT NULL,
  `etat` char(2) NOT NULL DEFAULT 'EC',
  PRIMARY KEY (`noFic`),
  KEY `FK_fiches_clients` (`noCli`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `fiches`
--

INSERT INTO `fiches` (`noFic`, `noCli`, `dateCrea`, `datePaye`, `etat`) VALUES
(1001, 14, '2019-07-15 13:24:50', '2019-07-15 00:00:00', 'SO'),
(1002, 4, '2019-07-15 13:24:50', NULL, 'EC'),
(1003, 1, '2019-07-15 13:24:50', '2019-07-15 00:00:00', 'SO'),
(1004, 6, '2019-07-15 13:24:50', NULL, 'EC'),
(1005, 3, '2019-07-15 13:24:50', NULL, 'EC'),
(1006, 9, '2019-07-15 13:24:50', NULL, 'RE'),
(1007, 1, '2019-07-15 13:24:50', NULL, 'EC'),
(1008, 2, '2019-07-15 13:24:50', NULL, 'EC');

-- --------------------------------------------------------

--
-- Structure de la table `gammes`
--

DROP TABLE IF EXISTS `gammes`;
CREATE TABLE IF NOT EXISTS `gammes` (
  `codeGam` char(5) NOT NULL,
  `libelle` varchar(30) NOT NULL,
  PRIMARY KEY (`codeGam`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `gammes`
--

INSERT INTO `gammes` (`codeGam`, `libelle`) VALUES
('EG', 'Entrée de gamme'),
('HG', 'Haut de gamme'),
('PR', 'Matériel Professionnel'),
('MG', 'Moyenne gamme');

-- --------------------------------------------------------

--
-- Structure de la table `grille_tarifs`
--

DROP TABLE IF EXISTS `grille_tarifs`;
CREATE TABLE IF NOT EXISTS `grille_tarifs` (
  `codeGam` char(5) NOT NULL,
  `codeCate` char(5) NOT NULL,
  `codeTarif` char(5) NOT NULL,
     PRIMARY KEY (`codeGam`,`codeCate`),
  KEY `FK_grilleTarifs_gammes` (`codeGam`),
  KEY `FK_grilleTarifs_categories` (`codeCate`),
  KEY `FK_grilleTarifs_tarifs` (`codeTarif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `grille_tarifs`
--

INSERT INTO `grille_tarifs` (`codeGam`, `codeCate`, `codeTarif`) VALUES
('EG', 'FOA', 'T1'),
('EG', 'MONO', 'T1'),
('EG', 'PA', 'T1'),
('EG', 'SA', 'T1'),
('EG', 'SURF', 'T1'),
('EG', 'FOP', 'T2'),
('MG', 'FOA', 'T2'),
('MG', 'MONO', 'T2'),
('MG', 'PA', 'T2'),
('MG', 'SA', 'T2'),
('MG', 'SURF', 'T2'),
('HG', 'SURF', 'T3'),
('MG', 'FOP', 'T3'),
('HG', 'FOA', 'T4'),
('HG', 'FOP', 'T4'),
('HG', 'SA', 'T4'),
('PR', 'SURF', 'T5'),
('PR', 'FOA', 'T6'),
('PR', 'FOP', 'T6'),
('PR', 'SA', 'T6');

-- --------------------------------------------------------

--
-- Structure de la table `lignesfic`
--

DROP TABLE IF EXISTS `lignesfic`;
CREATE TABLE IF NOT EXISTS `lignesfic` (
  `noFic` int(6) NOT NULL,
  `noLig` int(3) NOT NULL,
  `refart` char(8) NOT NULL,
  `depart` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `retour` datetime DEFAULT NULL,
  PRIMARY KEY (`noFic`,`noLig`),
  KEY `FK_lignesfic_articles` (`refart`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `lignesfic`
--

INSERT INTO `lignesfic` (`noFic`, `noLig`, `refart`, `depart`, `retour`) VALUES
(1001, 1, 'F05', '2019-07-09 12:44:45', NULL),
(1001, 2, 'F50', '2019-07-09 12:44:45', NULL),
(1001, 3, 'F60', '2019-07-09 12:44:45', NULL),
(1002, 1, 'A03', '2019-07-09 12:45:37', NULL),
(1002, 2, 'A04', '2019-07-09 12:45:37', NULL),
(1002, 3, 'S03', '2019-07-09 12:45:37', NULL),
(1003, 1, 'F50', '2019-07-09 12:46:03', NULL),
(1003, 2, 'F05', '2019-07-09 12:46:03', NULL),
(1004, 1, 'P01', '2019-07-09 12:47:40', NULL),
(1005, 1, 'F05', '2019-07-09 12:47:40', NULL),
(1005, 2, 'F10', '2019-07-09 12:47:40', NULL),
(1006, 1, 'S01', '2019-07-09 12:47:40', NULL),
(1006, 2, 'S02', '2019-07-09 12:47:40', NULL),
(1006, 3, 'S03', '2019-07-09 12:47:40', NULL),
(1007, 1, 'F50', '2019-07-09 12:48:59', NULL),
(1007, 2, 'F05', '2019-07-09 12:48:59', NULL),
(1007, 3, 'F60', '2019-07-09 12:48:59', NULL),
(1007, 4, 'S02', '2019-07-09 12:48:59', NULL),
(1008, 1, 'S01', '2019-07-09 12:48:59', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `tarifs`
--

DROP TABLE IF EXISTS `tarifs`;
CREATE TABLE IF NOT EXISTS `tarifs` (
  `libelle` varchar(30) NOT NULL,
  `prixJour` decimal(5,2) NOT NULL,
  `codeTarif` char(5) NOT NULL,
  PRIMARY KEY (`codeTarif`),
  UNIQUE KEY `libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `tarifs`
--

INSERT INTO `tarifs` (`libelle`, `prixJour`, `codeTarif`) VALUES
('Base', '10.00', 'T1'),
('Chocolat', '15.00', 'T2'),
('Bronze', '20.00', 'T3'),
('Argent', '30.00', 'T4'),
('Or', '50.00', 'T5'),
('Platine', '90.00', 'T6');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `FK_articles_grille_tarifs` FOREIGN KEY (`codeGam`) REFERENCES `grille_tarifs` (`codeGam`),
  ADD CONSTRAINT `FK_articles_grille_tarifs_2` FOREIGN KEY (`codeCate`) REFERENCES `grille_tarifs` (`codeCate`);

--
-- Contraintes pour la table `fiches`
--
ALTER TABLE `fiches`
  ADD CONSTRAINT `FK_fiches_clients` FOREIGN KEY (`noCli`) REFERENCES `clients` (`noCli`);

--
-- Contraintes pour la table `grille_tarifs`
--
ALTER TABLE `grille_tarifs`
  ADD CONSTRAINT `FK_grilleTarifs_categories` FOREIGN KEY (`codeCate`) REFERENCES `categories` (`codeCate`),
  ADD CONSTRAINT `FK_grilleTarifs_gammes` FOREIGN KEY (`codeGam`) REFERENCES `gammes` (`codeGam`),
  ADD CONSTRAINT `FK_grilleTarifs_tarifs` FOREIGN KEY (`codeTarif`) REFERENCES `tarifs` (`codeTarif`);

--
-- Contraintes pour la table `lignesfic`
--
ALTER TABLE `lignesfic`
  ADD CONSTRAINT `FK_lignesfic_articles` FOREIGN KEY (`refart`) REFERENCES `articles` (`refart`),
  ADD CONSTRAINT `FK_lignesfic_fiches` FOREIGN KEY (`noFic`) REFERENCES `fiches` (`noFic`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
