-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: artists_collection
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `artist_id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(100) NOT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3223 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'Charlie Puth'),(2,'Ben&Ben'),(3,'Queen'),(4,'Michael Jackson'),(5,'The Weeknd'),(6,'Ed Sheeran'),(7,'Imagine Dragon'),(8,'YOASOBI'),(9,'HOYOMIX'),(11,'Arthur Nery');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `artist_music`
--

DROP TABLE IF EXISTS `artist_music`;
/*!50001 DROP VIEW IF EXISTS `artist_music`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `artist_music` AS SELECT 
 1 AS `artist_id`,
 1 AS `artist_name`,
 1 AS `music_title`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `artists_pop`
--

DROP TABLE IF EXISTS `artists_pop`;
/*!50001 DROP VIEW IF EXISTS `artists_pop`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `artists_pop` AS SELECT 
 1 AS `music_title`,
 1 AS `download_count`,
 1 AS `artist_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `first_view`
--

DROP TABLE IF EXISTS `first_view`;
/*!50001 DROP VIEW IF EXISTS `first_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `first_view` AS SELECT 
 1 AS `music_title`,
 1 AS `download_count`,
 1 AS `genre_type`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_type` varchar(100) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Pop'),(2,'Rock'),(3,'Soul'),(4,'Funk'),(5,'Jazz'),(6,'Disco'),(7,'Ballad'),(8,'Blues'),(9,'New Wave'),(10,'Jpop');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music`
--

DROP TABLE IF EXISTS `music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `music` (
  `music_id` int NOT NULL AUTO_INCREMENT,
  `music_title` varchar(200) NOT NULL,
  `download_count` int DEFAULT NULL,
  `artist_id` int DEFAULT NULL,
  `genre_id` int DEFAULT NULL,
  `writer_id` int DEFAULT NULL,
  `producer_id` int DEFAULT NULL,
  PRIMARY KEY (`music_id`),
  KEY `artist_id` (`artist_id`),
  KEY `genre_id` (`genre_id`),
  KEY `writer_id` (`writer_id`),
  KEY `producer_id` (`producer_id`),
  CONSTRAINT `music_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `music_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `music_ibfk_3` FOREIGN KEY (`writer_id`) REFERENCES `writer` (`writer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `music_ibfk_4` FOREIGN KEY (`producer_id`) REFERENCES `producer` (`producer_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music`
--

LOCK TABLES `music` WRITE;
/*!40000 ALTER TABLE `music` DISABLE KEYS */;
INSERT INTO `music` VALUES (1,'I Warned Myself',500020,1,1,1,1),(2,'Araw-Araw',500030,2,2,2,2),(3,'Killer Queen',600050,3,2,3,3),(4,'Remember The Time',600040,4,1,4,4),(5,'Save Your Tears',500060,5,1,5,5),(6,'Shivers',500080,6,1,6,6),(7,'Follow You',500070,7,1,7,7),(8,'Call Out My Name',500090,5,9,5,7),(9,'Supermarket Flower',500100,6,7,6,6),(10,'Pagtingin',4000222,2,2,2,2);
/*!40000 ALTER TABLE `music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producer`
--

DROP TABLE IF EXISTS `producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producer` (
  `producer_id` int NOT NULL AUTO_INCREMENT,
  `producer_name` varchar(100) NOT NULL,
  `artist_id` int DEFAULT NULL,
  PRIMARY KEY (`producer_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `producer_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=433 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producer`
--

LOCK TABLES `producer` WRITE;
/*!40000 ALTER TABLE `producer` DISABLE KEYS */;
INSERT INTO `producer` VALUES (1,'Benny Blanco',1),(2,'Jean Paul Verona',2),(3,'Reinhold Mach',3),(4,'Teddy Riley',4),(5,'Max Martin',5),(6,'Armin Van Buuren',6),(7,'Joel Little',7);
/*!40000 ALTER TABLE `producer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `second_view`
--

DROP TABLE IF EXISTS `second_view`;
/*!50001 DROP VIEW IF EXISTS `second_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `second_view` AS SELECT 
 1 AS `music_title`,
 1 AS `artist_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `third_view`
--

DROP TABLE IF EXISTS `third_view`;
/*!50001 DROP VIEW IF EXISTS `third_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `third_view` AS SELECT 
 1 AS `music_title`,
 1 AS `artist_name`,
 1 AS `genre_type`,
 1 AS `producer_name`,
 1 AS `writer_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `pass_key` char(100) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Tan','Martin Joseph','Bolaños','25d55ad283aa400af464c76d713c07ad');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writer`
--

DROP TABLE IF EXISTS `writer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `writer` (
  `writer_id` int NOT NULL AUTO_INCREMENT,
  `writer_name` varchar(100) NOT NULL,
  `artist_id` int DEFAULT NULL,
  PRIMARY KEY (`writer_id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `writer_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`artist_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2345 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writer`
--

LOCK TABLES `writer` WRITE;
/*!40000 ALTER TABLE `writer` DISABLE KEYS */;
INSERT INTO `writer` VALUES (1,'Benjamin Levin',1),(2,'Ben&Ben',2),(3,'Freddie Mercury',3),(4,'Bernard Belle',4),(5,'Abel Tesfaye',5),(6,'Steve McCutcheon',6),(7,'Dan Reynolds',7),(8,'Jesse Carmichael',6),(9,'Adam Carmichael',5),(32,'Ben&Ben',2),(33,'Benjamin Levin',1),(36,'Steve McCutcheon',6),(67,'Dan Reynolds',7),(68,'Jesse Carmichael',6),(89,'Adam Carmichael',5),(213,'Freddie Mercury',3),(345,'Abel Tesfaye',5),(2344,'Bernard Belle',4);
/*!40000 ALTER TABLE `writer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'artists_collection'
--

--
-- Dumping routines for database 'artists_collection'
--

--
-- Final view structure for view `artist_music`
--

/*!50001 DROP VIEW IF EXISTS `artist_music`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `artist_music` AS select `artist`.`artist_id` AS `artist_id`,`artist`.`artist_name` AS `artist_name`,`music`.`music_title` AS `music_title` from (`artist` join `music`) where (`artist`.`artist_id` = `music`.`artist_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `artists_pop`
--

/*!50001 DROP VIEW IF EXISTS `artists_pop`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `artists_pop` AS select `music`.`music_title` AS `music_title`,`music`.`download_count` AS `download_count`,`artist`.`artist_name` AS `artist_name` from (`music` join `artist` on((`music`.`artist_id` = `artist`.`artist_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `first_view`
--

/*!50001 DROP VIEW IF EXISTS `first_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `first_view` AS select `music`.`music_title` AS `music_title`,`music`.`download_count` AS `download_count`,`genre`.`genre_type` AS `genre_type` from (`music` join `genre` on((`music`.`genre_id` = `genre`.`genre_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `second_view`
--

/*!50001 DROP VIEW IF EXISTS `second_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `second_view` AS select `music`.`music_title` AS `music_title`,`artist`.`artist_name` AS `artist_name` from (`music` join `artist` on((`music`.`artist_id` = `artist`.`artist_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `third_view`
--

/*!50001 DROP VIEW IF EXISTS `third_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `third_view` AS select `music`.`music_title` AS `music_title`,`artist`.`artist_name` AS `artist_name`,`genre`.`genre_type` AS `genre_type`,`producer`.`producer_name` AS `producer_name`,`writer`.`writer_name` AS `writer_name` from ((((`music` join `artist` on((`music`.`artist_id` = `artist`.`artist_id`))) join `genre` on((`music`.`genre_id` = `genre`.`genre_id`))) join `producer` on((`music`.`producer_id` = `producer`.`producer_id`))) join `writer` on((`music`.`writer_id` = `writer`.`writer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-28 12:48:09
