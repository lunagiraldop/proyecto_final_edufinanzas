CREATE DATABASE  IF NOT EXISTS `juego_finanzas` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `juego_finanzas`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: juego_finanzas
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfiles` (
  `id_perfil` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `nombre_perfil` varchar(50) NOT NULL,
  `edad` int DEFAULT NULL,
  `foto_perfil` varchar(255) DEFAULT 'default.png',
  `monedas` int DEFAULT '0',
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `nombre_perfil` (`nombre_perfil`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `perfiles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
INSERT INTO `perfiles` VALUES (1,1,'Juanito',15,'juan.png',5),(2,2,'Mari',17,'mari.png',150),(3,3,'AdminPerfil',25,'admin.png',1025),(4,1,'Perfil de prueba',22,'perfiles/default.png',0),(5,1,'Perfil de prueba2 actualizacion',33,NULL,0),(7,7,'Administrador',30,'perfiles/default.png',0),(10,14,'hola',13,'perfiles/default.png',0),(11,15,'TestUser',25,'perfiles/default.png',0),(12,16,'Usuario2',28,'perfiles/default.png',0),(13,17,'TestFinal',25,'perfiles/default.png',0),(15,19,'sara',25,'perfiles/default.png',63),(16,11,'lunaGP',0,'luna.png',0),(17,20,'Test User 1763681198',25,'perfiles/default.png',0);
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `progreso`
--

DROP TABLE IF EXISTS `progreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `progreso` (
  `id_progreso` int NOT NULL AUTO_INCREMENT,
  `id_perfil` int DEFAULT NULL,
  `id_reto` int DEFAULT NULL,
  `completado` tinyint(1) DEFAULT '0',
  `fecha_completado` timestamp NULL DEFAULT NULL,
  `respuesta_seleccionada` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_progreso`),
  KEY `id_perfil` (`id_perfil`),
  KEY `id_reto` (`id_reto`),
  CONSTRAINT `progreso_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`) ON DELETE CASCADE,
  CONSTRAINT `progreso_ibfk_2` FOREIGN KEY (`id_reto`) REFERENCES `retos` (`id_reto`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progreso`
--

LOCK TABLES `progreso` WRITE;
/*!40000 ALTER TABLE `progreso` DISABLE KEYS */;
INSERT INTO `progreso` VALUES (1,1,1,1,'2025-11-19 05:59:01','Guardar dinero'),(3,2,1,1,'2025-11-19 05:59:01','Guardar dinero'),(8,1,9,NULL,NULL,NULL),(16,1,8,NULL,NULL,NULL),(26,15,1,1,'2025-11-20 21:48:48','Guardar dinero'),(27,15,8,1,'2025-11-20 21:49:08','prueba'),(28,15,9,1,'2025-11-20 21:49:23','2'),(29,15,4,1,'2025-11-20 21:49:43','Comprar activos'),(30,15,6,NULL,NULL,NULL);
/*!40000 ALTER TABLE `progreso` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_sumar_monedas_al_completar_reto` AFTER INSERT ON `progreso` FOR EACH ROW BEGIN
  DECLARE v_recompensa INT DEFAULT 0;

  -- Si el reto se completo correctamente
  IF NEW.completado = TRUE THEN
    SELECT recompensa_monedas INTO v_recompensa
    FROM retos
    WHERE id_reto = NEW.id_reto;

    UPDATE perfiles
    SET monedas = monedas + v_recompensa
    WHERE id_perfil = NEW.id_perfil;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `devolver_monedas_progreso` AFTER DELETE ON `progreso` FOR EACH ROW BEGIN
    DECLARE v_costo INT;

    -- Solo devolver monedas si el reto NO estaba completado
    IF OLD.completado IS NULL OR OLD.completado = FALSE THEN
        -- Obtener el costo del reto eliminado
        SELECT costo_monedas INTO v_costo
        FROM retos
        WHERE id_reto = OLD.id_reto;

        -- Devolver las monedas al perfil
        UPDATE perfiles
        SET monedas = monedas + v_costo
        WHERE id_perfil = OLD.id_perfil;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `retos`
--

DROP TABLE IF EXISTS `retos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retos` (
  `id_reto` int NOT NULL AUTO_INCREMENT,
  `nombre_reto` varchar(100) DEFAULT NULL,
  `id_tema` int DEFAULT NULL,
  `descripcion` text,
  `pregunta` text,
  `img_reto` varchar(255) DEFAULT 'default_reto.png',
  `recompensa_monedas` int DEFAULT '0',
  `costo_monedas` int DEFAULT '0',
  `respuesta_uno` varchar(100) DEFAULT NULL,
  `respuesta_dos` varchar(100) DEFAULT NULL,
  `respuesta_tres` varchar(100) DEFAULT NULL,
  `respuesta_cuatro` varchar(100) DEFAULT NULL,
  `respuestaCorrecta` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_reto`),
  KEY `id_tema` (`id_tema`),
  CONSTRAINT `retos_ibfk_1` FOREIGN KEY (`id_tema`) REFERENCES `temas` (`id_tema`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retos`
--

LOCK TABLES `retos` WRITE;
/*!40000 ALTER TABLE `retos` DISABLE KEYS */;
INSERT INTO `retos` VALUES (1,'Reto del Ahorro',1,'Aprende a ahorrar','¿Qué es ahorrar?','default_reto.png',20,0,'Gastar más','Guardar dinero','Pedir prestado','Invertir','Guardar dinero'),(4,'hola',3,'Primera inversión','¿Qué es una inversión?',NULL,40,0,'Gastar dinero','Comprar activos','Pedir prestado','Pagos diarios','Comprar activos'),(6,'gbdfg',3,'dfghfdg','dfgh',NULL,10,5,'fdgh','dfgh','dfgh','hdfgh','hdfgh'),(8,'reto 2',1,'prueba','prueba',NULL,8,5,'prueba','2','3','4','prueba'),(9,'crear',2,'preuba','prueba',NULL,15,10,'1','2','prueba','4','2');
/*!40000 ALTER TABLE `retos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temas`
--

DROP TABLE IF EXISTS `temas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temas` (
  `id_tema` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text,
  `img_tema` varchar(255) DEFAULT 'default_tema.png',
  `informacion_tema` text,
  PRIMARY KEY (`id_tema`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temas`
--

LOCK TABLES `temas` WRITE;
/*!40000 ALTER TABLE `temas` DISABLE KEYS */;
INSERT INTO `temas` VALUES (1,'Ahorro Básico','Conceptos iniciales de ahorro','default_tema.png','Aprenderás a ahorrar de forma sencilla.'),(2,'Crédito y Deudas','Qué son y cómo manejarlas','default_tema.png','Información sobre préstamos y deuda responsable.'),(3,'editar','editarPrimeros pasos en inversión',NULL,'editarIntroducción a fondos, acciones y riesgos.'),(7,'svfsdvv','fdsvsd',NULL,'vsdfvs');
/*!40000 ALTER TABLE `temas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tips_periodicas`
--

DROP TABLE IF EXISTS `tips_periodicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tips_periodicas` (
  `id_recompensa` int NOT NULL AUTO_INCREMENT,
  `id_perfil` int DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_recompensa`),
  KEY `id_perfil` (`id_perfil`),
  CONSTRAINT `tips_periodicas_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id_perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tips_periodicas`
--

LOCK TABLES `tips_periodicas` WRITE;
/*!40000 ALTER TABLE `tips_periodicas` DISABLE KEYS */;
INSERT INTO `tips_periodicas` VALUES (1,1,'Tip de ahorro','Ahorrar el 10% de tus ingresos.'),(2,1,'Gasto inteligente','2'),(10,1,'vsjdfv','dsds');
/*!40000 ALTER TABLE `tips_periodicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `rol` enum('Usuario','Administrador') DEFAULT 'Usuario',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'juan@example.com','pbkdf2_sha256$1000000$jDmyfoSN3TEGpZkNr3XPQe$6W9FKF+YKGCEteY0DofuH4c+Eu2AF5PZLXQ2RmYcPOE=','Administrador','2025-11-19 05:59:01'),(2,'maria@example.com','pass456','Usuario','2025-11-19 05:59:01'),(3,'admin@example.com','adminpass','Administrador','2025-11-19 05:59:01'),(7,'admin@edufinanzas.com','pbkdf2_sha256$1000000$AzuY5UBqIw3KFR0lTHYWOY$50I6ZQGZ/OjHyAbXoi5DEZ9vTyNjX9/L2vIb95a9ei0=','Administrador','2025-11-20 07:35:55'),(11,'luna.giraldo.p@uniautonoma.edu.co','pbkdf2_sha256$1000000$fmoykxqRDhPwLgsgPpEl2k$9EYf0NB2QT8xXtMgN1amtfJy8qV3AdbYBcnVewegWTI=','Usuario','2025-11-20 10:19:57'),(14,'hola2@hola.com','pbkdf2_sha256$1000000$9NW8Plhn8Ty1TeLD6bvxT2$cGf23AcLYuz2tB0hxRhPmNCS9EMfEQRwJw50mMPSbbM=','Usuario','2025-11-20 16:06:20'),(15,'test@test.com','pbkdf2_sha256$1000000$NUi7UUbItBYrej37cPvZRF$8AtNcj5/PPBKLQq9PKuS+s0x7OVQp8gAkxnL46FFJ4A=','Usuario','2025-11-20 16:14:26'),(16,'prueba2@test.com','pbkdf2_sha256$1000000$9UgdOjpfNSkx06XGS3Fhjg$QuAOl0INmUrNHH18OQtfr23xP6kr2E9K3ceQA9mktVM=','Usuario','2025-11-20 16:16:14'),(17,'testfinal@edufinanzas.com','pbkdf2_sha256$1000000$518lY31htyL8qAuYUqwcHL$kPEylmySZIxwRz0ih63IkvdcplECGpGADiL9BGphRGE=','Usuario','2025-11-20 16:20:18'),(19,'sara.munoz.q@uniautonoma.edu.co','pbkdf2_sha256$1000000$3eT2HMuZplli46UOH1t3ls$AApD6oOntfzzqvFEiU7OsoJ6JchNbYcAMQbAoyBbJ9I=','Usuario','2025-11-20 19:14:28'),(20,'test1763681198@test.com','pbkdf2_sha256$1000000$Qx5MOcdezwUr3ijKIAdkjz$1zghs/lLQuSfF+dTgyas+lBjEhNDMsPt/2O3YaHTNbM=','Usuario','2025-11-20 23:26:41');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_administradores_perfiles`
--

DROP TABLE IF EXISTS `vista_administradores_perfiles`;
/*!50001 DROP VIEW IF EXISTS `vista_administradores_perfiles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_administradores_perfiles` AS SELECT 
 1 AS `id_usuario`,
 1 AS `correo`,
 1 AS `id_perfil`,
 1 AS `nombre_perfil`,
 1 AS `monedas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_progreso_completado`
--

DROP TABLE IF EXISTS `vista_progreso_completado`;
/*!50001 DROP VIEW IF EXISTS `vista_progreso_completado`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_progreso_completado` AS SELECT 
 1 AS `id_progreso`,
 1 AS `perfil`,
 1 AS `reto`,
 1 AS `fecha_completado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_resumen_perfiles`
--

DROP TABLE IF EXISTS `vista_resumen_perfiles`;
/*!50001 DROP VIEW IF EXISTS `vista_resumen_perfiles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_resumen_perfiles` AS SELECT 
 1 AS `id_perfil`,
 1 AS `nombre_perfil`,
 1 AS `usuario_correo`,
 1 AS `monedas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_retos_temas`
--

DROP TABLE IF EXISTS `vista_retos_temas`;
/*!50001 DROP VIEW IF EXISTS `vista_retos_temas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_retos_temas` AS SELECT 
 1 AS `id_reto`,
 1 AS `descripcion_reto`,
 1 AS `pregunta`,
 1 AS `recompensa_monedas`,
 1 AS `respuesta_uno`,
 1 AS `respuesta_dos`,
 1 AS `respuesta_tres`,
 1 AS `respuesta_cuatro`,
 1 AS `respuestaCorrecta`,
 1 AS `id_tema`,
 1 AS `nombre_tema`,
 1 AS `descripcion_tema`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_usuarios_perfiles`
--

DROP TABLE IF EXISTS `vista_usuarios_perfiles`;
/*!50001 DROP VIEW IF EXISTS `vista_usuarios_perfiles`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_usuarios_perfiles` AS SELECT 
 1 AS `id_usuario`,
 1 AS `correo`,
 1 AS `id_perfil`,
 1 AS `nombre_perfil`,
 1 AS `monedas`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'juego_finanzas'
--

--
-- Dumping routines for database 'juego_finanzas'
--
/*!50003 DROP PROCEDURE IF EXISTS `calcular_progreso_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcular_progreso_usuario`(IN p_id_perfil INT)
BEGIN
                    DECLARE v_total_retos INT DEFAULT 0;
                    DECLARE v_retos_completados INT DEFAULT 0;
                    DECLARE v_porcentaje DECIMAL(5,2) DEFAULT 0.0;

                    SELECT COUNT(*) INTO v_total_retos FROM retos;

                    SELECT COUNT(*) INTO v_retos_completados
                    FROM progreso
                    WHERE id_perfil = p_id_perfil AND completado = TRUE;

                    IF v_total_retos > 0 THEN
                        SET v_porcentaje = (v_retos_completados * 100.0) / v_total_retos;
                    END IF;

                    SELECT
                        v_total_retos AS total_retos,
                        v_retos_completados AS retos_completados,
                        v_porcentaje AS porcentaje_completado;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `informacion_retos_solucionados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `informacion_retos_solucionados`(IN p_id INT)
BEGIN
  SELECT p.id_progreso, per.nombre_perfil, p.id_reto, p.completado, p.fecha_completado, p.respuesta_seleccionada 
  FROM progreso p
  inner join perfiles per on per.id_perfil = p.id_perfil
  WHERE p.id_perfil = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `iniciar_reto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `iniciar_reto`(
                    IN p_id_perfil INT,
                    IN p_id_reto INT
                )
BEGIN
                    DECLARE v_costo INT;
                    DECLARE v_monedas_actuales INT;
                    DECLARE v_progreso_existente INT;
                    DECLARE v_id_progreso INT;

                    SELECT costo_monedas INTO v_costo
                    FROM retos
                    WHERE id_reto = p_id_reto;

                    SELECT monedas INTO v_monedas_actuales
                    FROM perfiles
                    WHERE id_perfil = p_id_perfil;

                    SELECT COUNT(*) INTO v_progreso_existente
                    FROM progreso
                    WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;

                    IF v_progreso_existente > 0 THEN
                        SELECT
                            id_progreso,
                            id_perfil,
                            id_reto,
                            completado,
                            fecha_completado,
                            respuesta_seleccionada
                        FROM progreso
                        WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;
                    ELSE
                        IF v_monedas_actuales < v_costo THEN
                            SIGNAL SQLSTATE '45000'
                            SET MESSAGE_TEXT = 'Monedas insuficientes para iniciar este reto';
                        END IF;

                        UPDATE perfiles
                        SET monedas = monedas - v_costo
                        WHERE id_perfil = p_id_perfil;

                        INSERT INTO progreso (id_perfil, id_reto, completado, fecha_completado, respuesta_seleccionada)
                        VALUES (p_id_perfil, p_id_reto, NULL, NULL, NULL);

                        SET v_id_progreso = LAST_INSERT_ID();

                        SELECT
                            id_progreso,
                            id_perfil,
                            id_reto,
                            completado,
                            fecha_completado,
                            respuesta_seleccionada
                        FROM progreso
                        WHERE id_progreso = v_id_progreso;
                    END IF;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `iniciar_reto_debug` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `iniciar_reto_debug`(
    IN p_id_perfil INT,
    IN p_id_reto INT
)
BEGIN
    DECLARE v_costo INT;
    DECLARE v_monedas_actuales INT;
    DECLARE v_progreso_existente INT;
    DECLARE v_id_progreso INT;

    -- Obtener costo del reto
    SELECT costo_monedas INTO v_costo
    FROM retos
    WHERE id_reto = p_id_reto;

    -- Obtener monedas del perfil
    SELECT monedas INTO v_monedas_actuales
    FROM perfiles
    WHERE id_perfil = p_id_perfil;

    -- Verificar progreso existente
    SELECT COUNT(*) INTO v_progreso_existente
    FROM progreso
    WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;

    -- RETORNAR VALORES PARA DEBUG
    SELECT
        p_id_perfil AS param_id_perfil,
        p_id_reto AS param_id_reto,
        v_costo AS variable_costo,
        v_monedas_actuales AS variable_monedas_actuales,
        v_progreso_existente AS variable_progreso_existente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_perfil_por_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_perfil_por_usuario`(IN p_id_usuario INT)
BEGIN
                    SELECT
                        id_perfil,
                        id_usuario,
                        nombre_perfil,
                        edad,
                        foto_perfil,
                        monedas
                    FROM perfiles
                    WHERE id_usuario = p_id_usuario
                    LIMIT 1;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_progreso_por_temas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_progreso_por_temas`(
    IN p_id_perfil INT
)
BEGIN
    SELECT
        t.id_tema,
        t.nombre AS nombre_tema,
        COUNT(r.id_reto) AS total_retos,
        COALESCE(SUM(CASE WHEN p.completado = TRUE THEN 1 ELSE 0 END), 0) AS retos_completados,
        CASE
            WHEN COUNT(r.id_reto) > 0 AND
                 COALESCE(SUM(CASE WHEN p.completado = TRUE THEN 1 ELSE 0 END), 0) = COUNT(r.id_reto)
            THEN TRUE
            ELSE FALSE
        END AS esta_completado
    FROM temas t
    LEFT JOIN retos r ON t.id_tema = r.id_tema
    LEFT JOIN progreso p ON r.id_reto = p.id_reto AND p.id_perfil = p_id_perfil
    GROUP BY t.id_tema, t.nombre
    ORDER BY t.id_tema ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_retos_por_tema` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_retos_por_tema`(
                    IN p_id_tema INT,
                    IN p_id_perfil INT
                )
BEGIN
                    SELECT
                        r.id_reto,
                        r.nombre_reto,
                        r.id_tema,
                        r.descripcion,
                        r.pregunta,
                        r.img_reto,
                        r.recompensa_monedas,
                        r.costo_monedas,
                        r.respuesta_uno,
                        r.respuesta_dos,
                        r.respuesta_tres,
                        r.respuesta_cuatro,
                        p.id_progreso,
                        p.completado,
                        p.fecha_completado,
                        p.respuesta_seleccionada
                    FROM retos r
                    LEFT JOIN progreso p ON r.id_reto = p.id_reto AND p.id_perfil = p_id_perfil
                    WHERE r.id_tema = p_id_tema
                    ORDER BY r.id_reto ASC;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfil_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfil_actualizar`(
    IN p_id_perfil INT,
    IN p_nombre_perfil VARCHAR(50),
    IN p_foto_perfil VARCHAR(255),
    IN p_edad INT
)
BEGIN
    UPDATE perfiles
    SET nombre_perfil = p_nombre_perfil,
        foto_perfil = p_foto_perfil,
        edad = p_edad
    WHERE id_perfil = p_id_perfil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfil_crear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfil_crear`( IN p_id_usuario INT, IN p_nombre_perfil VARCHAR(50), IN p_edad INT, IN p_foto_perfil VARCHAR(255) )
BEGIN INSERT INTO perfiles (id_usuario, nombre_perfil, edad, foto_perfil, monedas) VALUES (p_id_usuario, p_nombre_perfil, p_edad, p_foto_perfil, 0); SELECT LAST_INSERT_ID() AS id_perfil; END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfil_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfil_eliminar`(IN p_id INT)
BEGIN
    DELETE FROM perfiles WHERE id_perfil = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfil_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfil_listar`()
BEGIN
    SELECT *
  FROM perfiles
  ORDER BY id_perfil DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfil_ver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfil_ver`(IN p_id INT)
BEGIN
    SELECT * FROM perfiles WHERE id_perfil = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `progresos_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `progresos_actualizar`(
  IN p_id INT,
  IN p_id_perfil INT,
  IN p_id_reto INT,
  IN p_completado BOOLEAN,
  IN p_fecha_completado TIMESTAMP
)
BEGIN
  UPDATE progreso
  SET
    id_perfil = p_id_perfil,
    id_reto = p_id_reto,
    completado = p_completado,
    fecha_completado = p_fecha_completado
  WHERE id_progreso = p_id;

  SELECT ROW_COUNT() AS filas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `progresos_crear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `progresos_crear`(
  IN p_id_perfil INT,
  IN p_id_reto INT,
  IN p_completado BOOLEAN,
  IN p_fecha_completado TIMESTAMP
)
BEGIN
  INSERT INTO progreso (id_perfil, id_reto, completado, fecha_completado)
  VALUES (p_id_perfil, p_id_reto, p_completado, p_fecha_completado);
  SELECT LAST_INSERT_ID() AS id_progreso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `progresos_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `progresos_eliminar`(IN p_id INT)
BEGIN
  DELETE FROM progreso WHERE id_progreso = p_id;
  SELECT ROW_COUNT() AS filas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `progresos_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `progresos_listar`()
BEGIN
  SELECT *
  FROM progreso
  ORDER BY id_progreso DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `progreso_ver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `progreso_ver`(IN p_id INT)
BEGIN
  SELECT *
  FROM progreso
  WHERE id_progreso = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `retos_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `retos_actualizar`(
  IN p_id INT,
  IN p_nombre_reto VARCHAR(100),
  IN p_id_tema INT,
  IN p_descripcion TEXT,
  IN p_pregunta TEXT,
  IN p_img_reto VARCHAR(255),
  IN p_recompensa_monedas INT,
  IN p_costo_monedas INT,
  IN p_respuesta_uno VARCHAR(100),
  IN p_respuesta_dos VARCHAR(100),
  IN p_respuesta_tres VARCHAR(100),
  IN p_respuesta_cuatro VARCHAR(100),
  IN p_respuestaCorrecta VARCHAR(100)
)
BEGIN
  UPDATE retos
  SET
    nombre_reto = p_nombre_reto,
    id_tema = p_id_tema,
    descripcion = p_descripcion,
    pregunta = p_pregunta,
    img_reto = p_img_reto,
    recompensa_monedas = p_recompensa_monedas,
    costo_monedas = p_costo_monedas,
    respuesta_uno = p_respuesta_uno,
    respuesta_dos = p_respuesta_dos,
    respuesta_tres = p_respuesta_tres,
    respuesta_cuatro = p_respuesta_cuatro,
    respuestaCorrecta = p_respuestaCorrecta
  WHERE id_reto = p_id;

  SELECT ROW_COUNT() AS filas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `retos_crear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `retos_crear`(
  IN p_nombre_reto VARCHAR(100),
  IN p_id_tema INT,
  IN p_descripcion TEXT,
  IN p_pregunta TEXT,
  IN p_img_reto VARCHAR(255),
  IN p_recompensa_monedas INT,
  IN p_costo_monedas INT,
  IN p_respuesta_uno VARCHAR(100),
  IN p_respuesta_dos VARCHAR(100),
  IN p_respuesta_tres VARCHAR(100),
  IN p_respuesta_cuatro VARCHAR(100),
  IN p_respuestaCorrecta VARCHAR(100)
)
BEGIN
  INSERT INTO retos (
    nombre_reto, id_tema, descripcion, pregunta, img_reto,
    recompensa_monedas, costo_monedas ,respuesta_uno, respuesta_dos,
    respuesta_tres, respuesta_cuatro, respuestaCorrecta
  )
  VALUES (
	p_nombre_reto, p_id_tema, p_descripcion, p_pregunta, p_img_reto,
    p_recompensa_monedas, p_costo_monedas, p_respuesta_uno, p_respuesta_dos,
    p_respuesta_tres, p_respuesta_cuatro, p_respuestaCorrecta
  );

  SELECT LAST_INSERT_ID() AS id_reto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `retos_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `retos_eliminar`(IN p_id INT)
BEGIN
  DELETE FROM retos WHERE id_reto = p_id;
  SELECT ROW_COUNT() AS filas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `retos_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `retos_listar`()
BEGIN
  SELECT *
  FROM retos
  ORDER BY id_reto DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `reto_ver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `reto_ver`(IN p_id INT)
BEGIN
  SELECT *
  FROM retos
  WHERE id_reto = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `solucionar_reto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `solucionar_reto`(
                    IN p_id_perfil INT,
                    IN p_id_reto INT,
                    IN p_respuesta_seleccionada VARCHAR(100)
                )
BEGIN
                    DECLARE v_respuesta VARCHAR(100);
                    DECLARE v_completado BOOLEAN;
                    DECLARE v_fecha_completado TIMESTAMP;
                    DECLARE v_progreso_existente INT DEFAULT 0;
                    DECLARE v_recompensa_monedas INT DEFAULT 0;
                    DECLARE v_ya_completado BOOLEAN DEFAULT FALSE;

                    SELECT respuestaCorrecta, recompensa_monedas
                    INTO v_respuesta, v_recompensa_monedas
                    FROM retos
                    WHERE id_reto = p_id_reto;

                    SELECT COUNT(*), COALESCE(MAX(completado), FALSE)
                    INTO v_progreso_existente, v_ya_completado
                    FROM progreso
                    WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;

                    IF v_progreso_existente = 0 THEN
                        SIGNAL SQLSTATE '45000'
                        SET MESSAGE_TEXT = 'Debe iniciar el reto antes de solucionarlo';
                    END IF;

                    IF v_ya_completado = TRUE THEN
                        SELECT
                            id_progreso,
                            id_perfil,
                            id_reto,
                            completado,
                            fecha_completado,
                            respuesta_seleccionada
                        FROM progreso
                        WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;
                    ELSE
                        IF v_respuesta = p_respuesta_seleccionada THEN
                            SET v_completado = TRUE;
                            SET v_fecha_completado = NOW();

                            UPDATE progreso
                            SET
                                completado = v_completado,
                                fecha_completado = v_fecha_completado,
                                respuesta_seleccionada = p_respuesta_seleccionada
                            WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;

                            UPDATE perfiles
                            SET monedas = monedas + v_recompensa_monedas
                            WHERE id_perfil = p_id_perfil;

                            SELECT
                                id_progreso,
                                id_perfil,
                                id_reto,
                                completado,
                                fecha_completado,
                                respuesta_seleccionada
                            FROM progreso
                            WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;
                        ELSE
                            UPDATE progreso
                            SET respuesta_seleccionada = p_respuesta_seleccionada
                            WHERE id_perfil = p_id_perfil AND id_reto = p_id_reto;

                            SELECT NULL AS id_progreso;
                        END IF;
                    END IF;
                END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `temas_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `temas_actualizar`(
IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_img_tema varchar(255),
    IN p_informacion TEXT
)
BEGIN
    UPDATE temas SET nombre = p_nombre, descripcion = p_descripcion, img_tema = p_img_tema, informacion_tema = p_informacion WHERE id_tema = p_id;
    SELECT ROW_COUNT() AS filas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `temas_crear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `temas_crear`(
  IN p_nombre VARCHAR(100),
  IN p_descripcion TEXT,
  IN p_img_tema varchar(255),
  IN p_informacion TEXT
)
BEGIN
  INSERT INTO temas(nombre, descripcion, img_tema, informacion_tema) VALUES (p_nombre, p_descripcion, p_img_tema, p_informacion);
  SELECT LAST_INSERT_ID() AS id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `temas_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `temas_eliminar`(IN p_id INT)
BEGIN
DELETE FROM temas WHERE id_tema = p_id;
    SELECT ROW_COUNT() AS filas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `temas_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `temas_listar`()
BEGIN
SELECT * FROM temas;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tema_ver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tema_ver`(IN p_id INT)
BEGIN
SELECT * FROM temas WHERE id_tema = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tip_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tip_actualizar`(
    IN p_id_recompensa INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    UPDATE tips_periodicas
    SET nombre = p_nombre,
        descripcion = p_descripcion
    WHERE id_recompensa = p_id_recompensa;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tip_crear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tip_crear`(
    IN p_id_perfil INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT
)
BEGIN
    INSERT INTO tips_periodicas (id_perfil, nombre, descripcion)
    VALUES (p_id_perfil, p_nombre, p_descripcion);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tip_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tip_eliminar`(IN p_id INT)
BEGIN
    DELETE FROM tips_periodicas WHERE id_recompensa = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tip_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tip_listar`()
BEGIN
    SELECT t.id_recompensa, p.nombre_perfil, t.nombre, t.descripcion
    FROM tips_periodicas t
    JOIN perfiles p ON t.id_perfil = p.id_perfil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tip_ver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tip_ver`(IN p_id INT)
BEGIN
    SELECT * FROM tips_periodicas WHERE id_recompensa = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarios_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_actualizar`(
    IN p_id_usuario INT,
    IN p_correo VARCHAR(100),
    IN p_contrasena VARCHAR(255),
    IN p_rol ENUM('Usuario', 'Administrador')
)
BEGIN
    UPDATE usuarios
    SET correo = p_correo,
        contrasena = p_contrasena,
        rol = p_rol
    WHERE id_usuario = p_id_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarios_crear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_crear`(
    IN p_correo VARCHAR(100),
    IN p_contrasena VARCHAR(255),
    IN p_rol ENUM('Usuario', 'Administrador')
)
BEGIN
    INSERT INTO usuarios (correo, contrasena, rol)
    VALUES (p_correo, p_contrasena, p_rol);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarios_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_eliminar`(IN p_id INT)
BEGIN
    DELETE FROM usuarios WHERE id_usuario = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarios_listar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_listar`()
BEGIN
    SELECT id_usuario, correo, rol, fecha_registro
    FROM usuarios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarios_logear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarios_logear`(IN p_correo varchar(100))
BEGIN
    SELECT id_usuario, correo, contrasena, rol
    FROM usuarios WHERE correo = p_correo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuario_ver` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuario_ver`(IN p_id INT)
BEGIN
    SELECT id_usuario, correo, rol, fecha_registro
    FROM usuarios
    WHERE id_usuario = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `verificar_tema_completado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `verificar_tema_completado`(
    IN p_id_tema INT,
    IN p_id_perfil INT
)
BEGIN
    DECLARE v_total_retos INT DEFAULT 0;
    DECLARE v_retos_completados INT DEFAULT 0;
    DECLARE v_esta_completado BOOLEAN DEFAULT FALSE;

    -- Contar total de retos del tema
    SELECT COUNT(*) INTO v_total_retos
    FROM retos
    WHERE id_tema = p_id_tema;

    -- Contar retos completados por el usuario en este tema
    SELECT COUNT(*) INTO v_retos_completados
    FROM progreso p
    INNER JOIN retos r ON p.id_reto = r.id_reto
    WHERE r.id_tema = p_id_tema
      AND p.id_perfil = p_id_perfil
      AND p.completado = TRUE;

    -- Determinar si el tema esta completado
    IF v_total_retos > 0 AND v_retos_completados = v_total_retos THEN
        SET v_esta_completado = TRUE;
    END IF;

    -- Retornar estadisticas
    SELECT
        p_id_tema AS id_tema,
        v_total_retos AS total_retos,
        v_retos_completados AS retos_completados,
        v_esta_completado AS esta_completado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vista_administradores_perfiles`
--

/*!50001 DROP VIEW IF EXISTS `vista_administradores_perfiles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_administradores_perfiles` AS select `u`.`id_usuario` AS `id_usuario`,`u`.`correo` AS `correo`,`p`.`id_perfil` AS `id_perfil`,`p`.`nombre_perfil` AS `nombre_perfil`,`p`.`monedas` AS `monedas` from (`usuarios` `u` join `perfiles` `p` on((`u`.`id_usuario` = `p`.`id_usuario`))) where (`u`.`rol` = 'Administrador') order by `u`.`id_usuario` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_progreso_completado`
--

/*!50001 DROP VIEW IF EXISTS `vista_progreso_completado`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_progreso_completado` AS select `p`.`id_progreso` AS `id_progreso`,`per`.`nombre_perfil` AS `perfil`,`r`.`nombre_reto` AS `reto`,`p`.`fecha_completado` AS `fecha_completado` from ((`progreso` `p` join `perfiles` `per` on((`p`.`id_perfil` = `per`.`id_perfil`))) join `retos` `r` on((`p`.`id_reto` = `r`.`id_reto`))) where (`p`.`completado` = true) order by `p`.`fecha_completado` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_resumen_perfiles`
--

/*!50001 DROP VIEW IF EXISTS `vista_resumen_perfiles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_resumen_perfiles` AS select `p`.`id_perfil` AS `id_perfil`,`p`.`nombre_perfil` AS `nombre_perfil`,`u`.`correo` AS `usuario_correo`,`p`.`monedas` AS `monedas` from (`perfiles` `p` join `usuarios` `u` on((`p`.`id_usuario` = `u`.`id_usuario`))) order by `p`.`monedas` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_retos_temas`
--

/*!50001 DROP VIEW IF EXISTS `vista_retos_temas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_retos_temas` AS select `r`.`id_reto` AS `id_reto`,`r`.`descripcion` AS `descripcion_reto`,`r`.`pregunta` AS `pregunta`,`r`.`recompensa_monedas` AS `recompensa_monedas`,`r`.`respuesta_uno` AS `respuesta_uno`,`r`.`respuesta_dos` AS `respuesta_dos`,`r`.`respuesta_tres` AS `respuesta_tres`,`r`.`respuesta_cuatro` AS `respuesta_cuatro`,`r`.`respuestaCorrecta` AS `respuestaCorrecta`,`t`.`id_tema` AS `id_tema`,`t`.`nombre` AS `nombre_tema`,`t`.`descripcion` AS `descripcion_tema` from (`retos` `r` join `temas` `t` on((`r`.`id_tema` = `t`.`id_tema`))) order by `r`.`id_reto` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_usuarios_perfiles`
--

/*!50001 DROP VIEW IF EXISTS `vista_usuarios_perfiles`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_usuarios_perfiles` AS select `u`.`id_usuario` AS `id_usuario`,`u`.`correo` AS `correo`,`p`.`id_perfil` AS `id_perfil`,`p`.`nombre_perfil` AS `nombre_perfil`,`p`.`monedas` AS `monedas` from (`usuarios` `u` join `perfiles` `p` on((`u`.`id_usuario` = `p`.`id_usuario`))) where (`u`.`rol` = 'Usuario') order by `u`.`id_usuario` */;
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

-- Dump completed on 2025-11-20 19:34:54