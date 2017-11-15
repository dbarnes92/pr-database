-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: playground
-- ------------------------------------------------------
-- Server version	5.7.12-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `primary_nm` varchar(256) DEFAULT NULL,
  `attended_num` int(11) DEFAULT '0' COMMENT '# of tournaments attended (not needed probably)',
  `wins` int(11) DEFAULT NULL,
  `losses` int(11) DEFAULT NULL,
  `elo` int(11) DEFAULT NULL,
  `team` varchar(256) DEFAULT NULL,
  `invisible` int(1) DEFAULT '0',
  `characters` varchar(512) DEFAULT NULL,
  `has_alt` int(1) DEFAULT '0',
  `mu` double DEFAULT NULL,
  `sigma` double DEFAULT NULL,
  `last_match` datetime DEFAULT NULL,
  `decay_months` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=317 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_alt`
--

DROP TABLE IF EXISTS `player_alt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_alt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `alt_nm` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_player_id` (`player_id`),
  CONSTRAINT `fk_player_id` FOREIGN KEY (`player_id`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_alt`
--

LOCK TABLES `player_alt` WRITE;
/*!40000 ALTER TABLE `player_alt` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_alt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nm` varchar(512) NOT NULL,
  `multiplier` int(11) DEFAULT NULL,
  `min_matches` int(11) DEFAULT NULL,
  `decay` int(11) DEFAULT NULL,
  `decay_val` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (8,'TestWorld',200,1,3,3),(9,'TestWorld',200,1,3,3),(10,'TestWorld',200,1,3,3),(11,'TestWorld',200,1,3,3),(12,'TestWorld',200,1,3,3),(13,'TestWorld',200,1,3,3),(14,'TestWorld',200,1,3,3);
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `set_data`
--

DROP TABLE IF EXISTS `set_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `set_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sk_id` int(11) NOT NULL,
  `tournament_id` int(11) NOT NULL,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  `round` varchar(50) NOT NULL,
  `tournament_nm` varchar(512) DEFAULT NULL,
  `winner` int(11) NOT NULL COMMENT '1 or 2 for player1/player2',
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk2_loser_id` (`player2`),
  KEY `fk2_winner_id` (`player1`),
  KEY `fk_tournament_id` (`tournament_id`),
  CONSTRAINT `fk2_loser_id` FOREIGN KEY (`player2`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk2_winner_id` FOREIGN KEY (`player1`) REFERENCES `player` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tournament_id` FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `set_data`
--

LOCK TABLES `set_data` WRITE;
/*!40000 ALTER TABLE `set_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `set_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament`
--

DROP TABLE IF EXISTS `tournament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nm` varchar(512) NOT NULL,
  `date` datetime NOT NULL,
  `entrants_num` int(11) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_region_id` (`region_id`),
  CONSTRAINT `fk_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament`
--

LOCK TABLES `tournament` WRITE;
/*!40000 ALTER TABLE `tournament` DISABLE KEYS */;
/*!40000 ALTER TABLE `tournament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'playground'
--

--
-- Dumping routines for database 'playground'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-15 14:58:43
