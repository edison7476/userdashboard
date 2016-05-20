CREATE DATABASE  IF NOT EXISTS `userdashboard` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `userdashboard`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: userdashboard
-- ------------------------------------------------------
-- Server version	5.5.41-log

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_users1_idx` (`user_id`),
  KEY `fk_comments_posts1_idx` (`post_id`),
  CONSTRAINT `fk_comments_posts1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'hi milani','2016-05-18 21:37:55',NULL,11,13),(2,'hihi','2016-05-18 21:58:40',NULL,11,13),(3,'hi, edison','2016-05-18 22:09:36',NULL,11,11),(4,'Hello, Mike This is Edison','2016-05-18 22:09:56',NULL,11,10),(5,'hi milani','2016-05-18 22:11:41',NULL,12,12),(6,'hello milain','2016-05-18 22:12:09',NULL,12,15),(7,'hey, you better response me ','2016-05-18 22:13:37',NULL,11,11),(8,'hi this is shran','2016-05-18 22:14:21',NULL,11,10),(9,'hi milani','2016-05-18 22:20:44',NULL,15,12),(10,'hi sharon','2016-05-19 17:01:05',NULL,11,11),(11,'you suck too','2016-05-19 17:10:22',NULL,11,17),(12,'hey daddy','2016-05-19 17:13:33',NULL,14,18),(13,'hi this is Edison','2016-05-19 17:32:24',NULL,14,18),(14,'hello this is milani\r\n','2016-05-19 17:32:54',NULL,14,18),(15,'I need to update github files\r\n','2016-05-19 21:37:02',NULL,11,19);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post` varchar(255) DEFAULT NULL,
  `wall_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_posts_users_idx` (`user_id`),
  CONSTRAINT `fk_posts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'hello',NULL,'2016-05-17 19:32:39',NULL,11),(2,'Hi, I am Sharon',NULL,'2016-05-17 20:00:51',NULL,12),(3,'Hi, I am Sharon',NULL,'2016-05-17 20:01:53',NULL,12),(4,'Hi, I am Sharon',NULL,'2016-05-17 20:02:56',NULL,12),(5,'Hi, this is sharon',NULL,'2016-05-17 20:05:43',NULL,12),(6,'Hi, this is sharon',NULL,'2016-05-17 20:06:49',NULL,12),(7,'Hi, this is sharon',NULL,'2016-05-17 20:07:12',NULL,12),(8,'Hello, this is Sharon',NULL,'2016-05-17 20:14:21',NULL,12),(9,'give one more try!',NULL,'2016-05-17 20:17:56',NULL,12),(10,'hi, mike',13,'2016-05-17 22:09:40',NULL,12),(11,'Hi, Edison ',11,'2016-05-17 22:19:08',NULL,12),(12,'Hello, Dad',11,'2016-05-17 22:22:37',NULL,14),(13,'Hi, mommy!',12,'2016-05-17 22:22:47',NULL,14),(14,'Hi, xia xia',14,'2016-05-17 22:24:55',NULL,11),(15,'hello milani',14,'2016-05-18 21:37:41',NULL,11),(16,'hey, mike this is edison',13,'2016-05-18 22:16:17',NULL,11),(17,'hi you suck',11,'2016-05-18 22:20:34',NULL,15),(18,'hows it going Sharon',12,'2016-05-19 17:11:28',NULL,11),(19,'it works on localhost',12,'2016-05-19 21:36:18',NULL,11);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'edison','wang','edison7476@hotmail.com','$2b$12$aYB7zkHVSzl4vTeG4xSkruMusZ/HnfYV3rf.EYK9N5icde.zYdzVi',3,'2016-05-17 19:03:29',NULL),(12,'Sharon','chen','sharon7476@hotmail.com','$2b$12$YDuMm8bM0V8pdCpMKBUifORySzoOLuWEPRDEt7uaeq6UQN6VmVdbO',0,'2016-05-17 19:04:05',NULL),(13,'Michael','Micky','mike7476@hotmail.com','$2b$12$z8mvPP4rCfWBrIidzUZFCuysWfgUEM5C872GLpheFgJc7BS0rPl1i',0,'2016-05-17 19:04:59',NULL),(14,'milani','wang','milani7476@hotmail.com','$2b$12$8KEswzWQdJVbkqYMbfutDuBGIfXtPiUuSjGh1xdDxGMALsmmBoiry',0,'2016-05-17 22:22:24',NULL),(15,'joy','wang','joy7476@hotmail.com','$2b$12$0xtVOJb0Lf8EVlBYUiKkVeRrt5HQaJJn0I84UgLj6brcaaxr86EMG',0,'2016-05-18 22:20:21',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-19 22:28:54
