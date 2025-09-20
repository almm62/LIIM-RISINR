/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: RISV1
-- ------------------------------------------------------
-- Server version	10.11.13-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AgendaDeServicio`
--
DROP DATABASE IF EXISTS `RISV1`;
CREATE DATABASE `RISV1`; 
USE `RISV1`; 

DROP TABLE IF EXISTS `AgendaDeServicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AgendaDeServicio` (
  `EquipoImagenologia_NSerie` varchar(50) NOT NULL,
  `Medico_NumEmpleado` int(11) NOT NULL,
  `Medico_CURP` varchar(45) NOT NULL,
  `FechaControlPk` bigint(20) NOT NULL,
  `FechaControl` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `TipoMantenimiento` varchar(45) NOT NULL,
  `EstadoDeManto` varchar(45) NOT NULL,
  `Descrpcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`EquipoImagenologia_NSerie`,`Medico_NumEmpleado`,`Medico_CURP`,`FechaControlPk`),
  KEY `fk_AgendaDeServicio_Medico1_idx` (`Medico_NumEmpleado`,`Medico_CURP`),
  CONSTRAINT `fk_AgendaDeServicio_EquipoImagenologia1` FOREIGN KEY (`EquipoImagenologia_NSerie`) REFERENCES `EquipoImagenologia` (`NSerie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_AgendaDeServicio_Medico1` FOREIGN KEY (`Medico_NumEmpleado`, `Medico_CURP`) REFERENCES `Medico` (`NumEmpleado`, `CURP`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AgendaDeServicio`
--

LOCK TABLES `AgendaDeServicio` WRITE;
/*!40000 ALTER TABLE `AgendaDeServicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `AgendaDeServicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Aplicacion`
--

DROP TABLE IF EXISTS `Aplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aplicacion` (
  `idAplicacion` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idAplicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aplicacion`
--

LOCK TABLES `Aplicacion` WRITE;
/*!40000 ALTER TABLE `Aplicacion` DISABLE KEYS */;
INSERT INTO `Aplicacion` VALUES
(0,'Login','Login al sistema'),
(1,'Consulta de Equipos','Listar equipos existentes en BD'),
(2,'Edicion de Equipo','Editar equipos existentes en BD'),
(3,'Alta de Equipo','Agregar equipo nuevo'),
(4,'Consulta de usuarios','Listar usuarios existentes en BD'),
(5,'Edicion de Usuarios','Editar usuarios existentes en BD'),
(6,'Alta de Usuarios','Alta de usuario nuevo');
/*!40000 ALTER TABLE `Aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AreaDeServicio`
--

DROP TABLE IF EXISTS `AreaDeServicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AreaDeServicio` (
  `idArea` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Descripcion` varchar(120) NOT NULL,
  PRIMARY KEY (`idArea`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AreaDeServicio`
--

LOCK TABLES `AreaDeServicio` WRITE;
/*!40000 ALTER TABLE `AreaDeServicio` DISABLE KEYS */;
INSERT INTO `AreaDeServicio` VALUES
(1,'Rayos X','Cuerpo 6 planta baja'),
(2,'Resonancia Magnetica','Cuerpo 1 plata baja'),
(3,'Tomografía Computada','Cuerpo 6 planta baja'),
(4,'Médicina Núclear','Cuerpo 6 planta baja'),
(5,'Desarrollo Tecnológico','Implementación y soporte de los sistemas '),
(6,'Ultrasonido','Cuerpo 1 planta baja'),
(7,'Densitometria','Cuerpo 1 planta baja'),
(8,'Subdirección de Rehabilitación','Subdirección de Rehabilitación');
/*!40000 ALTER TABLE `AreaDeServicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AsignacionEstudio`
--

DROP TABLE IF EXISTS `AsignacionEstudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `AsignacionEstudio` (
  `EquipoImagenologia_NSerie` varchar(50) NOT NULL,
  `Estudio_idEstudio` int(11) NOT NULL,
  `FechaPk` bigint(20) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`EquipoImagenologia_NSerie`,`Estudio_idEstudio`,`FechaPk`),
  KEY `fk_EquipoImagenologia_has_Estudio_Estudio1_idx` (`Estudio_idEstudio`),
  KEY `fk_EquipoImagenologia_has_Estudio_EquipoImagenologia1_idx` (`EquipoImagenologia_NSerie`),
  CONSTRAINT `fk_EquipoImagenologia_has_Estudio_EquipoImagenologia1` FOREIGN KEY (`EquipoImagenologia_NSerie`) REFERENCES `EquipoImagenologia` (`NSerie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_EquipoImagenologia_has_Estudio_Estudio1` FOREIGN KEY (`Estudio_idEstudio`) REFERENCES `Estudio` (`idEstudio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AsignacionEstudio`
--

LOCK TABLES `AsignacionEstudio` WRITE;
/*!40000 ALTER TABLE `AsignacionEstudio` DISABLE KEYS */;
INSERT INTO `AsignacionEstudio` VALUES
('EQUIPOPRUEBAA1',1,1636732800000,'2021-11-12 16:00:00'),
('EQUIPOPRUEBAA1',1,1636749000000,'2021-11-12 20:30:00'),
('EQUIPOPRUEBAA1',1,1636768800000,'2021-11-12 06:00:00'),
('EQUIPOPRUEBAA1',2,1636747200000,'2021-11-12 20:00:00'),
('EQUIPOPRUEBAA1',3,1636747200000,'2021-11-12 20:00:00'),
('EQUIPOPRUEBAA1',4,1637067600000,'2021-11-16 13:00:00'),
('EQUIPOPRUEBAA1',5,1636753500000,'2021-11-12 21:45:00'),
('EQUIPOPRUEBAA1',6,1636753500000,'2021-11-12 21:45:00'),
('EQUIPOPRUEBAA1',35,1637070300000,'2021-11-16 13:45:00'),
('EQUIPOPRUEBAA2',1,1636748100000,'2021-11-12 20:15:00'),
('EQUIPOPRUEBAA2',2,1636748100000,'2021-11-12 20:15:00'),
('EQUIPOPRUEBAA2',3,1636750800000,'2021-11-12 21:00:00'),
('EQUIPOPRUEBAA2',5,1637067600000,'2021-11-16 13:00:00'),
('EQUIPOPRUEBAA2',6,1637071200000,'2021-11-16 14:00:00'),
('EQUIPOPRUEBAA2',36,1636756200000,'2021-11-12 22:30:00'),
('EQUIPOPRUEBAA2',37,1636750800000,'2021-11-12 21:00:00'),
('EQUIPOPRUEBAA3',1,1636751700000,'2021-11-12 21:15:00'),
('EQUIPOPRUEBAA3',3,1636751700000,'2021-11-12 21:15:00'),
('EQUIPOPRUEBAA3',6,1636756200000,'2021-11-12 22:30:00'),
('EQUIPOPRUEBAA4',4,1636757100000,'2021-11-12 22:45:00'),
('EQUIPOPRUEBAA4',5,1636757100000,'2021-11-12 22:45:00'),
('EQUIPOPRUEBAA5',1,1636756200000,'2021-11-12 22:30:00'),
('EQUIPOPRUEBAA5',3,1636760700000,'2021-11-12 23:45:00'),
('EQUIPOPRUEBAA5',4,1636760700000,'2021-11-12 23:45:00'),
('EQUIPOPRUEBAA5',5,1636760700000,'2021-11-12 23:45:00'),
('EQUIPOPRUEBAB1',7,1636766100000,'2021-11-13 01:15:00'),
('EQUIPOPRUEBAB1',8,1636761600000,'2021-11-13 00:00:00'),
('EQUIPOPRUEBAB1',9,1636761600000,'2021-11-13 00:00:00'),
('EQUIPOPRUEBAB1',10,1636760700000,'2021-11-12 23:45:00'),
('EQUIPOPRUEBAB1',11,1636760700000,'2021-11-12 23:45:00'),
('EQUIPOPRUEBAB1',12,1636760700000,'2021-11-12 23:45:00'),
('EQUIPOPRUEBAB2',7,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAB2',8,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAB2',9,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAB2',10,1636768800000,'2021-11-13 02:00:00'),
('EQUIPOPRUEBAB2',11,1636768800000,'2021-11-13 02:00:00'),
('EQUIPOPRUEBAB2',12,1636765200000,'2021-11-13 01:00:00'),
('EQUIPOPRUEBAC1',13,1636766100000,'2021-11-13 01:15:00'),
('EQUIPOPRUEBAC1',14,1636767000000,'2021-11-13 01:30:00'),
('EQUIPOPRUEBAC1',15,1636767000000,'2021-11-13 01:30:00'),
('EQUIPOPRUEBAC1',16,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAC1',17,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAC1',18,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAD1',19,1636765200000,'2021-11-13 01:00:00'),
('EQUIPOPRUEBAD1',20,1636765200000,'2021-11-13 01:00:00'),
('EQUIPOPRUEBAD1',21,1636758000000,'2021-11-12 23:00:00'),
('EQUIPOPRUEBAD1',22,1636758000000,'2021-11-12 23:00:00'),
('EQUIPOPRUEBAD1',23,1636758000000,'2021-11-12 23:00:00'),
('EQUIPOPRUEBAD1',24,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAE1',25,1636752600000,'2021-11-12 21:30:00'),
('EQUIPOPRUEBAE1',26,1636752600000,'2021-11-12 21:30:00'),
('EQUIPOPRUEBAE1',27,1636770600000,'2021-11-13 02:30:00'),
('EQUIPOPRUEBAE1',28,1636770600000,'2021-11-13 02:30:00'),
('EQUIPOPRUEBAE1',29,1636759800000,'2021-11-12 23:30:00'),
('EQUIPOPRUEBAE1',30,1636759800000,'2021-11-12 23:30:00'),
('EQUIPOPRUEBAF1',31,1636749900000,'2021-11-12 20:45:00'),
('EQUIPOPRUEBAF1',31,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAF1',32,1636749900000,'2021-11-12 20:45:00'),
('EQUIPOPRUEBAF1',32,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAF1',33,1636763400000,'2021-11-13 00:30:00'),
('EQUIPOPRUEBAF1',34,1636749900000,'2021-11-12 20:45:00'),
('EQUIPOPRUEBAF1',34,1636767000000,'2021-11-13 01:30:00');
/*!40000 ALTER TABLE `AsignacionEstudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ConfiguracionRIS`
--

DROP TABLE IF EXISTS `ConfiguracionRIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ConfiguracionRIS` (
  `Equipo_NSerie` varchar(50) NOT NULL,
  `TipoConfiguracion` varchar(45) NOT NULL,
  `IPAddress` varchar(15) DEFAULT NULL,
  `Puerto` int(11) DEFAULT NULL,
  `NombreEntidad` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Equipo_NSerie`),
  CONSTRAINT `fk_ConfiguracionRIS_Equipo1` FOREIGN KEY (`Equipo_NSerie`) REFERENCES `Equipo` (`NSerie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ConfiguracionRIS`
--

LOCK TABLES `ConfiguracionRIS` WRITE;
/*!40000 ALTER TABLE `ConfiguracionRIS` DISABLE KEYS */;
/*!40000 ALTER TABLE `ConfiguracionRIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ControlEstudios`
--

DROP TABLE IF EXISTS `ControlEstudios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ControlEstudios` (
  `Usuario_NumEmpleado` int(11) NOT NULL,
  `Usuario_CURP` varchar(45) NOT NULL,
  `Paciente_IDPaciente` varchar(20) NOT NULL,
  `Estudio_idEstudio` int(11) NOT NULL,
  `FechaControlPk` bigint(20) NOT NULL,
  `FechaControl` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estado` varchar(45) NOT NULL,
  `Cerrado` tinyint(1) NOT NULL,
  `Observaciones` varchar(250) NOT NULL,
  PRIMARY KEY (`Usuario_NumEmpleado`,`Usuario_CURP`,`Paciente_IDPaciente`,`Estudio_idEstudio`,`FechaControlPk`),
  KEY `fk_Usuario_has_Paciente_Paciente1_idx` (`Paciente_IDPaciente`),
  KEY `fk_Usuario_has_Paciente_Usuario1_idx` (`Usuario_NumEmpleado`,`Usuario_CURP`),
  KEY `fk_ControlEstudios_Estudio1_idx` (`Estudio_idEstudio`),
  CONSTRAINT `fk_ControlEstudios_Estudio1` FOREIGN KEY (`Estudio_idEstudio`) REFERENCES `Estudio` (`idEstudio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_has_Paciente_Paciente1` FOREIGN KEY (`Paciente_IDPaciente`) REFERENCES `Paciente` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_has_Paciente_Usuario1` FOREIGN KEY (`Usuario_NumEmpleado`, `Usuario_CURP`) REFERENCES `Usuario` (`NumEmpleado`, `CURP`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ControlEstudios`
--

LOCK TABLES `ControlEstudios` WRITE;
/*!40000 ALTER TABLE `ControlEstudios` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlEstudios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DatosAcceso`
--

DROP TABLE IF EXISTS `DatosAcceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DatosAcceso` (
  `Contraseña` varchar(20) NOT NULL,
  `UsuarioID` varchar(45) NOT NULL,
  `Usuario_NumEmpleado` int(11) NOT NULL,
  `Usuario_CURP` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`UsuarioID`,`Usuario_NumEmpleado`,`Usuario_CURP`),
  KEY `fk_DatosAcceso_Usuario1_idx` (`Usuario_NumEmpleado`,`Usuario_CURP`),
  CONSTRAINT `fk_DatosAcceso_Usuario1` FOREIGN KEY (`Usuario_NumEmpleado`, `Usuario_CURP`) REFERENCES `Usuario` (`NumEmpleado`, `CURP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DatosAcceso`
--

LOCK TABLES `DatosAcceso` WRITE;
/*!40000 ALTER TABLE `DatosAcceso` DISABLE KEYS */;
INSERT INTO `DatosAcceso` VALUES
('abc123','carlos',0,'PEPC000000','Inicial'),
('holaMundo','LIIM',1,'LIIM0000','Activo'),
('REBM111111','MaddieRB',100,'REBM111111','Activo'),
('ROJP000000','MisaRJ',10,'ROJP000000','Activo'),
('PRUEBA0000','PruebaID',5,'PRUEBA0000','Activo'),
('ELCP0000','SoyPacoElChato',22,'ELCP0000','Activo');
/*!40000 ALTER TABLE `DatosAcceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Domicilio`
--

DROP TABLE IF EXISTS `Domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Domicilio` (
  `Paciente_IDPaciente` varchar(20) NOT NULL,
  `Calle` varchar(45) NOT NULL,
  `Numero` varchar(20) NOT NULL,
  `Colonia` varchar(45) NOT NULL,
  `AlcaldiaMunicipio` varchar(45) NOT NULL,
  `Estado` varchar(30) NOT NULL,
  `CP` varchar(10) NOT NULL,
  `TiempoDeTraslado` int(11) DEFAULT NULL,
  `Telefono` varchar(20) NOT NULL,
  PRIMARY KEY (`Paciente_IDPaciente`),
  CONSTRAINT `fk_Domicilio_Paciente1` FOREIGN KEY (`Paciente_IDPaciente`) REFERENCES `Paciente` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Domicilio`
--

LOCK TABLES `Domicilio` WRITE;
/*!40000 ALTER TABLE `Domicilio` DISABLE KEYS */;
/*!40000 ALTER TABLE `Domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Equipo`
--

DROP TABLE IF EXISTS `Equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Equipo` (
  `NSerie` varchar(50) NOT NULL,
  `AreaDeServicio_idArea` int(11) NOT NULL,
  `Ubicacion` varchar(60) NOT NULL,
  PRIMARY KEY (`NSerie`),
  KEY `fk_Equipo_AreaDeServicio1_idx` (`AreaDeServicio_idArea`),
  CONSTRAINT `fk_Equipo_AreaDeServicio1` FOREIGN KEY (`AreaDeServicio_idArea`) REFERENCES `AreaDeServicio` (`idArea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Equipo`
--

LOCK TABLES `Equipo` WRITE;
/*!40000 ALTER TABLE `Equipo` DISABLE KEYS */;
INSERT INTO `Equipo` VALUES
('EQUIPOPRUEBAA1',1,'SALA 1'),
('EQUIPOPRUEBAA2',1,'SALA 2'),
('EQUIPOPRUEBAA3',1,'SALA 3'),
('EQUIPOPRUEBAA4',1,'SALA 4'),
('EQUIPOPRUEBAA5',1,'SALA 5'),
('EQUIPOPRUEBAB1',2,'SALA 1'),
('EQUIPOPRUEBAB2',2,'SALA 2'),
('EQUIPOPRUEBAC1',3,'SALA 1'),
('EQUIPOPRUEBAD1',4,'SALA 1'),
('EQUIPOPRUEBAE1',6,'SALA 1'),
('EQUIPOPRUEBAF1',7,'SALA 1');
/*!40000 ALTER TABLE `Equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EquipoImagenologia`
--

DROP TABLE IF EXISTS `EquipoImagenologia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `EquipoImagenologia` (
  `NSerie` varchar(50) NOT NULL,
  `AreaDeServicio_idArea` int(11) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Marca` varchar(60) NOT NULL,
  `Modelo` varchar(40) NOT NULL,
  `Modalidad` varchar(30) NOT NULL,
  `FechaInstalacion` date DEFAULT NULL,
  `Estado` varchar(25) NOT NULL,
  PRIMARY KEY (`NSerie`),
  KEY `fk_EquipoImagenologia_AreaDeServicio1_idx` (`AreaDeServicio_idArea`),
  CONSTRAINT `fk_EquipoImagenologia_AreaDeServicio1` FOREIGN KEY (`AreaDeServicio_idArea`) REFERENCES `AreaDeServicio` (`idArea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EquipoImagenologia`
--

LOCK TABLES `EquipoImagenologia` WRITE;
/*!40000 ALTER TABLE `EquipoImagenologia` DISABLE KEYS */;
INSERT INTO `EquipoImagenologia` VALUES
('\"pruebaPOSTMAN\"',3,'\"PRUEBApostman\"','\"generico01092025\"','editPostman','\"US\"',NULL,'\"Disponible\"'),
('12345',3,'Tomógrafo','pruebaEdicion','MODELO0','TC',NULL,'Disponible'),
('2',3,'Ultrasonido','Aloca','Alok23','US',NULL,'Bloqueado'),
('Bc221170',5,'Ultrasonido','DVG','dvg','US','2023-01-30','Disponible'),
('EQUIPOPRUEBAA1',3,'Densitómetro','Philips','dvg','US',NULL,'Disponible'),
('EQUIPOPRUEBAA2',1,'Ultrasonido 4K','Phillips','US221170','OT',NULL,'Mantenimiento Correctivo'),
('EQUIPOPRUEBAA3',7,'NOMBRE 3','MARCA 1','MODELO 1','OT',NULL,'Fuera de servicio'),
('EQUIPOPRUEBAA4',5,'NOMBRE 4','MARCA 1','MODELO 1','OT',NULL,'Fuera de servicio'),
('EQUIPOPRUEBAA5',5,'NOMBRE 5','MARCA 1','MODELO 1','OT',NULL,'Fuera de servicio'),
('EQUIPOPRUEBAB1',5,'NOMBRE 6','MARCA 2','MODELO 2','OT',NULL,'Mantenimiento preventivo'),
('EQUIPOPRUEBAB2',5,'NOMBRE 7','MARCA 2','MODELO 2','OT',NULL,'Mantenimiento preventivo'),
('EQUIPOPRUEBAC1',5,'NOMBRE 8','MARCA 3','MODELO 3','OT',NULL,'Mantenimiento preventivo'),
('EQUIPOPRUEBAD1',5,'NOMBRE 9','MARCA 4','MODELO 4','OT',NULL,'Fuera de servicio'),
('EQUIPOPRUEBAE1',5,'NOMBRE 10','MARCA 5','MODELO 5','OT',NULL,'Mantenimiento preventivo'),
('EQUIPOPRUEBAF1',5,'NOMBRE 11','MARCA 6','MODELO 6','OT',NULL,'Fuera de servicio');
/*!40000 ALTER TABLE `EquipoImagenologia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Especialidad`
--

DROP TABLE IF EXISTS `Especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Especialidad` (
  `idEspecialidad` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idEspecialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Especialidad`
--

LOCK TABLES `Especialidad` WRITE;
/*!40000 ALTER TABLE `Especialidad` DISABLE KEYS */;
INSERT INTO `Especialidad` VALUES
(1,'Audiología','Audiología'),
(2,'Ortopedia','Ortopedia'),
(3,'Medicina de Rehabilitación','Medicina de Rehabilitación');
/*!40000 ALTER TABLE `Especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Especialidad_Medica`
--

DROP TABLE IF EXISTS `Especialidad_Medica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Especialidad_Medica` (
  `Especialidad_idEspecialidad` int(11) NOT NULL,
  `Medico_NumEmpleado` int(11) NOT NULL,
  `Medico_CURP` varchar(45) NOT NULL,
  `CedulaProfesional` varchar(45) NOT NULL,
  PRIMARY KEY (`Especialidad_idEspecialidad`,`Medico_NumEmpleado`,`Medico_CURP`),
  KEY `fk_Especialidad_has_Medico_Medico1_idx` (`Medico_NumEmpleado`,`Medico_CURP`),
  KEY `fk_Especialidad_has_Medico_Especialidad1_idx` (`Especialidad_idEspecialidad`),
  CONSTRAINT `fk_Especialidad_has_Medico_Especialidad1` FOREIGN KEY (`Especialidad_idEspecialidad`) REFERENCES `Especialidad` (`idEspecialidad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Especialidad_has_Medico_Medico1` FOREIGN KEY (`Medico_NumEmpleado`, `Medico_CURP`) REFERENCES `Medico` (`NumEmpleado`, `CURP`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Especialidad_Medica`
--

LOCK TABLES `Especialidad_Medica` WRITE;
/*!40000 ALTER TABLE `Especialidad_Medica` DISABLE KEYS */;
/*!40000 ALTER TABLE `Especialidad_Medica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Estudio`
--

DROP TABLE IF EXISTS `Estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Estudio` (
  `idEstudio` int(11) NOT NULL,
  `AreaDeServicio_idArea` int(11) NOT NULL,
  `Nombre` varchar(64) NOT NULL,
  `Descripcion` varchar(65) NOT NULL,
  PRIMARY KEY (`idEstudio`),
  KEY `fk_Estudio_AreaDeServicio1_idx` (`AreaDeServicio_idArea`),
  CONSTRAINT `fk_Estudio_AreaDeServicio1` FOREIGN KEY (`AreaDeServicio_idArea`) REFERENCES `AreaDeServicio` (`idArea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Estudio`
--

LOCK TABLES `Estudio` WRITE;
/*!40000 ALTER TABLE `Estudio` DISABLE KEYS */;
INSERT INTO `Estudio` VALUES
(1,1,'prueba','prueba'),
(2,1,'ABDOMEN','AP EN DECUBITo'),
(3,1,'ABDOMEN','AP Y LATERAL'),
(4,1,'ANTEBRAZO','AP COMPARATIVO'),
(5,1,'ANTEBRAZO','AP LATERAL Y OBLICUA'),
(6,1,'BRAZO','LATERAL'),
(7,2,'ABDOMEN','CONTRASTADA'),
(8,2,'ABDOMEN','SIMPLE'),
(9,2,'ANGIOGRAFIA','CAROTIDEA CONTRASTADA'),
(10,2,'ANGIOGRAFIA','DE MANO CONTRASTADA'),
(11,2,'ANGIOGRAFIA','DE PIE CONTRASTADA'),
(12,2,'ANGIOGRAFIA','PERIFERICA CONTRASTADA'),
(13,3,'ABDOMINOPELVICO','CONTRASTADA ORAL'),
(14,3,'ABDOMINOPELVICO','SIMPLE'),
(15,3,'ABDOMINOPELVICO','CONTRASTADA ENDOVENOSO'),
(16,3,'DE BRAZO','NA'),
(17,3,'DE BRAZO','SIMPLE'),
(18,3,'DE BRAZO','CONTRASTADA'),
(19,4,'GAMAGRAMA','CEREBRAL ESTATICO Y DINAMICO'),
(20,4,'GAMAGRAMA','GLANDULAS SALIVALES'),
(21,4,'GAMAGRAMA','OSEO'),
(22,4,'GAMAGRAMA','RENAL ESTATICO Y DINAMICO'),
(23,4,'GAMAGRAMA','TIROIDEO'),
(24,4,'GAMAGRAMA','TIROIDEO CON YODO 131'),
(25,6,'DOPPLER','CAROTIDEO'),
(26,6,'DOPPLER','CAROTIDEO'),
(27,6,'ABDOMINAL','GENERAL HOMBRE'),
(28,6,'ABDOMINAL','GENERAL MUJER'),
(29,6,'ABDOMINAL','INFERIOR MUJER'),
(30,6,'ABDOMINAL','SUPERIOR'),
(31,7,'DENSITOMETRIA','PEDIATRICA'),
(32,7,'DENSITOMETRIA','DE CUERPO ENTERO'),
(33,7,'DENSITOMETRIA','COLUMNA Y CADERA'),
(34,7,'DENSITOMETRIA','DE CUBITO Y RADIO'),
(35,1,'COLON POR ENEMA','ADULTOS MENORES DE 65 AÑOS'),
(36,1,'COLOR POR ENEMA','NIÑOS MENORES DE 10 AÑOS'),
(37,1,'CISTOGRAFIA MICCIONAL','NA'),
(38,1,'COLANGIOGRAFIA ','POR TUBO EN T'),
(39,1,'ESOFAGOGRAMA','NA'),
(40,1,'FISTULOGRAFIA','NA'),
(41,1,'PIE','NA'),
(42,2,'ABDOMEN','PRUEBA'),
(43,1,'pie','prueba'),
(44,1,'pie','prueba'),
(45,2,'PIE','PRUEBA'),
(47,4,'COLANGIOGRAFIA','---'),
(48,3,'pruebA','PRUEBA'),
(49,1,'pie','e'),
(50,6,'gg','prueba'),
(51,4,'ESOFAGOGRAMA','PRUEBA'),
(52,4,'PRUEBA','PRUEBA'),
(53,8,'prueba','kkk'),
(54,8,'hhd','jdh'),
(55,6,'h','d'),
(56,4,'Pie','prueba'),
(57,7,'prueba','prueba'),
(58,1,'prueba','prueba');
/*!40000 ALTER TABLE `Estudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Evento`
--

DROP TABLE IF EXISTS `Evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Evento` (
  `idEvento` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Evento`
--

LOCK TABLES `Evento` WRITE;
/*!40000 ALTER TABLE `Evento` DISABLE KEYS */;
INSERT INTO `Evento` VALUES
(1,'Login Exitoso'),
(2,'Bloqueo automatico de usuario'),
(3,'Nuevo equipo agregado exitosamente '),
(4,'Equipo editado exitosamente'),
(5,'Consulta de equipos exitosa'),
(6,'Usuario dado de alta'),
(7,'Usuario actualizado'),
(8,'Usuario dado de baja'),
(9,'Usuario desbloqueado'),
(10,'Usuario bloqueado manualmente'),
(11,'Cambio del estado del equipo'),
(1001,'Login fallido por Contraseña incorrecta'),
(1002,'Login fallido por Usuario no existente'),
(1003,'Login fallido por Estado != Activo o Inicial'),
(1004,'Intento de registrar un nuevo equipo con numero de serie existente '),
(1005,'Edicion de equipo fallida porque el número de serie no existe'),
(1006,'Alta de Usuario fallida, llaves primarias dado de alta previamente'),
(1007,'Alta de Usuario fallida, UsuarioID vinculado a otro Usuario'),
(1008,'Alta o Actualizacion de Usuario fallida, CorreoElectronico vinculado a otro Usuario'),
(1009,'Alta o Actualizacion de Usuario fallida, Asignacion de Roles inexistentes'),
(1010,'Alta o Actualizacion de Usuario fallida, Asignacion de AreaDeServicio inexistente'),
(1011,'Actualizacion de Usuario fallida, UsuarioPK inexistente'),
(1012,'No se puede agregar el equipo porque la información está incompleta'),
(1013,'No se puede actualizar el equipo porque la información está incompleta');
/*!40000 ALTER TABLE `Evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medico`
--

DROP TABLE IF EXISTS `Medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Medico` (
  `NumEmpleado` int(11) NOT NULL,
  `CURP` varchar(45) NOT NULL,
  PRIMARY KEY (`NumEmpleado`,`CURP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medico`
--

LOCK TABLES `Medico` WRITE;
/*!40000 ALTER TABLE `Medico` DISABLE KEYS */;
INSERT INTO `Medico` VALUES
(3,'LMJ12'),
(4,'LML34'),
(5,'MMA56'),
(6,'MMS78'),
(7,'MMJ90'),
(8,'MNM11');
/*!40000 ALTER TABLE `Medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Paciente`
--

DROP TABLE IF EXISTS `Paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Paciente` (
  `idPaciente` varchar(20) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `ApellidoPaterno` varchar(45) NOT NULL,
  `ApellidoMaterno` varchar(45) NOT NULL,
  `Sexo` varchar(40) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Paciente`
--

LOCK TABLES `Paciente` WRITE;
/*!40000 ALTER TABLE `Paciente` DISABLE KEYS */;
INSERT INTO `Paciente` VALUES
('1','THERESA','ACOSTA','DUEÑAS','FEMENINO','1960-01-01'),
('10','GIDEON','ARMENDARIZ','FRANCO','MASCULINO','1969-10-10'),
('11','CHARLOTTE','ARRIAGA','GALINDO','FEMENINO','1970-11-11'),
('12','MAGNUS','BAEZA','GAMBA','MASCULINO','1971-12-12'),
('13','AXEL','BARRAGAN','GARCIA','MASCULINO','1972-01-13'),
('14','CAMILE','BARRERA','GARZA','FEMENINO','1973-02-14'),
('15','NATHANIEL','BARRIENTOS','GOMEZ','MASCULINO','1974-03-15'),
('16','TATIANA','BLANCO','GONZALEZ','FEMENINO','1975-04-16'),
('17','ISABEL','BOBADILLA','GUEVARA','FEMENINO','1976-05-17'),
('18','JONATHAN','BRACHO','HALABE','MASCULINO','1977-06-18'),
('19','DAVID','CABRAL','HAMUI','MASCULINO','1978-07-19'),
('2','WILLIAM','AGUILAR','DURAN','MASCULINO','1961-02-02'),
('20','SIMON','CALDERON','HEINZE','MASCULINO','1979-08-20'),
('21','CLARISA','CALVA','HERNANDEZ','FEMENINO','1980-09-21'),
('22','SEBASTIAN','CAMACHO','HINOJOSA','MASCULINO','1981-10-22'),
('23','JORDAN','CAMPOS','HONG','MASCULINO','1982-11-23'),
('24','RAFAEL','CANTO','IBARRA','MASCULINO','1983-12-24'),
('25','JOCELYN','CASTAÑO','IGLESIAS','FEMENINO','1984-01-25'),
('26','VALENTINE','CASTILLO','INFANTE','MASCULINO','1985-02-26'),
('27','MAIA','CHAN','JAKEZ','FEMENINO','1986-03-27'),
('28','LIDIA','CHAVEZ','JIMENEZ','FEMENINO','1987-04-28'),
('29','ROBERT','CORONA','JUNG','MASCULINO','1988-05-29'),
('3','JAMES','AGUIRRE','ESCALANTE','MASCULINO','1962-03-03'),
('30','EMMA','CRUZ','KATZ','FEMENINO','1989-06-30'),
('31','JULIAN','DE LA FUENTE','KIMURA','MASCULINO','1990-07-01'),
('32','CRISTINA','DE LA GARZA','KURI','FEMENINO','1991-08-02'),
('33','JAIME','DE LA PEÑA','LARA','MASCULINO','1992-09-03'),
('34','DIEGO','DIAZ','LEMUS','MASCULINO','1993-10-04'),
('35','MARK','DOMINGUEZ','LEON','MASCULINO','1994-11-05'),
('4','SOPHIE','ALCANTAR','ESCOBAR','FEMENINO','1963-04-04'),
('5','ALEXANDER','ALCARAZ','ESCOBEDO','MASCULINO','1964-05-05'),
('6','GABRIEL','ALCOCER','ESTRADA','MASCULINO','1965-06-06'),
('7','CECILY','ALMEDA','FAJARDO','FEMENINO','1966-07-07'),
('8','HENRY','ALONSO','FERIA','MASCULINO','1967-08-08'),
('9','JESSAMINE','ALVAREZ','FERNANDEZ','FEMENINO','1968-09-09');
/*!40000 ALTER TABLE `Paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Perfil`
--

DROP TABLE IF EXISTS `Perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Perfil` (
  `Usuario_NumEmpleado` int(11) NOT NULL,
  `Usuario_CURP` varchar(45) NOT NULL,
  `Rol_idRol` int(11) NOT NULL,
  `Estado` int(11) NOT NULL,
  PRIMARY KEY (`Usuario_NumEmpleado`,`Usuario_CURP`,`Rol_idRol`),
  KEY `fk_Usuario_has_Rol_Rol1_idx` (`Rol_idRol`),
  KEY `fk_Usuario_has_Rol_Usuario1_idx` (`Usuario_NumEmpleado`,`Usuario_CURP`),
  CONSTRAINT `fk_Usuario_has_Rol_Rol1` FOREIGN KEY (`Rol_idRol`) REFERENCES `Rol` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_has_Rol_Usuario1` FOREIGN KEY (`Usuario_NumEmpleado`, `Usuario_CURP`) REFERENCES `Usuario` (`NumEmpleado`, `CURP`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Perfil`
--

LOCK TABLES `Perfil` WRITE;
/*!40000 ALTER TABLE `Perfil` DISABLE KEYS */;
INSERT INTO `Perfil` VALUES
(0,'PEPC000000',1,0),
(0,'PEPC000000',2,0),
(0,'PEPC000000',3,0),
(0,'PEPC000000',4,0),
(0,'PEPC000000',5,0),
(0,'PEPC000000',6,0),
(1,'LIIM0000',1,0),
(1,'LIIM0000',2,0),
(1,'LIIM0000',3,0),
(1,'LIIM0000',4,0),
(1,'LIIM0000',5,0),
(5,'PRUEBA0000',2,0),
(10,'ROJP000000',1,0),
(22,'ELCP0000',1,0),
(22,'ELCP0000',2,0),
(22,'ELCP0000',3,0),
(100,'REBM111111',1,0);
/*!40000 ALTER TABLE `Perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProtocoloEstudio`
--

DROP TABLE IF EXISTS `ProtocoloEstudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProtocoloEstudio` (
  `idProtocolo` int(11) NOT NULL AUTO_INCREMENT,
  `Estudio_idEstudio` int(11) NOT NULL,
  `Nombre` varchar(65) NOT NULL,
  `Descripcion` varchar(65) NOT NULL,
  PRIMARY KEY (`idProtocolo`),
  KEY `fk_ProtocoloEstudio_Estudio1` (`Estudio_idEstudio`),
  CONSTRAINT `fk_ProtocoloEstudio_Estudio1` FOREIGN KEY (`Estudio_idEstudio`) REFERENCES `Estudio` (`idEstudio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProtocoloEstudio`
--

LOCK TABLES `ProtocoloEstudio` WRITE;
/*!40000 ALTER TABLE `ProtocoloEstudio` DISABLE KEYS */;
/*!40000 ALTER TABLE `ProtocoloEstudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RegistroEvento`
--

DROP TABLE IF EXISTS `RegistroEvento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `RegistroEvento` (
  `Evento_idEvento` int(11) NOT NULL,
  `Aplicacion_idAplicacion` int(11) NOT NULL,
  `horaEvento` bigint(20) NOT NULL,
  `Datos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`Datos`)),
  PRIMARY KEY (`Evento_idEvento`,`Aplicacion_idAplicacion`,`horaEvento`),
  KEY `fk_Usuario_has_Evento_Evento1_idx` (`Evento_idEvento`),
  KEY `fk_RegistroEvento_Aplicacion1_idx` (`Aplicacion_idAplicacion`),
  CONSTRAINT `fk_RegistroEvento_Aplicacion1` FOREIGN KEY (`Aplicacion_idAplicacion`) REFERENCES `Aplicacion` (`idAplicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Evento_Evento1` FOREIGN KEY (`Evento_idEvento`) REFERENCES `Evento` (`idEvento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RegistroEvento`
--

LOCK TABLES `RegistroEvento` WRITE;
/*!40000 ALTER TABLE `RegistroEvento` DISABLE KEYS */;
INSERT INTO `RegistroEvento` VALUES
(1,0,1757557469747,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1757557568659,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1757557865408,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1757558015278,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1757559643869,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1757619234411,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(2,0,1757556218008,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(2,0,1757556656818,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(3,0,1757556068972,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"jsoajsa\",\"ipAddress\":\"127.0.0.1\"}'),
(7,5,1757556252234,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Inicial\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757556218008,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757556683245,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Bloqueado\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757556656818,\"usuarioCURP\":\"ROJP000000\",\"usuarioNumEmpleado\":10,\"aplicacionID\":0}}'),
(7,5,1757557489660,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757557469747,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757557589058,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Bloqueado\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757557568659,\"usuarioCURP\":\"ROJP000000\",\"usuarioNumEmpleado\":10,\"aplicacionID\":0}}'),
(7,5,1757557883458,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757557865408,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757558032123,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Bloqueado\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757558015278,\"usuarioCURP\":\"ROJP000000\",\"usuarioNumEmpleado\":10,\"aplicacionID\":0}}'),
(7,5,1757559666823,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757559680421,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Inicial\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757559700757,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Bloqueado\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757559727190,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Dado de baja\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1757559770745,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(8,5,1757559727191,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Dado de baja\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(9,5,1757559666824,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(10,5,1757559700758,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Bloqueado\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(1001,0,1757555983427,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"jdlskañd\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757555989415,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"holaaaa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757555995022,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"mlkdsamda\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556002320,'{\"usuarioId\":\"MaddieRB\",\"contrasena\":\"holaa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556018242,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP21331\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556040498,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"sasa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556068971,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"jsoajsa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757558007955,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP00000\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757559633618,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1002,0,1757556060621,'{\"usuarioId\":\"MisaRJww\",\"contrasena\":\"dksld\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757556173525,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP00qqq\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757556182597,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757557421736,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP0000\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757557847173,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757559622332,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1008,5,1757559800250,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"prueba@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}');
/*!40000 ALTER TABLE `RegistroEvento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rol`
--

DROP TABLE IF EXISTS `Rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rol` (
  `idRol` int(11) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rol`
--

LOCK TABLES `Rol` WRITE;
/*!40000 ALTER TABLE `Rol` DISABLE KEYS */;
INSERT INTO `Rol` VALUES
(1,'Admin','Administrador RIS-INR'),
(2,'Recepcionista','Contol de citas'),
(3,'Radiólogo','Área de diagnóstico'),
(4,'JefedelServicio','Prueba'),
(5,'SubdirectordeServicios','Subdirector de Servicios Auxiliares'),
(6,'CoordinadordelServicio','Coordinador del Servicio');
/*!40000 ALTER TABLE `Rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RolAplicacion`
--

DROP TABLE IF EXISTS `RolAplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `RolAplicacion` (
  `Aplicacion_idAplicacion` int(11) NOT NULL,
  `Rol_idRol` int(11) NOT NULL,
  PRIMARY KEY (`Aplicacion_idAplicacion`,`Rol_idRol`),
  KEY `fk_RolAplicacion_Rol1_idx` (`Rol_idRol`),
  CONSTRAINT `fk_RolAplicacion_Aplicacion1` FOREIGN KEY (`Aplicacion_idAplicacion`) REFERENCES `Aplicacion` (`idAplicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RolAplicacion_Rol1` FOREIGN KEY (`Rol_idRol`) REFERENCES `Rol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RolAplicacion`
--

LOCK TABLES `RolAplicacion` WRITE;
/*!40000 ALTER TABLE `RolAplicacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `RolAplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sesion`
--

DROP TABLE IF EXISTS `Sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sesion` (
  `horaInicio` bigint(20) NOT NULL,
  `horaFin` bigint(20) DEFAULT NULL,
  `IPDispositivo` varchar(15) NOT NULL,
  `TipoCierre` varchar(25) DEFAULT NULL,
  `Usuario_NumEmpleado` int(11) NOT NULL,
  `Usuario_CURP` varchar(45) NOT NULL,
  `Aplicacion_idAplicacion` int(11) NOT NULL,
  `Rol_Nombre` varchar(45) DEFAULT NULL,
  `Usuario_ID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`horaInicio`,`Usuario_NumEmpleado`,`Usuario_CURP`,`Aplicacion_idAplicacion`),
  KEY `fk_Sesion_Usuario1_idx` (`Usuario_NumEmpleado`,`Usuario_CURP`),
  KEY `fk_Sesion_Aplicacion1_idx` (`Aplicacion_idAplicacion`),
  CONSTRAINT `fk_Sesion_Aplicacion1` FOREIGN KEY (`Aplicacion_idAplicacion`) REFERENCES `Aplicacion` (`idAplicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sesion_Usuario1` FOREIGN KEY (`Usuario_NumEmpleado`, `Usuario_CURP`) REFERENCES `Usuario` (`NumEmpleado`, `CURP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sesion`
--

LOCK TABLES `Sesion` WRITE;
/*!40000 ALTER TABLE `Sesion` DISABLE KEYS */;
INSERT INTO `Sesion` VALUES
(1757048667398,1757048681434,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1757048711385,1757048811284,'0:0:0:0:0:0:0:1','NormalPostman',0,'PEPC000000',0,'Admin','carlos'),
(1757049489936,1757049640480,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'Admin','LIIM'),
(1757049645564,1757049650728,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'Admin','LIIM'),
(1757050610693,1757050677409,'0:0:0:0:0:0:0:1','NaturalPostman',1,'LIIM0000',0,'Admin','LIIM'),
(1757051129662,1757051181049,'0:0:0:0:0:0:0:1','NaturalPostman',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757052638467,1757053098774,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'Admin','LIIM'),
(1757100152723,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757134520478,1757134562712,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757134571741,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757135670347,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757136062051,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757136287868,1757136617820,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757136638821,1757136727368,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757137089735,1757137153963,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757137229847,1757137361060,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1757137383068,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757138619945,1757138866990,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1757138901173,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757140157294,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757140368747,NULL,'0:0:0:0:0:0:0:1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1757360057529,1757369072689,'127.0.0.1','Inactividad',0,'PEPC000000',0,'Admin','carlos'),
(1757374545171,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757376267231,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757381236126,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757381411311,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757381750014,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757382705342,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757383804465,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757384106238,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757385273169,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757385478688,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757386989419,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757387343300,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757387701505,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757387971989,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757388116467,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757388256957,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757388307159,1757388386940,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757388619669,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757389045253,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757389271304,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757389414248,1757389471391,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757389561183,1757389714607,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757389755772,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757389917381,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757390111991,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757390231608,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757390356405,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757390697936,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757390785249,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757390886311,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757391198224,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757391280767,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757391392612,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757391645980,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757391723024,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757392844193,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757393028864,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757393341158,1757393468542,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757393491990,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757393657879,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757393747035,1757393829563,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1757445902670,1757446323774,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1757466492298,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757466685803,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757467790070,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757468527750,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757469551431,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1757472926918,1757474177674,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757474744363,1757475168459,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757475236732,1757475965017,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757476060232,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757476214293,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757476424590,1757476455552,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757476518560,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757476772629,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757476903323,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757477323545,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757477594426,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757477906317,1757478507024,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757478608946,1757478648542,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757478772959,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757478827471,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757478873725,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757479625171,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757479652657,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757479828429,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757479903542,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757480441080,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757480635525,1757480768902,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757480819674,1757480859193,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757481058296,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757481434935,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757481702902,1757482066059,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757482207589,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757482357327,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757482477477,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757531275853,1757532012005,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757532038968,1757532149042,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757545242480,1757545672086,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757545818833,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757546737228,1757546944620,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757546994501,1757547599016,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757547818564,1757548420013,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757548779737,1757549431008,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757549758617,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757549816630,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757550003580,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757550110997,1757550118694,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757550128426,1757550139833,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757550273378,1757550874098,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757556218008,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757556656818,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757557469747,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757557568659,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1757557865408,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1757558015278,1757558046473,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1757559643869,1757560400208,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1757619234411,1757619836010,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ');
/*!40000 ALTER TABLE `Sesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SolicitudDeEstudio`
--

DROP TABLE IF EXISTS `SolicitudDeEstudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SolicitudDeEstudio` (
  `Paciente_idPaciente` varchar(20) NOT NULL,
  `Medico_NumEmpleado` int(11) NOT NULL,
  `Medico_CURP` varchar(45) NOT NULL,
  `FechaSolicitudPk` bigint(20) NOT NULL,
  `FechaSolicitud` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `AreaProcedencia` varchar(45) DEFAULT NULL,
  `FechaProximaCita` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Diagnostico` varchar(250) NOT NULL,
  `Observaciones` varchar(250) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`Paciente_idPaciente`,`Medico_NumEmpleado`,`Medico_CURP`,`FechaSolicitudPk`),
  KEY `fk_SolicitudDeEstudio_Paciente1_idx` (`Paciente_idPaciente`),
  KEY `fk_SolicitudDeEstudio_Medico1_idx` (`Medico_NumEmpleado`,`Medico_CURP`),
  CONSTRAINT `fk_SolicitudDeEstudio_Medico1` FOREIGN KEY (`Medico_NumEmpleado`, `Medico_CURP`) REFERENCES `Medico` (`NumEmpleado`, `CURP`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_SolicitudDeEstudio_Paciente1` FOREIGN KEY (`Paciente_idPaciente`) REFERENCES `Paciente` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SolicitudDeEstudio`
--

LOCK TABLES `SolicitudDeEstudio` WRITE;
/*!40000 ALTER TABLE `SolicitudDeEstudio` DISABLE KEYS */;
INSERT INTO `SolicitudDeEstudio` VALUES
('1',3,'LMJ12',1636749000000,'2022-09-19 21:35:34','URGENCIAS','2022-09-29 14:00:00','RX','NA','Solicitado'),
('10',3,'LMJ12',1636754400000,'2021-11-10 22:40:29','URGENCIAS','2021-11-16 15:15:00','RX','NA','Programado'),
('10',3,'LMJ12',1659469543148,'2022-08-02 19:45:43','URGENCIAS','2021-11-16 15:15:00','RX','fin','Cancelado'),
('11',3,'LMJ12',1624048200000,'2021-11-12 22:45:00','URGENCIAS','2021-11-16 15:30:00','RX','Agregacion Manual','Programado'),
('11',3,'LMJ12',1636757100000,'2021-10-16 14:55:00','URGENCIAS','2021-11-16 15:30:00','RX','NA','Programado'),
('11',3,'LMJ12',1637067600000,'2021-11-16 13:00:00','URGENCIAS','2021-11-16 15:30:00','RX','Agregacion Manual','Reprogramado'),
('12',3,'LMJ12',1636758000000,'2021-10-16 15:00:00','URGENCIAS','2021-11-16 15:45:00','RX','NA','Programado'),
('12',3,'LMJ12',1663465291428,'2022-09-18 01:41:31','URGENCIAS','2021-11-16 15:45:00','RX','prueba x','Cancelado'),
('12',3,'LMJ12',1663465296882,'2022-09-18 01:41:36','URGENCIAS','2021-11-16 15:45:00','RX','prueba x','Cancelado'),
('12',3,'LMJ12',1663465301469,'2022-09-18 01:41:41','URGENCIAS','2021-11-16 15:45:00','RX','prueba x','Cancelado'),
('12',3,'LMJ12',1663465306179,'2022-09-18 01:41:46','URGENCIAS','2021-11-16 15:45:00','RX','prueba x','Cancelado'),
('13',3,'LMJ12',1636756200000,'2021-10-16 15:05:00','URGENCIAS','2021-11-16 16:00:00','RX','NA','Programado'),
('13',3,'LMJ12',1663625431888,'2022-09-19 22:10:31','URGENCIAS','2021-11-16 16:00:00','RX','prueba S1','Cancelado'),
('14',3,'LMJ12',1636760700000,'2021-10-16 15:10:00','URGENCIAS','2021-11-16 16:15:00','RX','NA','Programado'),
('15',3,'LMJ12',1636759800000,'2021-10-16 15:15:00','URGENCIAS','2021-11-16 16:30:00','RX','NA','Programado'),
('15',3,'LMJ12',1637071200000,'2021-11-16 14:00:00','URGENCIAS','2021-11-16 16:30:00','RX','NA','Reprogramado'),
('16',4,'LML34',1636766100000,'2021-11-10 23:09:09','URGENCIAS','2021-11-16 17:45:00','RM','NA','Programado'),
('17',4,'LML34',1636761600000,'2021-10-16 15:25:00','URGENCIAS','2021-11-16 15:00:00','RM','NA','Programado'),
('18',4,'LML34',1636760700000,'2021-10-16 15:30:00','URGENCIAS','2021-11-16 15:15:00','RM','NA','Programado'),
('19',4,'LML34',1636765200000,'2021-10-16 15:35:00','URGENCIAS','2021-11-16 15:30:00','RM','NA','Programado'),
('2',3,'LMJ12',1636747200000,'2021-11-10 22:40:29','URGENCIAS','2021-11-16 15:15:00','RX','NA','Programado'),
('20',4,'LML34',1636768800000,'2021-10-16 15:40:00','URGENCIAS','2021-11-16 15:45:00','RM','NA','Programado'),
('21',4,'LML34',1636763400000,'2021-10-16 15:45:00','URGENCIAS','2021-11-16 16:00:00','RM','NA','Programado'),
('22',5,'MMA56',1636766100000,'2021-10-16 15:50:00','URGENCIAS','2021-11-16 16:15:00','TC','NA','Programado'),
('23',5,'MMA56',1636767000000,'2021-10-16 15:55:00','URGENCIAS','2021-11-16 16:30:00','TC','NA','Programado'),
('24',5,'MMA56',1636763400000,'2021-10-16 16:00:00','URGENCIAS','2021-11-16 16:45:00','TC','NA','Programado'),
('25',6,'MMS78',1636765200000,'2021-10-16 16:05:00','URGENCIAS','2021-11-16 17:00:00','MN','NA','Programado'),
('26',6,'MMS78',1636758000000,'2021-10-16 16:10:00','URGENCIAS','2021-11-16 15:00:00','MN','NA','Programado'),
('27',6,'MMS78',1636763400000,'2021-10-16 16:15:00','URGENCIAS','2021-11-16 15:15:00','MN','NA','Programado'),
('28',7,'MMJ90',1636752600000,'2021-10-16 16:20:00','URGENCIAS','2021-11-16 15:30:00','UL','NA','Programado'),
('29',7,'MMJ90',1636770600000,'2021-10-16 16:25:00','URGENCIAS','2021-11-16 15:45:00','UL','NA','Programado'),
('3',3,'LMJ12',1636753500000,'2021-11-10 22:40:30','URGENCIAS','2021-11-16 15:30:00','RX','NA','Programado'),
('3',3,'LMJ12',1663190052506,'2022-09-14 21:14:12','URGENCIAS','2021-11-16 15:30:00','RX','a','Cancelado'),
('30',7,'MMJ90',1636759800000,'2021-10-16 16:30:00','URGENCIAS','2021-11-16 16:00:00','UL','NA','Programado'),
('31',8,'MNM11',1636763400000,'2021-10-16 16:35:00','URGENCIAS','2021-11-16 16:15:00','DE','NA','Programado'),
('32',8,'MNM11',1636767000000,'2021-10-16 16:40:00','URGENCIAS','2021-11-16 16:30:00','DE','NA','Programado'),
('33',8,'MNM11',1636749900000,'2021-10-16 16:45:00','URGENCIAS','2021-11-16 16:45:00','DE','NA','Programado'),
('34',3,'LMJ12',1636732800000,'2021-10-16 16:50:00','URGENCIAS','2021-11-16 17:00:00','RX','NA','Programado'),
('34',3,'LMJ12',1636768800000,'2021-11-12 06:00:00','URGENCIAS','2021-11-16 17:00:00','RX','Agregacion Manual','Programado'),
('4',3,'LMJ12',1636748100000,'2021-10-16 14:20:00','URGENCIAS','2021-11-16 15:45:00','RX','NA','Programado'),
('5',3,'LMJ12',1636750800000,'2021-10-16 14:25:00','URGENCIAS','2021-11-16 16:00:00','RX','NA','Programado'),
('6',3,'LMJ12',1636756200000,'2021-10-16 14:30:00','URGENCIAS','2021-11-16 16:15:00','RX','NA','Programado'),
('6',3,'LMJ12',1637070300000,'2021-11-16 13:45:00','URGENCIAS','2021-11-16 16:15:00','RX','NA','Reprogramado'),
('7',3,'LMJ12',1636751700000,'2021-10-16 14:35:00','URGENCIAS','2021-11-16 16:30:00','RX','NA','Programado'),
('7',3,'LMJ12',1663527007690,'2022-09-18 18:50:07','URGENCIAS','2021-11-16 16:30:00','RX',' N','Cancelado'),
('8',3,'LMJ12',1636769700000,'2021-11-10 22:40:30','URGENCIAS','2021-11-16 16:45:00','RX','NA','Programado'),
('8',3,'LMJ12',1659469447133,'2022-08-02 19:44:07','URGENCIAS','2021-11-16 16:45:00','RX','No se presentó el paciente','Cancelado'),
('9',3,'LMJ12',1636756200000,'2021-10-16 14:45:00','URGENCIAS','2021-11-16 15:00:00','RX','NA','Programado'),
('9',3,'LMJ12',1663186985762,'2022-09-14 20:23:05','URGENCIAS','2021-11-16 15:00:00','RX','No puede el paciente','Cancelado'),
('9',3,'LMJ12',1663186991510,'2022-09-14 20:23:11','URGENCIAS','2021-11-16 15:00:00','RX','No puede el paciente','Cancelado');
/*!40000 ALTER TABLE `SolicitudDeEstudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `NumEmpleado` int(11) NOT NULL,
  `CURP` varchar(45) NOT NULL,
  `Area_idArea` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `ApellidoPaterno` varchar(45) NOT NULL,
  `ApellidoMaterno` varchar(45) NOT NULL,
  `CorreoElectronico` varchar(150) NOT NULL,
  PRIMARY KEY (`NumEmpleado`,`CURP`),
  UNIQUE KEY `CorreoElectronico` (`CorreoElectronico`),
  KEY `fk_Usuario_Area1_idx` (`Area_idArea`),
  CONSTRAINT `fk_Usuario_Area1` FOREIGN KEY (`Area_idArea`) REFERENCES `AreaDeServicio` (`idArea`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES
(0,'PEPC000000',5,'Carlos Alberto','Pérez','Pérez','carlos@gmail.com'),
(1,'LIIM0000',5,'Laboratorio de Investigacion','Informatica','Medica','LIIM.UAMI@gmail.com'),
(5,'PRUEBA0000',4,'Prueba Edicion','pruebaaaaa','pruebaaaaa','prueba@gmail.com'),
(10,'ROJP000000',5,'Pedro Misael','Rodríguez','Jiménez','p.misaelrj@gmail.com'),
(22,'ELCP0000',4,'Paco','El','Chato','pacoelchato@gmail.com'),
(100,'REBM111111',5,'Maddie','Rebolledo','Bustillo','maddie.rb@gmail.com');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-11 14:11:25
