-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: integrador-final
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `cupon`
--

DROP TABLE IF EXISTS `cupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cupon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) NOT NULL,
  `porcentaje` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupon`
--

LOCK TABLES `cupon` WRITE;
/*!40000 ALTER TABLE `cupon` DISABLE KEYS */;
INSERT INTO `cupon` VALUES (11,'A',0.5),(12,'B',0.7),(13,'C',0.3);
/*!40000 ALTER TABLE `cupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_orden`
--

DROP TABLE IF EXISTS `estado_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_orden` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estado` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_orden`
--

LOCK TABLES `estado_orden` WRITE;
/*!40000 ALTER TABLE `estado_orden` DISABLE KEYS */;
INSERT INTO `estado_orden` VALUES (1,'PENDIENTE APROBACION'),(2,'APROBADA'),(3,'RECHAZADA');
/*!40000 ALTER TABLE `estado_orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generos`
--

DROP TABLE IF EXISTS `generos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `genero` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKi2lf51pph9ftq4g8r1tkr7dyw` (`genero`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generos`
--

LOCK TABLES `generos` WRITE;
/*!40000 ALTER TABLE `generos` DISABLE KEYS */;
INSERT INTO `generos` VALUES (3,'Acción'),(2,'Aventura'),(4,'Ciencia Ficción'),(5,'Comedia'),(1,'Drama');
/*!40000 ALTER TABLE `generos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes`
--

DROP TABLE IF EXISTS `ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_creacion` datetime(6) DEFAULT NULL,
  `monto` double DEFAULT NULL,
  `cupon_id` bigint DEFAULT NULL,
  `estado_id` bigint DEFAULT NULL,
  `socio_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7246bw3aw2fryg5o7kxoyroaq` (`cupon_id`),
  KEY `FKdyyaumyqludsjdk68ishtpohd` (`estado_id`),
  KEY `FK8ilc3n5v0vmqp9ln0m46cikep` (`socio_id`),
  CONSTRAINT `FK7246bw3aw2fryg5o7kxoyroaq` FOREIGN KEY (`cupon_id`) REFERENCES `cupon` (`id`),
  CONSTRAINT `FK8ilc3n5v0vmqp9ln0m46cikep` FOREIGN KEY (`socio_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKdyyaumyqludsjdk68ishtpohd` FOREIGN KEY (`estado_id`) REFERENCES `estado_orden` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes`
--

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
INSERT INTO `ordenes` VALUES (37,'2024-07-21 21:31:31.981228',1850,NULL,3,252),(38,'2024-07-21 21:52:53.961578',750.5,11,2,252),(43,'2024-07-23 22:08:31.476785',2800,NULL,1,252),(44,'2024-07-23 22:46:12.839255',4300,NULL,3,352);
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_peliculas`
--

DROP TABLE IF EXISTS `order_peliculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_peliculas` (
  `order_id` bigint NOT NULL,
  `pelicula_id` bigint NOT NULL,
  PRIMARY KEY (`order_id`,`pelicula_id`),
  KEY `FKqjot0um7mmxnib0rh8r3couuo` (`pelicula_id`),
  CONSTRAINT `FK9tlkkoa0c14xojwayky6510bv` FOREIGN KEY (`order_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `FKqjot0um7mmxnib0rh8r3couuo` FOREIGN KEY (`pelicula_id`) REFERENCES `peliculas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_peliculas`
--

LOCK TABLES `order_peliculas` WRITE;
/*!40000 ALTER TABLE `order_peliculas` DISABLE KEYS */;
INSERT INTO `order_peliculas` VALUES (44,15),(44,16),(44,17);
/*!40000 ALTER TABLE `order_peliculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peliculas`
--

DROP TABLE IF EXISTS `peliculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peliculas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `imagen_url` varchar(1000) DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peliculas`
--

LOCK TABLES `peliculas` WRITE;
/*!40000 ALTER TABLE `peliculas` DISABLE KEYS */;
INSERT INTO `peliculas` VALUES (6,'https://www.moviemars.com/cdn/shop/products/11fe57680e2abab34a3d6fa289447cff.jpg?v=1697000565','Minions','https://www.imdb.com/title/tt2293640/',350),(9,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKcCN7-EKcQtAOmD6j7IqwDVsg6egzlAErBg&s','El Padrino','sitio',4000),(10,'https://portcolborne.niagaraevergreen.ca/opac/extras/ac/jacket/large/r/785138','Toy Story','sitio',2500),(12,'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/f452aa2c-0c64-4bbf-b065-942b8dbda8bb/dfqz91u-1b8c0c46-667f-4f59-90e0-3473a0a57d3d.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2Y0NTJhYTJjLTBjNjQtNGJiZi1iMDY1LTk0MmI4ZGJkYThiYlwvZGZxejkxdS0xYjhjMGM0Ni02NjdmLTRmNTktOTBlMC0zNDczYTBhNTdkM2QuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.6wpjg4_oEl1u0f-Y3LCDa6acnhERmidhZ2G-eheI4J4','Bad Boys IV','https://www.imdb.com/title/tt4919268/',2000),(15,'https://play-lh.googleusercontent.com/6Oz3lpsE6Oyh2qIQDUOBixxcIXQKiRsbvfdOvULqImGiU1hfakMJ8ubsn82dmHpHbyQ','Soy Leyenda','https://www.imdb.com/title/tt2293640/',1500),(16,'https://es.web.img2.acsta.net/pictures/17/08/09/11/26/105383.jpg','Toy Story 2','https://www.imdb.com/title/tt2293640/',1500),(17,'https://mx.web.img3.acsta.net/medias/nmedia/18/68/09/06/20197890.jpg','El Padrino II','-',1300),(18,'https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_FMjpg_UX1000_.jpg','Iron Man','https://www.imdb.com/title/tt0371746/',3000),(19,'https://pics.filmaffinity.com/los_baneros_mas_locos_del_mundo-278356502-mmed.jpg','Los Bañeros Más Locos del Mundo','https://www.imdb.com/title/tt0188442/',2000),(21,'https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_FMjpg_UX1000_.jpg','Avengers: Endgame','https://www.imdb.com/title/tt4154796/',3000),(22,'https://m.media-amazon.com/images/M/MV5BNzlkNzVjMDMtOTdhZC00MGE1LTkxODctMzFmMjkwZmMxZjFhXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_FMjpg_UX1000_.jpg','Fast & Furious','https://www.imdb.com/title/tt1013752/',1500);
/*!40000 ALTER TABLE `peliculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `peliculas_genero`
--

DROP TABLE IF EXISTS `peliculas_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `peliculas_genero` (
  `pelicula_id` bigint NOT NULL,
  `genero_id` int NOT NULL,
  KEY `FK1nfmn2y8mpkmq9jhb7oafwrnk` (`genero_id`),
  KEY `FKnpi8epm5v1ll3jsg91nc2kn9f` (`pelicula_id`),
  CONSTRAINT `FK1nfmn2y8mpkmq9jhb7oafwrnk` FOREIGN KEY (`genero_id`) REFERENCES `generos` (`id`),
  CONSTRAINT `FKnpi8epm5v1ll3jsg91nc2kn9f` FOREIGN KEY (`pelicula_id`) REFERENCES `peliculas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peliculas_genero`
--

LOCK TABLES `peliculas_genero` WRITE;
/*!40000 ALTER TABLE `peliculas_genero` DISABLE KEYS */;
INSERT INTO `peliculas_genero` VALUES (6,5),(6,2),(15,3),(16,2),(17,3),(18,3),(18,4),(12,3),(12,5),(19,5),(10,2),(9,3),(21,2),(21,4),(21,3),(22,3);
/*!40000 ALTER TABLE `peliculas_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKofx66keruapi6vyqpv6f2or37` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (2,'ROLE_ADMIN'),(1,'ROLE_SOCIO');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FKh8ciramu9cc9q3qcqiv4ue8a6` (`role_id`),
  CONSTRAINT `FKh8ciramu9cc9q3qcqiv4ue8a6` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FKhfh9dx7w3ubf1co1vdev94g3f` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (252,1),(302,1),(352,1),(402,1),(454,2),(552,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `activo` bit(1) DEFAULT NULL,
  `fecha_alta` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (252,'fgironte@gmail.com','$2a$10$gODgdTJKVr88wuQB2sJqyuj5CiOiK3JmVVp2vqzNU0aXP.U5h/Lna','Gironte','Facundo',_binary '',NULL),(302,'fgironte2@gmail.com','$2a$10$0T.n7vLG6Vx2ooLgEElcBOOjyo7XEGbajk7RGufBixPoko7GzvPD6','Gironte','Facundo2',_binary '',NULL),(352,'fgironte3@gmail.com','$2a$10$LtwHlHh200hQECyT2LFcfeqQxPdbX8M6PYBlMts5vJQgqE7FK6LXe','Gironte','Facundo3',_binary '',NULL),(402,'facundo','$2a$10$fQVRc6KHiKEOpkwqOmYmZutcpFQZ5/Pq0gT5J/EoHlQAsTO/clO6y','lastname','Nombre USER',_binary '',NULL),(454,'admin mail','$2a$10$modvI6vVj/0aHfvMcF4JL.LGzdvQAYyaUMJMmiFJbTlu2/yNSDENC','lastname','Nombre USER',_binary '','2024-07-22 20:20:45.331627'),(552,'admin','$2a$10$42WhgjJ1Fk8k8Qfn4zRO1erhtQp6OFPsanx5HNnvFVQaodTFe.54e','admin','admin',_binary '','2024-07-22 20:29:51.004360');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_seq`
--

DROP TABLE IF EXISTS `users_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_seq`
--

LOCK TABLES `users_seq` WRITE;
/*!40000 ALTER TABLE `users_seq` DISABLE KEYS */;
INSERT INTO `users_seq` VALUES (651);
/*!40000 ALTER TABLE `users_seq` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-23 23:01:21
