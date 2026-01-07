-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.4.3 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour sport_manager
CREATE DATABASE IF NOT EXISTS `sport_manager` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sport_manager`;

-- Listage de la structure de table sport_manager. arbitre
CREATE TABLE IF NOT EXISTS `arbitre` (
  `id_arbitre` int unsigned NOT NULL AUTO_INCREMENT,
  `nom_arbitre` varchar(50) NOT NULL,
  `prenom_arbitre` varchar(50) NOT NULL,
  `id_pays` int unsigned NOT NULL,
  PRIMARY KEY (`id_arbitre`),
  KEY `fk_arbitre_pays` (`id_pays`),
  CONSTRAINT `fk_arbitre_pays` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id_pays`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.arbitre : ~8 rows (environ)
INSERT INTO `arbitre` (`id_arbitre`, `nom_arbitre`, `prenom_arbitre`, `id_pays`) VALUES
	(1, 'Turpin', 'Clément', 1),
	(2, 'Buquet', 'François', 1),
	(3, 'Stinat', 'Jérôme', 1),
	(4, 'Delerue', 'Nicolas', 1),
	(5, 'Millot', 'Laurent', 1),
	(6, 'Gassmann', 'Rudy', 1),
	(7, 'Frappart', 'Stephanie', 1),
	(8, 'Letexier', 'Fred', 1);

-- Listage de la structure de table sport_manager. avertir
CREATE TABLE IF NOT EXISTS `avertir` (
  `id_joueur` int unsigned NOT NULL,
  `id_rencontre` int unsigned NOT NULL,
  `id_couleur` int unsigned NOT NULL,
  `minute_avertissement` int NOT NULL,
  PRIMARY KEY (`id_joueur`,`id_rencontre`,`id_couleur`),
  KEY `id_rencontre` (`id_rencontre`),
  KEY `id_couleur` (`id_couleur`),
  CONSTRAINT `avertir_ibfk_1` FOREIGN KEY (`id_joueur`) REFERENCES `joueur` (`id_joueur`),
  CONSTRAINT `avertir_ibfk_2` FOREIGN KEY (`id_rencontre`) REFERENCES `rencontre` (`id_rencontre`),
  CONSTRAINT `avertir_ibfk_3` FOREIGN KEY (`id_couleur`) REFERENCES `avertissement` (`id_couleur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.avertir : ~33 rows (environ)
INSERT INTO `avertir` (`id_joueur`, `id_rencontre`, `id_couleur`, `minute_avertissement`) VALUES
	(1, 1, 1, 12),
	(2, 2, 1, 22),
	(3, 3, 1, 15),
	(4, 4, 1, 8),
	(5, 1, 1, 34),
	(5, 5, 1, 29),
	(6, 2, 1, 47),
	(6, 6, 1, 17),
	(7, 3, 1, 56),
	(7, 7, 1, 33),
	(8, 1, 2, 78),
	(8, 8, 1, 21),
	(9, 3, 2, 90),
	(9, 9, 1, 14),
	(10, 2, 2, 83),
	(10, 10, 1, 27),
	(11, 4, 1, 67),
	(11, 11, 1, 19),
	(12, 4, 2, 81),
	(13, 5, 1, 41),
	(14, 5, 2, 88),
	(15, 6, 1, 49),
	(16, 6, 2, 76),
	(17, 7, 1, 55),
	(18, 7, 2, 82),
	(19, 8, 1, 44),
	(20, 8, 2, 77),
	(21, 9, 1, 39),
	(22, 9, 2, 85),
	(23, 10, 1, 51),
	(24, 10, 2, 79),
	(25, 11, 1, 42),
	(26, 11, 2, 88);

-- Listage de la structure de table sport_manager. avertissement
CREATE TABLE IF NOT EXISTS `avertissement` (
  `id_couleur` int unsigned NOT NULL AUTO_INCREMENT,
  `couleur` varchar(50) NOT NULL,
  PRIMARY KEY (`id_couleur`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.avertissement : ~2 rows (environ)
INSERT INTO `avertissement` (`id_couleur`, `couleur`) VALUES
	(1, 'Jaune'),
	(2, 'Rouge');

-- Listage de la structure de table sport_manager. blessure
CREATE TABLE IF NOT EXISTS `blessure` (
  `id_blessure` int unsigned NOT NULL AUTO_INCREMENT,
  `id_joueur` int unsigned NOT NULL DEFAULT '0',
  `id_rencontre` int unsigned NOT NULL DEFAULT '0',
  `minute_blessure` int unsigned NOT NULL DEFAULT '0',
  `type_blessure` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_blessure`),
  KEY `id_joueur` (`id_joueur`),
  KEY `id_rencontre` (`id_rencontre`),
  CONSTRAINT `FK_blessure_joueur` FOREIGN KEY (`id_joueur`) REFERENCES `joueur` (`id_joueur`),
  CONSTRAINT `FK_blessure_rencontre` FOREIGN KEY (`id_rencontre`) REFERENCES `rencontre` (`id_rencontre`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.blessure : ~17 rows (environ)
INSERT INTO `blessure` (`id_blessure`, `id_joueur`, `id_rencontre`, `minute_blessure`, `type_blessure`) VALUES
	(1, 3, 1, 23, 'Genou'),
	(2, 7, 1, 67, 'Cheville'),
	(3, 12, 2, 45, 'Muscle'),
	(4, 15, 2, 80, 'Entorse'),
	(5, 1, 3, 12, 'Cuisse'),
	(6, 18, 4, 33, 'Tendon'),
	(7, 20, 4, 72, 'Cheville'),
	(8, 5, 5, 19, 'Épaule'),
	(9, 25, 6, 55, 'Genou'),
	(10, 8, 7, 44, 'Cuisse'),
	(11, 30, 7, 77, 'Muscle'),
	(12, 2, 8, 61, 'Cheville'),
	(13, 11, 9, 18, 'Épaule'),
	(14, 14, 9, 83, 'Genou'),
	(15, 6, 10, 29, 'Muscle'),
	(16, 9, 11, 37, 'Cuisse'),
	(17, 17, 11, 68, 'Cheville');

-- Listage de la structure de table sport_manager. competition
CREATE TABLE IF NOT EXISTS `competition` (
  `id_competition` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_competition` varchar(100) NOT NULL,
  PRIMARY KEY (`id_competition`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.competition : ~3 rows (environ)
INSERT INTO `competition` (`id_competition`, `libelle_competition`) VALUES
	(1, 'Ligue 1'),
	(2, 'Coupe de France'),
	(3, 'Coupe de la Ligue');

-- Listage de la structure de table sport_manager. equipe
CREATE TABLE IF NOT EXISTS `equipe` (
  `id_equipe` int unsigned NOT NULL AUTO_INCREMENT,
  `nom_equipe` varchar(50) NOT NULL,
  PRIMARY KEY (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.equipe : ~18 rows (environ)
INSERT INTO `equipe` (`id_equipe`, `nom_equipe`) VALUES
	(1, 'Paris Saint-Germain'),
	(2, 'Olympique de Marseille'),
	(3, 'AS Monaco'),
	(4, 'LOSC Lille'),
	(5, 'RC Lens'),
	(6, 'Olympique Lyonnais'),
	(7, 'OGC Nice'),
	(8, 'Stade Rennais'),
	(9, 'FC Nantes'),
	(10, 'Toulouse FC'),
	(11, 'FC Lorient'),
	(12, 'Le Havre AC'),
	(13, 'Stade Brestois 29'),
	(14, 'RC Strasbourg'),
	(15, 'AJ Auxerre'),
	(16, 'Angers SCO'),
	(17, 'Metz'),
	(18, 'Paris FC');

-- Listage de la structure de table sport_manager. joueur
CREATE TABLE IF NOT EXISTS `joueur` (
  `id_joueur` int unsigned NOT NULL AUTO_INCREMENT,
  `nom_joueur` varchar(50) NOT NULL,
  `prenom_joueur` varchar(50) NOT NULL,
  `id_pays` int unsigned NOT NULL,
  `vitesse_joueur` int DEFAULT '50',
  `endurance_joueur` int DEFAULT '50',
  `force_joueur` int DEFAULT '50',
  `proba_blessure` decimal(5,2) DEFAULT '0.05',
  PRIMARY KEY (`id_joueur`),
  KEY `id_pays` (`id_pays`),
  CONSTRAINT `joueur_ibfk_1` FOREIGN KEY (`id_pays`) REFERENCES `pays` (`id_pays`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.joueur : ~30 rows (environ)
INSERT INTO `joueur` (`id_joueur`, `nom_joueur`, `prenom_joueur`, `id_pays`, `vitesse_joueur`, `endurance_joueur`, `force_joueur`, `proba_blessure`) VALUES
	(1, 'Mbappé', 'Kylian', 1, 77, 77, 93, 0.10),
	(2, 'Dembélé', 'Ousmane', 1, 88, 99, 90, 0.10),
	(3, 'Hakimi', 'Achraf', 2, 93, 86, 91, 0.12),
	(4, 'Nunes', 'Nuno', 7, 79, 78, 93, 0.10),
	(5, 'Pacho', 'Willian', 7, 83, 76, 72, 0.05),
	(6, 'Aubameyang', 'Pierre-Emerick', 3, 87, 77, 65, 0.06),
	(7, 'Hojbjerg', 'Pierre-Emile', 1, 86, 98, 91, 0.02),
	(8, 'Simon', 'Moses', 5, 92, 95, 60, 0.06),
	(9, 'Rulli', 'Geronimo', 1, 65, 76, 85, 0.11),
	(10, 'Luis', 'Henrique', 5, 81, 100, 76, 0.03),
	(11, 'Balogun', 'Folarin', 1, 62, 66, 83, 0.06),
	(12, 'Golovin', 'Aleksandr', 7, 77, 93, 94, 0.09),
	(13, 'Zakaria', 'Denis', 7, 67, 88, 96, 0.06),
	(14, 'Minamino', 'Takumi', 1, 66, 88, 60, 0.12),
	(15, 'Pogba', 'Paul', 1, 97, 84, 70, 0.07),
	(16, 'Risser', 'Robin', 1, 85, 88, 85, 0.02),
	(17, 'Baidoo', 'Samson', 1, 66, 92, 81, 0.04),
	(18, 'Udol', 'Matthieu', 1, 77, 83, 83, 0.03),
	(19, 'Sarr', 'Malang', 1, 96, 64, 95, 0.02),
	(20, 'Mbemba', 'Chancel', 1, 78, 68, 89, 0.12),
	(21, 'Giroud', 'Olivier', 1, 86, 72, 83, 0.02),
	(22, 'Reinildo', 'Reinildo', 1, 71, 76, 66, 0.08),
	(23, 'Fonte', 'Jose', 3, 80, 88, 61, 0.02),
	(24, 'Guedes', 'Rafa', 7, 62, 69, 99, 0.04),
	(25, 'Onana', 'André', 1, 96, 98, 63, 0.08),
	(26, 'Maignan', 'Mike', 5, 91, 61, 97, 0.06),
	(27, 'Terrier', 'Martin', 1, 76, 89, 75, 0.10),
	(28, 'Fofana', 'Youssouf', 1, 87, 63, 77, 0.10),
	(29, 'Cherki', 'Rayan', 1, 97, 61, 80, 0.06),
	(30, 'Hohenauer', 'Maxime', 1, 81, 74, 70, 0.04);

-- Listage de la structure de table sport_manager. journee
CREATE TABLE IF NOT EXISTS `journee` (
  `id_journee` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_journee` varchar(50) NOT NULL,
  `date_journee` date NOT NULL,
  PRIMARY KEY (`id_journee`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.journee : ~15 rows (environ)
INSERT INTO `journee` (`id_journee`, `libelle_journee`, `date_journee`) VALUES
	(1, 'J1', '2025-08-16'),
	(2, 'J2', '2025-08-23'),
	(3, 'J3', '2025-08-30'),
	(4, 'J4', '2025-09-06'),
	(5, 'J5', '2025-09-13'),
	(6, 'J6', '2025-09-20'),
	(7, 'J7', '2025-09-27'),
	(8, 'J8', '2025-10-04'),
	(9, 'J9', '2025-10-11'),
	(10, 'J10', '2025-10-18'),
	(11, 'CDF J1', '2025-09-10'),
	(12, 'CDF J2', '2025-09-24'),
	(13, 'CDF J3', '2025-10-08'),
	(14, 'CDF J4', '2025-10-22'),
	(15, 'CDF J5', '2025-11-05');

-- Listage de la structure de table sport_manager. marquer
CREATE TABLE IF NOT EXISTS `marquer` (
  `id_joueur` int unsigned NOT NULL,
  `id_rencontre` int unsigned NOT NULL,
  `minute_but` int NOT NULL,
  PRIMARY KEY (`id_joueur`,`id_rencontre`),
  KEY `id_rencontre` (`id_rencontre`),
  CONSTRAINT `marquer_ibfk_1` FOREIGN KEY (`id_joueur`) REFERENCES `joueur` (`id_joueur`),
  CONSTRAINT `marquer_ibfk_2` FOREIGN KEY (`id_rencontre`) REFERENCES `rencontre` (`id_rencontre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.marquer : ~33 rows (environ)
INSERT INTO `marquer` (`id_joueur`, `id_rencontre`, `minute_but`) VALUES
	(1, 1, 12),
	(1, 11, 10),
	(2, 1, 45),
	(2, 11, 55),
	(3, 1, 78),
	(3, 11, 78),
	(4, 2, 5),
	(5, 2, 33),
	(6, 2, 67),
	(7, 3, 14),
	(8, 3, 29),
	(9, 3, 88),
	(10, 4, 21),
	(11, 4, 54),
	(12, 4, 77),
	(13, 5, 9),
	(14, 5, 36),
	(15, 5, 60),
	(16, 6, 12),
	(17, 6, 45),
	(18, 6, 83),
	(19, 7, 7),
	(20, 7, 33),
	(21, 7, 66),
	(22, 8, 15),
	(23, 8, 52),
	(24, 8, 80),
	(25, 9, 11),
	(26, 9, 48),
	(27, 9, 70),
	(28, 10, 22),
	(29, 10, 39),
	(30, 10, 84);

-- Listage de la structure de table sport_manager. participation
CREATE TABLE IF NOT EXISTS `participation` (
  `id_participation` int unsigned NOT NULL AUTO_INCREMENT,
  `minute_debut` int NOT NULL,
  `minute_fin` int NOT NULL,
  `id_rencontre` int unsigned NOT NULL,
  `id_joueur` int unsigned NOT NULL,
  PRIMARY KEY (`id_participation`),
  KEY `id_rencontre` (`id_rencontre`),
  KEY `id_joueur` (`id_joueur`),
  CONSTRAINT `participation_ibfk_1` FOREIGN KEY (`id_rencontre`) REFERENCES `rencontre` (`id_rencontre`),
  CONSTRAINT `participation_ibfk_2` FOREIGN KEY (`id_joueur`) REFERENCES `joueur` (`id_joueur`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.participation : ~8 rows (environ)
INSERT INTO `participation` (`id_participation`, `minute_debut`, `minute_fin`, `id_rencontre`, `id_joueur`) VALUES
	(1, 1, 90, 1, 1),
	(2, 1, 90, 1, 2),
	(3, 1, 90, 1, 3),
	(4, 45, 90, 1, 4),
	(5, 1, 90, 2, 5),
	(6, 1, 90, 2, 6),
	(7, 30, 90, 2, 7),
	(8, 1, 90, 3, 8);

-- Listage de la structure de table sport_manager. pays
CREATE TABLE IF NOT EXISTS `pays` (
  `id_pays` int unsigned NOT NULL AUTO_INCREMENT,
  `nom_pays` varchar(100) NOT NULL,
  PRIMARY KEY (`id_pays`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.pays : ~8 rows (environ)
INSERT INTO `pays` (`id_pays`, `nom_pays`) VALUES
	(1, 'France'),
	(2, 'Maroc'),
	(3, 'Argentine'),
	(4, 'Portugal'),
	(5, 'Brésil'),
	(6, 'Angleterre'),
	(7, 'Espagne'),
	(8, 'Italie');

-- Listage de la structure de table sport_manager. periode
CREATE TABLE IF NOT EXISTS `periode` (
  `id_periode` int unsigned NOT NULL AUTO_INCREMENT,
  `date_debut_periode` date NOT NULL,
  `date_fin_periode` date NOT NULL,
  `id_joueur` int unsigned NOT NULL,
  `id_equipe` int unsigned NOT NULL,
  PRIMARY KEY (`id_periode`),
  KEY `id_joueur` (`id_joueur`),
  KEY `id_equipe` (`id_equipe`),
  CONSTRAINT `periode_ibfk_1` FOREIGN KEY (`id_joueur`) REFERENCES `joueur` (`id_joueur`),
  CONSTRAINT `periode_ibfk_2` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.periode : ~30 rows (environ)
INSERT INTO `periode` (`id_periode`, `date_debut_periode`, `date_fin_periode`, `id_joueur`, `id_equipe`) VALUES
	(1, '2025-08-01', '2026-05-31', 1, 1),
	(2, '2025-08-01', '2026-05-31', 2, 2),
	(3, '2025-08-01', '2026-05-31', 3, 3),
	(4, '2025-08-01', '2026-05-31', 4, 4),
	(5, '2025-08-01', '2026-05-31', 5, 5),
	(6, '2025-08-01', '2026-05-31', 6, 6),
	(7, '2025-08-01', '2026-05-31', 7, 7),
	(8, '2025-08-01', '2026-05-31', 8, 8),
	(9, '2025-08-01', '2026-05-31', 9, 9),
	(10, '2025-08-01', '2026-05-31', 10, 10),
	(11, '2025-08-01', '2026-05-31', 11, 11),
	(12, '2025-08-01', '2026-05-31', 12, 12),
	(13, '2025-08-01', '2026-05-31', 13, 13),
	(14, '2025-08-01', '2026-05-31', 14, 13),
	(15, '2025-08-01', '2026-05-31', 15, 13),
	(16, '2025-08-01', '2026-05-31', 16, 14),
	(17, '2025-08-01', '2026-05-31', 17, 14),
	(18, '2025-08-01', '2026-05-31', 18, 14),
	(19, '2025-08-01', '2026-05-31', 19, 15),
	(20, '2025-08-01', '2026-05-31', 20, 15),
	(21, '2025-08-01', '2026-05-31', 21, 15),
	(22, '2025-08-01', '2026-05-31', 22, 16),
	(23, '2025-08-01', '2026-05-31', 23, 16),
	(24, '2025-08-01', '2026-05-31', 24, 16),
	(25, '2025-08-01', '2026-05-31', 25, 17),
	(26, '2025-08-01', '2026-05-31', 26, 17),
	(27, '2025-08-01', '2026-05-31', 27, 17),
	(28, '2025-08-01', '2026-05-31', 28, 18),
	(29, '2025-08-01', '2026-05-31', 29, 18),
	(30, '2025-08-01', '2026-05-31', 30, 18);

-- Listage de la structure de table sport_manager. rencontre
CREATE TABLE IF NOT EXISTS `rencontre` (
  `id_rencontre` int unsigned NOT NULL AUTO_INCREMENT,
  `nb_spectateurs` int DEFAULT NULL,
  `id_journee` int unsigned NOT NULL,
  `id_arbitre` int unsigned NOT NULL,
  `id_equipe` int unsigned NOT NULL,
  `id_equipe_1` int unsigned NOT NULL,
  `score_equipe_1` int DEFAULT '0',
  `score_equipe_2` int DEFAULT '0',
  PRIMARY KEY (`id_rencontre`),
  KEY `id_journee` (`id_journee`),
  KEY `id_arbitre` (`id_arbitre`),
  KEY `id_equipe` (`id_equipe`),
  KEY `id_equipe_1` (`id_equipe_1`),
  CONSTRAINT `rencontre_ibfk_1` FOREIGN KEY (`id_journee`) REFERENCES `journee` (`id_journee`),
  CONSTRAINT `rencontre_ibfk_2` FOREIGN KEY (`id_arbitre`) REFERENCES `arbitre` (`id_arbitre`),
  CONSTRAINT `rencontre_ibfk_3` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`),
  CONSTRAINT `rencontre_ibfk_4` FOREIGN KEY (`id_equipe_1`) REFERENCES `equipe` (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.rencontre : ~11 rows (environ)
INSERT INTO `rencontre` (`id_rencontre`, `nb_spectateurs`, `id_journee`, `id_arbitre`, `id_equipe`, `id_equipe_1`, `score_equipe_1`, `score_equipe_2`) VALUES
	(1, 45000, 1, 1, 1, 2, 3, 1),
	(2, 38000, 1, 2, 3, 4, 3, 1),
	(3, 30000, 1, 3, 5, 6, 3, 0),
	(4, 28000, 2, 4, 7, 8, 3, 0),
	(5, 31000, 2, 5, 9, 10, 3, 0),
	(6, 42000, 2, 6, 11, 12, 0, 3),
	(7, 46000, 3, 7, 13, 14, 0, 3),
	(8, 39000, 3, 8, 15, 16, 0, 3),
	(9, 35000, 3, 1, 17, 1, 3, 3),
	(10, 40000, 4, 2, 2, 3, 0, 3),
	(11, 37000, 4, 3, 4, 5, 3, 0);

-- Listage de la structure de table sport_manager. saison
CREATE TABLE IF NOT EXISTS `saison` (
  `id_saison` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_saison` varchar(100) NOT NULL,
  PRIMARY KEY (`id_saison`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.saison : ~2 rows (environ)
INSERT INTO `saison` (`id_saison`, `libelle_saison`) VALUES
	(1, '2025-2026'),
	(2, '2026-2027');

-- Listage de la structure de table sport_manager. stade
CREATE TABLE IF NOT EXISTS `stade` (
  `id_stade` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_stade` varchar(255) NOT NULL,
  `nb_places` int DEFAULT NULL,
  `id_equipe` int unsigned NOT NULL,
  PRIMARY KEY (`id_stade`),
  KEY `id_equipe` (`id_equipe`),
  CONSTRAINT `stade_ibfk_1` FOREIGN KEY (`id_equipe`) REFERENCES `equipe` (`id_equipe`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager.stade : ~18 rows (environ)
INSERT INTO `stade` (`id_stade`, `libelle_stade`, `nb_places`, `id_equipe`) VALUES
	(1, 'Parc des Princes', 47000, 1),
	(2, 'Stade Vélodrome', 67000, 2),
	(3, 'Stade Louis II', 16360, 3),
	(4, 'Stade Pierre-Mauroy', 50186, 4),
	(5, 'Stade Bollaert-Delelis', 38223, 5),
	(6, 'Groupama Stadium', 59286, 6),
	(7, 'Allianz Riviera', 35000, 7),
	(8, 'Roazhon Park', 29778, 8),
	(9, 'Stade de la Beaujoire', 36000, 9),
	(10, 'Stadium de Toulouse', 33000, 10),
	(11, 'Stade du Moustoir', 18890, 11),
	(12, 'Stade Océane', 25178, 12),
	(13, 'Stade Francis-Le Blé', 15931, 13),
	(14, 'Stade de la Meinau', 29000, 14),
	(15, 'Stade de l\'Abbé-Deschamps', 21379, 15),
	(16, 'Stade Raymond Kopa', 19800, 16),
	(17, 'Stade Saint-Symphorien', 25500, 17),
	(18, 'Stade Jean-Bouin', 20000, 18);

-- Listage de la structure de table sport_manager. _composer
CREATE TABLE IF NOT EXISTS `_composer` (
  `id_journee` int unsigned NOT NULL,
  `id_saison` int unsigned NOT NULL,
  `id_competition` int unsigned NOT NULL,
  PRIMARY KEY (`id_journee`,`id_saison`,`id_competition`),
  KEY `id_saison` (`id_saison`),
  KEY `id_competition` (`id_competition`),
  CONSTRAINT `_composer_ibfk_1` FOREIGN KEY (`id_journee`) REFERENCES `journee` (`id_journee`),
  CONSTRAINT `_composer_ibfk_2` FOREIGN KEY (`id_saison`) REFERENCES `saison` (`id_saison`),
  CONSTRAINT `_composer_ibfk_3` FOREIGN KEY (`id_competition`) REFERENCES `competition` (`id_competition`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table sport_manager._composer : ~15 rows (environ)
INSERT INTO `_composer` (`id_journee`, `id_saison`, `id_competition`) VALUES
	(1, 1, 1),
	(2, 1, 1),
	(3, 1, 1),
	(4, 1, 1),
	(5, 1, 1),
	(6, 1, 1),
	(7, 1, 1),
	(8, 1, 1),
	(9, 1, 1),
	(10, 1, 1),
	(11, 1, 2),
	(12, 1, 2),
	(13, 1, 2),
	(14, 1, 2),
	(15, 1, 2);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
