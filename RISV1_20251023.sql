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
('21Septiembre2025','21Septiembre2025',4,'21Septiembre2025','Activo'),
('21Septiembreq','21Septiembreq',2,'21Septiembreq','Activo'),
('24Septiembre','24Septiembre',12,'24Septiembre','Activo'),
('25Sept2025','25Sept2025',11,'25Sept2025','Activo'),
('25Septiembre','25Septiembre',9,'25Septiembre','Activo'),
('29Septiembre2025','29Septiembre',13,'29Septiembre2025','Activo'),
('6Octubre','6Octubre',1000,'6Octubre','Activo'),
('8Octubre','8Octubre',14,'8Octubre','Activo'),
('nueveOCT123','9OCTUBRE',15,'nueveOCT123','Activo'),
('asdasdasd','asd',8,'asdasdasd','Activo'),
('abc123','carlos',0,'PEPC000000','Inicial'),
('asdasdasd','dasdasdasd',122,'asdasdasd','Activo'),
('Prueba123','hola123',3,'Prueba123','Activo'),
('hola21Septiembre2025','hola21Septiembre2025',6,'hola21Septiembre2025','Activo'),
('holaMundo','LIIM',1,'LIIM0000','Activo'),
('REBM111111','MaddieRB',100,'REBM111111','Activo'),
('ROJP000000','MisaRJ',10,'ROJP000000','Activo'),
('qweqwe','poi',7,'qweqwe','Activo'),
('PRUEBA0000','PruebaID',5,'PRUEBA0000','Activo'),
('ds','qwew',321312,'ds','Activo'),
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
('30Septiembre',3,'30Septiembre','30Septiembre','30Septiembre','TC','2025-09-30','Disponible'),
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
(11,'Cambio de estado del Equipo'),
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
(1011,'Actualizacion de Usuario fallida, UsuarioPK inexistente');
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
(2,'21Septiembreq',1,0),
(2,'21Septiembreq',2,0),
(3,'Prueba123',1,0),
(3,'Prueba123',2,0),
(3,'Prueba123',3,0),
(3,'Prueba123',4,0),
(3,'Prueba123',5,0),
(3,'Prueba123',6,0),
(4,'21Septiembre2025',1,0),
(4,'21Septiembre2025',2,0),
(5,'PRUEBA0000',2,0),
(6,'hola21Septiembre2025',1,0),
(7,'qweqwe',2,0),
(7,'qweqwe',3,0),
(8,'asdasdasd',1,0),
(8,'asdasdasd',2,0),
(8,'asdasdasd',3,0),
(9,'25Septiembre',1,0),
(9,'25Septiembre',2,0),
(10,'ROJP000000',1,0),
(11,'25Sept2025',3,0),
(12,'24Septiembre',1,0),
(13,'29Septiembre2025',2,0),
(13,'29Septiembre2025',3,0),
(13,'29Septiembre2025',4,0),
(14,'8Octubre',2,0),
(14,'8Octubre',3,0),
(15,'nueveOCT123',4,0),
(15,'nueveOCT123',5,0),
(22,'ELCP0000',3,0),
(100,'REBM111111',1,0),
(122,'asdasdasd',1,0),
(122,'asdasdasd',2,0),
(1000,'6Octubre',1,0),
(1000,'6Octubre',2,0),
(1000,'6Octubre',3,0),
(1000,'6Octubre',4,0),
(1000,'6Octubre',5,0),
(1000,'6Octubre',6,0),
(321312,'ds',1,0),
(321312,'ds',2,0),
(321312,'ds',3,0),
(321312,'ds',4,0),
(321312,'ds',5,0),
(321312,'ds',6,0);
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
(1,0,1758083925716,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1758299596687,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758299950475,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758338005895,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758494546533,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758496345930,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758496967102,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758497557929,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758497599712,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758499556084,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758499758866,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758499845210,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758499865414,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758500019540,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758505526381,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758505792766,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758505904706,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758506263027,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758506777739,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758508816098,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758509550138,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758514595893,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758514715167,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758514783864,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758515050602,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758515969280,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758517355424,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758517488493,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758517501141,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758518465874,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758572210189,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758572387173,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758596744586,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758597198839,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758597398734,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758721878454,'{\"usuarioId\":\"misaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758722035832,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758722064092,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758722195381,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758722495341,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758722608655,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758723068003,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758723832521,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758723982883,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758724816849,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758724881761,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758724925404,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758724962634,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758725220255,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758726923745,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758742212669,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758742297763,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758742485891,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758742526030,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758777677463,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758777696862,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758809304318,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758809639131,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758809781991,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758809983405,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758810183425,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758810321628,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758810678202,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758811023895,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758811200835,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758811304832,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758811506455,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758811888890,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758811997888,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758812107273,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758812251645,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758812878763,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758813138100,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758813312014,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758813387808,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758813607349,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758813692620,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758826298659,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758826340447,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758826631086,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758826708640,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758826924895,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758827048737,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758827142313,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758830878626,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758831316457,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758852859071,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758853332254,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758853550735,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863212656,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863331245,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863410371,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863473803,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863539796,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863631923,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863756164,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758863864397,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758864047827,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758917384109,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758917894820,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1758918073531,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759027629977,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759027942803,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759027984306,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028052695,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028242472,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028438790,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028536739,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028583450,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028654767,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759028945066,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759119022744,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759119175125,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759119221965,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759119284809,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759121171170,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759121186362,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759121698357,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759121888185,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759122176403,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759122553818,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759122627313,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759128894776,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759128905103,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759129213896,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759129288855,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759129328495,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759129564386,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759133554210,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759133610951,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134055650,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134409441,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134473364,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134611868,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134659393,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134733756,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134790947,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759134866006,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759135262369,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759135286823,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759160901028,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759161774278,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759162013183,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759162059192,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759162382236,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759162606389,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759175055512,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759175211999,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759247638122,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1759247788852,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759247847038,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759247945077,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759248098495,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759248412794,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759248733987,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759248794927,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250341044,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250407032,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250444915,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250477315,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250504086,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250580295,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250650647,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759250697887,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759251328728,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759251364820,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759251405172,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255101210,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255132598,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255192383,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255239617,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255289416,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255307168,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255371316,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255510434,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255542690,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255553302,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255681675,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255719737,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255758889,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255836728,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255853946,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255900024,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255946532,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255970402,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759255998674,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256112460,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256141261,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256232904,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256266393,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256352545,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256421465,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256752815,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256821234,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759256911485,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257061618,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257069529,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257171240,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257479009,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257511651,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257548058,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257599379,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257660131,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257695107,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257739610,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257806776,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257846720,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759257932003,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759258008300,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759258047299,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759258116509,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759258258303,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759258292548,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759258443348,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759260492150,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759292921001,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759293025424,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759293312416,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759293348623,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759294188207,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759294215508,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759294280697,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759294304451,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759295688573,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759295882311,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759296002648,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759411839608,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759411868639,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759412299924,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759412419501,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439140039,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439233142,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439345985,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439555858,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439569794,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439588474,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439596804,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439609980,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439645441,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759439678763,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759452344038,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1759452416513,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1759452526664,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759452553135,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759452671038,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759680882792,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759680960132,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681060027,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681091267,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681121347,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681143153,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681167125,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681202127,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759681237058,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759683075210,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1759683197669,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1759684765708,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759684852316,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759684875955,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759685484676,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759685541564,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759686781862,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759686794115,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759686928572,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759686993886,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687096034,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687213595,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687255435,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687456424,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687523933,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687657933,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687689766,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687780591,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759687951147,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688268566,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688297980,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688412615,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688801573,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688825325,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688858584,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688909440,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759688994451,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1759689105066,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759689119131,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759689144188,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759689206919,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759689364272,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759689537794,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759689595037,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707347293,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707414280,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707488400,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707589472,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707779683,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707823570,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759707971711,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759709878767,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759711266082,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759711321423,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759711343548,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759711591309,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759721194613,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759721273410,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759721332633,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759721536547,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722157883,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722240468,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722267631,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722322702,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722419719,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722454534,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759722485702,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759723882952,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724178003,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724210564,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724247636,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724433413,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724481391,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724652090,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759724980846,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759725033113,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759725087390,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759725758782,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759728049550,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759728137119,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759728250400,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759728395602,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759728483266,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759728636015,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759729832662,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759729870336,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759729955053,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730054850,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730236203,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730363562,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730430340,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730554145,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730567973,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759730799560,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759731229671,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759731367170,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759731667410,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759731808879,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759731876659,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759732069697,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759732407555,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759732495435,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759756855588,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757364968,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757374496,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757384494,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757398609,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757410646,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757421352,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759757466457,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759761120786,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759761149217,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759761874041,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759762257420,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759799935051,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800018146,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800302467,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800456789,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800549673,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800594239,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800847273,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759800866667,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759801071958,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759801217266,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759801241236,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759801544568,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759801704524,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759802194478,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759802268923,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759802492891,'{\"usuarioId\":\"carlos\",\"contrasena\":\"abc123\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759802660258,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759804836177,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759804983472,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759805060258,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759805405029,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759805695266,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759805816168,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759805876628,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759806336585,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759806578967,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759806692941,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759806827546,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759807078381,'{\"usuarioId\":\"6Octubre\",\"contrasena\":\"6Octubre\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759807203442,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759807239265,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759807655729,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759807733226,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759807974047,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759808061137,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759808128667,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759808179261,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759808240014,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759808336262,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759813503899,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759813614901,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759813993039,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759814037969,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759814620920,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759814695404,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759814774354,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759814859516,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759814952505,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759815008380,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759815095840,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759815162259,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759815277838,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759815316875,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759815409751,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759847659495,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759847676607,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759847898275,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759893890667,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894047381,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894095073,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894138484,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894221002,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894297502,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894367916,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894483417,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894661332,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894802311,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759894901567,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759895454183,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759895746993,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759895862154,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759895996857,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759896210209,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759896311524,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759899909820,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759902691406,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759902860752,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759902873701,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759903000856,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759903129606,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759904565951,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759904654225,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759904799397,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759905166501,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759905304105,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759905384785,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759906260614,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759906535073,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759906637716,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759906720261,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759906815541,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759906932830,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759934224629,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759934814978,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759934823653,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759980064517,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759980129466,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759980676028,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759980778645,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759980795848,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759980949275,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759982322879,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759982390856,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759982481300,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759982688060,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759982951974,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759983007042,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759983123479,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759983412699,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759983475938,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759984227022,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759988168593,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759990378430,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759990501172,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759990541450,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759990632489,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759990859429,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759990922347,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759991251911,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759991320095,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759991432676,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759991602693,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759992099326,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759992629699,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759992915259,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759992992763,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759993175675,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759993221481,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759993282307,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1759993672060,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760021161006,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760021308001,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760021715435,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760021738408,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760021922871,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760069081311,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760069219797,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760069927219,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760070067180,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1760070074960,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(2,0,1757556218008,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(2,0,1757556656818,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(3,0,1757556068972,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"jsoajsa\",\"ipAddress\":\"127.0.0.1\"}'),
(3,3,1759248191343,'{\"nSerie\":\"30Septiembre\",\"nombreEquipo\":\"30Septiembre\",\"marca\":\"30Septiembre\",\"modelo\":\"30Septiembre\",\"modalidad\":\"TC\",\"idArea\":3,\"estado\":\"Disponible\"}'),
(4,2,1759984700798,'{\"nSerie\":\"Bc221170\",\"nombreEquipo\":\"Ultrasonido\",\"marca\":\"DVG\",\"modelo\":\"dvg\",\"modalidad\":\"US\",\"idArea\":5,\"estado\":\"Fuera de servicio\"}'),
(4,2,1760021218690,'{\"nSerie\":\"Bc221170\",\"nombreEquipo\":\"Ultrasonido\",\"marca\":\"DVG\",\"modelo\":\"dvg\",\"modalidad\":\"US\",\"idArea\":5,\"estado\":\"Disponible\"}'),
(5,1,1758083947960,'{}'),
(5,1,1758496351124,'{}'),
(5,1,1758496503988,'{}'),
(5,1,1758496721920,'{}'),
(5,1,1758497677959,'{}'),
(5,1,1758499763228,'{}'),
(5,1,1758499849042,'{}'),
(5,1,1758500034865,'{}'),
(5,1,1758572406178,'{}'),
(5,1,1758597238166,'{}'),
(5,1,1758722097743,'{}'),
(5,1,1758724892418,'{}'),
(5,1,1758724971562,'{}'),
(5,1,1758726938205,'{}'),
(5,1,1758813703029,'{}'),
(5,1,1758853640165,'{}'),
(5,1,1759133587212,'{}'),
(5,1,1759247851668,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759247980585,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759248109350,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759248142583,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759248143169,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759248196570,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759683133235,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759683208319,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759732075527,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759808346516,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759808529786,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759808552661,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759808553391,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759808566209,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759813509242,'{}'),
(5,1,1759813997888,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759814626705,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759814713580,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759814727806,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759814784941,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759814865290,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759814958399,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759815100953,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759815167381,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759815321366,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759815412412,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759847824468,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759847880835,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759893913252,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759895478112,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759895478654,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759895750485,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759895875203,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759896321189,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759899915999,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759904723678,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906265500,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906540060,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906679083,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906721518,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906731396,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906736415,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906817262,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906824305,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906825225,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906934487,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759906938494,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934248372,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934249508,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934249697,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934249856,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934250120,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934250346,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934250740,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934262656,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934266593,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934277598,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759934910132,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980066398,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980069955,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980070698,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980071350,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980131008,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980799711,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759980952263,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759982484606,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759982697845,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759982954402,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759983008650,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759983125664,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759983413913,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759983477373,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759983496405,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759984230610,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759984704501,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759988180149,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759990503316,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759990633769,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759990961390,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991271603,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991321819,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991434159,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991612530,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991613523,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991714015,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759991839267,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759992646109,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1759992654598,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021171366,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021220940,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021316419,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021384761,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021717106,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021740525,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(5,1,1760021924767,'{\"Area\":\"Desarrollo Tecnológico\",\"NumEmpleado\":1,\"CURP\":\"LIIM0000\"}'),
(6,6,1758299785452,'{\"Usuario\":{\"nombre\":\"Prueba19Septiembre\",\"apellidoPaterno\":\"Prueba19Septiembre\",\"apellidoMaterno\":\"Prueba19Septiembre\",\"curp\":\"Prueba19Septiembre000\",\"numEmpleado\":12,\"area\":2,\"roles\":[2,3],\"estado\":\"Inicial\",\"usuarioID\":\"19Septiembre\",\"correoElectronico\":\"pruea@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758299596687,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(6,6,1758299810824,'{\"Usuario\":{\"nombre\":\"Prueba19Septiembre\",\"apellidoPaterno\":\"Prueba19Septiembre\",\"apellidoMaterno\":\"Prueba19Septiembre\",\"curp\":\"Prueba19Septiembre000\",\"numEmpleado\":12,\"area\":1,\"roles\":[4,5],\"estado\":\"Inicial\",\"usuarioID\":\"19Septiembre\",\"correoElectronico\":\"pruea@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758299596687,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(6,6,1758338030059,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"asdasdasd\",\"numEmpleado\":122,\"area\":4,\"roles\":[1,2],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasdasd\",\"usuarioID\":\"dasdasdasd\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(6,6,1758338225189,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"ds\",\"numEmpleado\":321312,\"area\":4,\"roles\":[1,2,3,4,5,6],\"estado\":\"Inicial\",\"correoElectronico\":\"rew\",\"usuarioID\":\"qwew\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(6,6,1758505836016,'{\"Usuario\":{\"nombre\":\"asd\",\"apellidoPaterno\":\"asdas\",\"apellidoMaterno\":\"dasd\",\"curp\":\"asdasdasd\",\"numEmpleado\":8,\"area\":1,\"roles\":[1,2,3],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasd@gmail.com\",\"usuarioID\":\"asd\"},\"SesionActiva\":{\"horaInicio\":1758505792766,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758505933716,'{\"Usuario\":{\"nombre\":\"qwe\",\"apellidoPaterno\":\"qwe\",\"apellidoMaterno\":\"qwe\",\"curp\":\"qweqwe\",\"numEmpleado\":7,\"area\":2,\"roles\":[2,3],\"estado\":\"Inicial\",\"correoElectronico\":\"qweqwe\",\"usuarioID\":\"poi\"},\"SesionActiva\":{\"horaInicio\":1758505904706,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758506300498,'{\"Usuario\":{\"nombre\":\"dasdasd\",\"apellidoPaterno\":\"asddasd\",\"apellidoMaterno\":\"dasdsad\",\"curp\":\"dasdasdasdasdasdasdasdasd\",\"numEmpleado\":9,\"area\":1,\"roles\":[1,2],\"estado\":\"Inicial\",\"correoElectronico\":\"qweqweqweqwe\",\"usuarioID\":\"qweqweqweqwe\"},\"SesionActiva\":{\"horaInicio\":1758506263027,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758506335143,'{\"Usuario\":{\"nombre\":\"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\",\"apellidoPaterno\":\"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\",\"apellidoMaterno\":\"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\",\"curp\":\"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\",\"numEmpleado\":9,\"area\":1,\"roles\":[1,2,3],\"estado\":\"Inicial\",\"correoElectronico\":\"qweqweqweqwe\",\"usuarioID\":\"qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq\"},\"SesionActiva\":{\"horaInicio\":1758506263027,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758506380729,'{\"Usuario\":{\"nombre\":\"hola\",\"apellidoPaterno\":\"soy\",\"apellidoMaterno\":\"una\",\"curp\":\"Prueba123\",\"numEmpleado\":3,\"area\":2,\"roles\":[3,4],\"estado\":\"Inicial\",\"correoElectronico\":\"holapruebajeje@gmail.com\",\"usuarioID\":\"hola123\"},\"SesionActiva\":{\"horaInicio\":1758506263027,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758506810040,'{\"Usuario\":{\"nombre\":\"21Septiembre\",\"apellidoPaterno\":\"21Septiembreq\",\"apellidoMaterno\":\"21Septiembreq\",\"curp\":\"21Septiembreq\",\"numEmpleado\":2,\"area\":1,\"roles\":[1,2],\"estado\":\"Inicial\",\"correoElectronico\":\"21Septiembreq@gmail.com\",\"usuarioID\":\"21Septiembreq\"},\"SesionActiva\":{\"horaInicio\":1758506777739,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758508867720,'{\"Usuario\":{\"nombre\":\"21Septiembre2025\",\"apellidoPaterno\":\"21Septiembre2025\",\"apellidoMaterno\":\"21Septiembre2025\",\"curp\":\"21Septiembre2025\",\"numEmpleado\":4,\"area\":1,\"roles\":[1,2],\"estado\":\"Inicial\",\"correoElectronico\":\"21Septiembre2025@gmail.com\",\"usuarioID\":\"21Septiembre2025\"},\"SesionActiva\":{\"horaInicio\":1758508816098,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758509591289,'{\"Usuario\":{\"nombre\":\"hola21Septiembre2025\",\"apellidoPaterno\":\"hola21Septiembre2025\",\"apellidoMaterno\":\"hola21Septiembre2025\",\"curp\":\"hola21Septiembre2025\",\"numEmpleado\":6,\"area\":1,\"roles\":[1],\"estado\":\"Inicial\",\"correoElectronico\":\"hola21Septiembre2025\",\"usuarioID\":\"hola21Septiembre2025\"},\"SesionActiva\":{\"horaInicio\":1758509550138,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758812150941,'{\"Usuario\":{\"nombre\":\"25Septiembre\",\"apellidoPaterno\":\"25Septiembre\",\"apellidoMaterno\":\"25Septiembre\",\"curp\":\"25Septiembre\",\"numEmpleado\":9,\"area\":2,\"roles\":[1,2],\"estado\":\"Inicial\",\"correoElectronico\":\"25Septiembre@gmail.com\",\"usuarioID\":\"25Septiembre\"},\"SesionActiva\":{\"horaInicio\":1758812107273,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758812305319,'{\"Usuario\":{\"nombre\":\"25Septiembre25Septiembre\",\"apellidoPaterno\":\"25Septiembre25Septiembre\",\"apellidoMaterno\":\"25Septiembre25Septiembre\",\"curp\":\"25Septiembre25Septiembre\",\"numEmpleado\":12345,\"area\":2,\"roles\":[1,2],\"estado\":\"Inicial\",\"correoElectronico\":\"25Septiembre25Septiembre@gmail.com\",\"usuarioID\":\"25Septiembre25Septiembre\"},\"SesionActiva\":{\"horaInicio\":1758812251645,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758812921740,'{\"Usuario\":{\"nombre\":\"25Sept2025\",\"apellidoPaterno\":\"25Sept2025\",\"apellidoMaterno\":\"25Sept2025\",\"curp\":\"25Sept2025\",\"numEmpleado\":11,\"area\":2,\"roles\":[1,2,3],\"estado\":\"Inicial\",\"correoElectronico\":\"25Sept2025@gmail.com\",\"usuarioID\":\"25Sept2025\"},\"SesionActiva\":{\"horaInicio\":1758812878763,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1758813182550,'{\"Usuario\":{\"nombre\":\"24Septiembre\",\"apellidoPaterno\":\"24Septiembre\",\"apellidoMaterno\":\"24Septiembre\",\"curp\":\"24Septiembre\",\"numEmpleado\":12,\"area\":2,\"roles\":[1,2,3],\"estado\":\"Inicial\",\"correoElectronico\":\"24Septiembre@gmail.com\",\"usuarioID\":\"24Septiembre\"},\"SesionActiva\":{\"horaInicio\":1758813138100,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1759160950736,'{\"Usuario\":{\"nombre\":\"29Septiembre\",\"apellidoPaterno\":\"29Septiembre\",\"apellidoMaterno\":\"29Septiembre\",\"curp\":\"29Septiembre2025\",\"numEmpleado\":13,\"area\":4,\"roles\":[2,3,4],\"estado\":\"Inicial\",\"usuarioID\":\"29Septiembre\",\"correoElectronico\":\"29Septiembre@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1759160901028,\"usuarioCURP\":\"ROJP000000\",\"usuarioNumEmpleado\":10,\"aplicacionID\":0}}'),
(6,6,1759807029543,'{\"Usuario\":{\"nombre\":\"6Octubre\",\"apellidoPaterno\":\"6Octubre\",\"apellidoMaterno\":\"6Octubre\",\"curp\":\"6Octubre\",\"numEmpleado\":1000,\"area\":8,\"roles\":[1,2,3,4,5,6],\"estado\":\"Inicial\",\"usuarioID\":\"6Octubre\",\"correoElectronico\":\"6Octubre@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1759806827546,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1759993406393,'{\"Usuario\":{\"nombre\":\"8Octubre\",\"apellidoPaterno\":\"8Octubre\",\"apellidoMaterno\":\"8Octubre\",\"curp\":\"8Octubre\",\"numEmpleado\":14,\"area\":5,\"roles\":[2,3],\"estado\":\"Inicial\",\"usuarioID\":\"8Octubre\",\"correoElectronico\":\"8Octubre@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1759993282307,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(6,6,1760069196978,'{\"Usuario\":{\"nombre\":\"9oCTUBRE\",\"apellidoPaterno\":\"9Octubre\",\"apellidoMaterno\":\"NueveOct\",\"curp\":\"nueveOCT123\",\"numEmpleado\":15,\"area\":2,\"roles\":[4,5],\"estado\":\"Inicial\",\"usuarioID\":\"9OCTUBRE\",\"correoElectronico\":\"9oct@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1760069081311,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
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
(7,5,1758812948089,'{\"Actualizacion\":{\"curp\":\"25Sept2025\",\"numEmpleado\":11,\"nombre\":\"jejejeje\",\"apellidoPaterno\":\"25Sept2025\",\"apellidoMaterno\":\"25Sept2025\",\"estado\":\"Activo\",\"area\":6,\"roles\":[3],\"correoElectronico\":\"25Sept2025@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758812878763,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1758813203869,'{\"Actualizacion\":{\"curp\":\"24Septiembre\",\"numEmpleado\":12,\"nombre\":\"24Septiembre\",\"apellidoPaterno\":\"24Septiembre\",\"apellidoMaterno\":\"24Septiembre\",\"estado\":\"Activo\",\"area\":7,\"roles\":[1],\"correoElectronico\":\"24Septiembre@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758813138100,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1758813348420,'{\"Actualizacion\":{\"curp\":\"ELCP0000\",\"numEmpleado\":22,\"nombre\":\"Paco\",\"apellidoPaterno\":\"El\",\"apellidoMaterno\":\"Chato\",\"estado\":\"Activo\",\"area\":4,\"roles\":[3],\"correoElectronico\":\"pacoelchato@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758813312014,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1758813412490,'{\"Actualizacion\":{\"curp\":\"Prueba123\",\"numEmpleado\":3,\"nombre\":\"hola\",\"apellidoPaterno\":\"soy\",\"apellidoMaterno\":\"una\",\"estado\":\"Activo\",\"area\":1,\"roles\":[4],\"correoElectronico\":\"holapruebajeje@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758813387808,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1758813445418,'{\"Actualizacion\":{\"curp\":\"Prueba123\",\"numEmpleado\":3,\"nombre\":\"hola\",\"apellidoPaterno\":\"soy\",\"apellidoMaterno\":\"una\",\"estado\":\"Activo\",\"area\":1,\"roles\":[1,2,3,4,5,6],\"correoElectronico\":\"holapruebajeje@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1758813387808,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1760069308495,'{\"Actualizacion\":{\"curp\":\"8Octubre\",\"numEmpleado\":14,\"nombre\":\"Edicion\",\"apellidoPaterno\":\"Desde\",\"apellidoMaterno\":\"JefeDeServicio\",\"estado\":\"Activo\",\"area\":5,\"roles\":[2,3],\"correoElectronico\":\"edicion.js@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1760069219797,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1760069967479,'{\"Actualizacion\":{\"curp\":\"PEPC000000\",\"numEmpleado\":0,\"nombre\":\"Carlos\",\"apellidoPaterno\":\"Pérez\",\"apellidoMaterno\":\"Pérez\",\"estado\":\"Inicial\",\"area\":5,\"roles\":[1,2,3,4,5,6],\"correoElectronico\":\"carlos@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1760069927219,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(7,5,1760070089317,'{\"Actualizacion\":{\"curp\":\"PEPC000000\",\"numEmpleado\":0,\"nombre\":\"Carlos Alberto\",\"apellidoPaterno\":\"Pérez\",\"apellidoMaterno\":\"Pérez\",\"estado\":\"Inicial\",\"area\":5,\"roles\":[1,2,3,4,5,6],\"correoElectronico\":\"carlos@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1760070074960,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(8,5,1757559727191,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Dado de baja\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(9,5,1757559666824,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(10,5,1757559700758,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Bloqueado\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"p.misaelrj@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(11,2,1759984700798,'{\"estadoActual\":\"Fuera de servicio\",\"estadoAnterior\":\"Disponible\"}'),
(11,2,1760021218690,'{\"estadoActual\":\"Disponible\",\"estadoAnterior\":\"Fuera de servicio\"}'),
(1001,0,1757555983427,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"jdlskañd\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757555989415,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"holaaaa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757555995022,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"mlkdsamda\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556002320,'{\"usuarioId\":\"MaddieRB\",\"contrasena\":\"holaa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556018242,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP21331\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556040498,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"sasa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757556068971,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"jsoajsa\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757558007955,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP00000\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1757559633618,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1758337993124,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMudno\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1758853315910,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"jolaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1758862554939,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holamundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1758863528628,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holamundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759134390504,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holamundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759255501855,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"hoolaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759256211304,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMuno\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759688403481,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMindo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759688786000,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMuno\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759688900386,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMund\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759724969074,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaM;undo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759728036947,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundp\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759802261459,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaNundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1001,0,1759894291082,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holasMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1002,0,1757556060621,'{\"usuarioId\":\"MisaRJww\",\"contrasena\":\"dksld\",\"ipAddress\":\"127.0.0.1\"}'),
(1002,0,1759815084199,'{\"usuarioId\":\"LIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757556173525,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP00qqq\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757556182597,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757557421736,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP0000\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757557847173,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1003,0,1757559622332,'{\"usuarioId\":\"MisaRJ\",\"contrasena\":\"ROJP000000\",\"ipAddress\":\"127.0.0.1\"}'),
(1004,3,1758084130777,'{}'),
(1008,5,1757559800250,'{\"Actualizacion\":{\"curp\":\"ROJP000000\",\"numEmpleado\":10,\"nombre\":\"Pedro Misael\",\"apellidoPaterno\":\"Rodríguez\",\"apellidoMaterno\":\"Jiménez\",\"estado\":\"Activo\",\"area\":5,\"roles\":[1],\"correoElectronico\":\"prueba@gmail.com\"},\"SesionActiva\":{\"horaInicio\":1757559643869,\"usuarioCURP\":\"LIIM0000\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(1008,6,1758299991680,'{\"Usuario\":{\"nombre\":\"Prueba\",\"apellidoPaterno\":\"Prueba\",\"apellidoMaterno\":\"Prueba\",\"curp\":\"Prueba\",\"numEmpleado\":20,\"area\":1,\"roles\":[1],\"estado\":\"Inicial\",\"correoElectronico\":\"Prueba@gmail.com\",\"usuarioID\":\"19Septiembre\"},\"SesionActiva\":{\"horaInicio\":1758299950475,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(1008,6,1758338058839,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"ds\",\"numEmpleado\":321312,\"area\":4,\"roles\":[1,2,3,4,5,6],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasdasd\",\"usuarioID\":\"dasdasdasd\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(1008,6,1758338083535,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"ds\",\"numEmpleado\":321312,\"area\":4,\"roles\":[1,2,3,4,5,6],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasdasd\",\"usuarioID\":\"dasdasdasd\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(1008,6,1758338114624,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"ds\",\"numEmpleado\":321312,\"area\":4,\"roles\":[1,2,3,4,5,6],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasdasd\",\"usuarioID\":\"qew\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(1008,6,1758338134465,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"ds\",\"numEmpleado\":321312,\"area\":4,\"roles\":[],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasdasd\",\"usuarioID\":\"qwew\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}'),
(1008,6,1758338178102,'{\"Usuario\":{\"nombre\":\"asdasdasdas\",\"apellidoPaterno\":\"dasdasdas\",\"apellidoMaterno\":\"dasdasdas\",\"curp\":\"ds\",\"numEmpleado\":321312,\"area\":4,\"roles\":[1,2,3,4,5,6],\"estado\":\"Inicial\",\"correoElectronico\":\"asdasdasd\",\"usuarioID\":\"qwew\"},\"SesionActiva\":{\"horaInicio\":1758338005895,\"usuarioCURP\":\"PEPC000000\",\"usuarioNumEmpleado\":0,\"aplicacionID\":0}}');
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
(1757619234411,1757619836010,'127.0.0.1','Inactividad',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758083925716,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758299596687,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1758299950475,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1758338005895,1758338825053,'127.0.0.1','Inactividad',0,'PEPC000000',0,'Admin','carlos'),
(1758494546533,1758494557287,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758496345930,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758496967102,1758496970944,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758497557929,1758497566799,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758497599712,1758497914108,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758499556084,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758499758866,1758499771182,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758499845210,1758499855601,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758499865414,1758499868149,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758500019540,1758500634022,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758505526381,1758505543699,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758505792766,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758505904706,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758506263027,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758506777739,1758507410009,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758508816098,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758509550138,1758509600752,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758514595893,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758514715167,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758514783864,1758514804697,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758515050602,1758515076083,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758515969280,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758517355424,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758517488493,1758517492404,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758517501141,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1758518465874,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758572210189,1758572244483,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758572387173,1758572445125,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758596744586,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1758597198839,1758597239491,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1758597398734,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1758721878454,1758721948193,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758722035832,1758722050192,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758722064092,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1758722195381,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1758722495341,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758722608655,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758723068003,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758723832521,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758723982883,1758724583014,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758724816849,1758724847431,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758724881761,1758724897832,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758724925404,1758724937551,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758724962634,1758724982739,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758725220255,1758725830111,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758726923745,1758726952421,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758742212669,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758742297763,1758742475647,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758742485891,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1758742526030,1758742624090,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758777677463,1758777682804,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1758777696862,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758809304318,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758809639131,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758809781991,1758809957490,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758809983405,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758810183425,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758810321628,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758810678202,1758810982890,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758811023895,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758811200835,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758811304832,1758811491630,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758811506455,1758811858277,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758811888890,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758811997888,1758812086984,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758812107273,1758812229161,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758812251645,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758812878763,1758813118674,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758813138100,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758813312014,1758813359207,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758813387808,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758813607349,1758813665782,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758813692620,1758814303016,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758826298659,1758826310485,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758826340447,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758826631086,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758826708640,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758826924895,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758827048737,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758827142313,1758830872161,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758830878626,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1758831316457,1758831922007,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758852859071,1758852865732,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758853332254,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758853550735,1758854251009,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1758863212656,1758863221290,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758863331245,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758863410371,1758863436304,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758863473803,1758863477959,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758863539796,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758863631923,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1758863756164,1758863760239,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758863864397,1758863875592,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758864047827,1758864096091,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758917384109,1758917880230,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758917894820,1758917993425,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1758918073531,1758918114486,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759027629977,1759027694541,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759027942803,1759027952088,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759027984306,1759027994349,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028052695,1759028060993,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028242472,1759028250251,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028438790,1759028445225,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028536739,1759028544772,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028583450,1759028590863,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028654767,1759028662834,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759028945066,1759028954087,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759119022744,1759119047834,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759119175125,1759119200448,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759119221965,1759119269472,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759119284809,1759119297289,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759121171170,1759121179592,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759121186362,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759121698357,1759121729246,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759121888185,1759121919974,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759122176403,1759122191131,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759122553818,1759122563341,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759122627313,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759128894776,1759128898985,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759128905103,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759129213896,1759129230822,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759129288855,1759129299450,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759129328495,1759129337852,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759129564386,1759132363771,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1759133554210,1759133589696,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759133610951,1759133623771,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134055650,1759134324505,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134409441,1759134431258,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134473364,1759134597172,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134611868,1759134645767,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134659393,1759134721294,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134733756,1759134776900,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134790947,1759134832194,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759134866006,1759135241725,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759135262369,1759135275858,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759135286823,1759135298645,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759160901028,1759160958486,'127.0.0.1','Normal',10,'ROJP000000',0,'Admin','MisaRJ'),
(1759161774278,1759161790251,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759162013183,1759162037075,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759162059192,1759162073919,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759162382236,1759162583425,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759162606389,1759162628164,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759175055512,1759175090818,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759175211999,1759175662847,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759247638122,1759247690474,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759247788852,1759247808467,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759247847038,1759247877816,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759247945077,1759248092404,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759248098495,1759248284829,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759248412794,1759248423683,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759248733987,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759248794927,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759250341044,1759250352518,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759250407032,1759250415105,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759250444915,1759250465011,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759250477315,1759250480627,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759250504086,1759250527718,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759250580295,1759250634624,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759250650647,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759250697887,1759251279164,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759251328728,1759251338796,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759251364820,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759251405172,1759251421408,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255101210,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759255132598,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759255192383,1759255199221,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255239617,1759255248630,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255289416,1759255295491,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255307168,1759255359947,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255371316,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759255510434,1759255521918,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255542690,1759255547689,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255553302,1759255664834,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255681675,1759255685340,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255719737,1759255734513,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255758889,1759255765237,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255836728,1759255841873,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255853946,1759255885855,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255900024,1759255919890,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255946532,1759255950239,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255970402,1759255979052,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759255998674,1759256005934,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256112460,1759256116311,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256141261,1759256195163,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256232904,1759256253096,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256266393,1759256284412,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256352545,1759256382114,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256421465,1759256432385,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256752815,1759256756164,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256821234,1759256823165,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759256911485,1759256915010,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257061618,1759257064071,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257069529,1759257077631,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257171240,1759257177274,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257479009,1759257493003,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257511651,1759257534098,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257548058,1759257557811,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257599379,1759257614263,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257660131,1759257662416,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257695107,1759257698038,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257739610,1759257742856,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257806776,1759257810256,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257846720,1759257849780,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759257932003,1759257938803,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759258008300,1759258012044,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759258047299,1759258050864,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759258116509,1759258118783,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759258258303,1759258263712,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759258292548,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759258443348,1759258568520,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759260492150,1759260541497,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759292921001,1759292931300,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759293025424,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759293312416,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759293348623,1759294095963,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1759294188207,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759294215508,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759294280697,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759294304451,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759295688573,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759295882311,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759296002648,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759411839608,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1759411868639,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Radiólogo','LIIM'),
(1759412299924,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759412419501,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Radiólogo','LIIM'),
(1759439140039,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Radiólogo','LIIM'),
(1759439233142,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1759439345985,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759439555858,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759439569794,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1759439588474,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Radiólogo','LIIM'),
(1759439596804,1759439599966,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759439609980,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759439645441,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759439678763,1759452521466,'127.0.0.1','Inactividad',1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759452344038,1759452404244,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759452416513,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759452526664,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Recepcionista','LIIM'),
(1759452553135,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759452671038,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759680882792,1759680888483,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759680960132,1759681051359,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681060027,1759681062839,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681091267,1759681095523,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681121347,1759681123788,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681143153,1759681145934,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681167125,1759681169867,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681202127,1759681224616,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759681237058,1759681245975,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759683075210,1759683177668,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'Admin','LIIM'),
(1759683197669,1759683223927,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759684765708,1759684778606,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759684852316,1759684858232,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759684875955,1759685254154,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759685484676,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759685541564,1759686767204,'127.0.0.1','Inactividad',1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759686781862,1759686786056,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759686794115,1759686800170,'127.0.0.1','Normal',1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759686928572,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759686993886,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759687096034,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759687213595,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759687255435,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759687456424,1759687460805,'127.0.0.1','Normal',1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759687523933,1759687526615,'127.0.0.1','Normal',1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759687657933,1759687664303,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759687689766,1759687692787,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759687780591,1759687783613,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759687951147,1759687953741,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688268566,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688297980,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688412615,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688801573,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688825325,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688858584,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688909440,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759688994451,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759689105066,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759689119131,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759689144188,NULL,'127.0.0.1',NULL,10,'ROJP000000',0,'Admin','MisaRJ'),
(1759689206919,1759689209699,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759689364272,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759689537794,1759689562125,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759689595037,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707347293,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707414280,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707488400,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707589472,1759707648770,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707779683,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707823570,1759707827019,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759707971711,1759708006634,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759709878767,1759709885304,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759711266082,1759711308912,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759711321423,1759711327795,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759711343548,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759711591309,1759720290565,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759721194613,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759721273410,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759721332633,1759721530302,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759721536547,1759721554795,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759722157883,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759722240468,1759722244866,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759722267631,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759722322702,1759722326296,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759722419719,1759722426112,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759722454534,1759722463362,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759722485702,1759722488442,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759723882952,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724178003,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724210564,1759724229312,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724247636,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724433413,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724481391,1759724500432,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724652090,1759724950668,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759724980846,1759725019212,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759725033113,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759725087390,1759725745687,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759725758782,1759726384137,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759728049550,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'SubdirectordeServicios','LIIM'),
(1759728137119,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759728250400,1759728382151,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759728395602,1759728418790,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759728483266,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759728636015,1759729239015,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759729832662,1759729863192,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759729870336,1759729929858,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759729955053,1759729982910,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759730054850,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759730236203,1759730260486,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759730363562,1759730395288,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759730430340,1759730441492,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759730554145,1759730557496,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759730567973,1759730626040,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759730799560,1759731177902,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759731229671,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759731367170,1759731653922,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759731667410,1759731791732,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759731808879,1759731862268,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759731876659,1759731982888,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759732069697,1759732325024,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759732407555,1759732482052,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759732495435,1759732514070,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759756855588,1759756868223,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759757364968,1759757368357,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759757374496,1759757378372,'127.0.0.1','Normal',0,'PEPC000000',0,'Recepcionista','carlos'),
(1759757384494,1759757388152,'127.0.0.1','Normal',0,'PEPC000000',0,'Radiólogo','carlos'),
(1759757398609,1759757403998,'127.0.0.1','Normal',0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759757410646,1759757414067,'127.0.0.1','Normal',0,'PEPC000000',0,'SubdirectordeServicios','carlos'),
(1759757421352,1759757450560,'127.0.0.1','Normal',0,'PEPC000000',0,'CoordinadordelServicio','carlos'),
(1759757466457,1759757470334,'127.0.0.1','Normal',0,'PEPC000000',0,'CoordinadordelServicio','carlos'),
(1759761120786,1759761140004,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759761149217,1759761749008,'127.0.0.1','Inactividad',0,'PEPC000000',0,'Recepcionista','carlos'),
(1759761874041,1759761921330,'127.0.0.1','Normal',0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759762257420,1759762428900,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759799935051,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759800018146,1759800292256,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759800302467,1759800445243,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759800456789,1759800543916,'127.0.0.1','Normal',0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759800549673,1759800575047,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759800594239,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759800847273,1759800854398,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759800866667,1759800950374,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759801071958,1759801165849,'127.0.0.1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1759801217266,1759801225962,'127.0.0.1','Normal',0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759801241236,1759801280205,'127.0.0.1','Normal',0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759801544568,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'JefedelServicio','carlos'),
(1759801704524,1759802181049,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759802194478,1759802239867,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759802268923,1759802482801,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759802492891,NULL,'127.0.0.1',NULL,0,'PEPC000000',0,'Admin','carlos'),
(1759802660258,1759802711732,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759804836177,1759804946697,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759804983472,1759805044122,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759805060258,1759805383804,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759805405029,1759805679158,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759805695266,1759805802232,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759805816168,1759805861636,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759805876628,1759806199198,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759806336585,1759806556342,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759806578967,1759806679733,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759806692941,1759806811439,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759806827546,1759807066523,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759807078381,1759807082640,'127.0.0.1','Normal',1000,'6Octubre',0,'Radiólogo','6Octubre'),
(1759807203442,1759807220157,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759807239265,1759807327196,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759807655729,1759807722259,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759807733226,1759807738198,'127.0.0.1','Normal',1,'LIIM0000',0,'Recepcionista','LIIM'),
(1759807974047,1759808009849,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759808061137,1759808106647,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759808128667,1759808166230,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759808179261,1759808227481,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759808240014,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759808336262,1759809166008,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759813503899,1759813520226,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759813614901,1759813655320,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759813993039,1759814006727,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759814037969,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759814620920,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759814695404,1759814762702,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759814774354,1759814845592,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759814859516,1759814870822,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759814952505,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759815008380,1759815066419,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759815095840,1759815140771,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759815162259,1759815204877,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759815277838,1759815286119,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759815316875,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759815409751,1759815414399,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759847659495,1759847668334,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759847676607,1759847888997,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759847898275,1759847922166,'127.0.0.1','Normal',1,'LIIM0000',0,'Recepcionista','LIIM'),
(1759893890667,1759893942290,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894047381,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759894095073,1759894125029,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894138484,1759894149481,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894221002,1759894232907,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894297502,1759894353216,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894367916,1759894470246,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894483417,1759894505295,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894661332,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759894802311,1759894843639,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759894901567,1759894913818,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759895454183,1759895511311,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759895746993,1759895800781,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759895862154,1759895989153,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759895996857,1759896004863,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759896210209,1759896218973,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759896311524,1759896921146,'127.0.0.1','Inactividad',1,'LIIM0000',0,'Admin','LIIM'),
(1759899909820,1759900051582,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759902691406,1759902711178,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759902860752,1759902868223,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759902873701,1759902943095,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759903000856,1759903108756,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759903129606,1759903428037,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759904565951,1759904600484,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759904654225,1759904782964,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759904799397,1759905060525,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759905166501,1759905175313,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759905304105,1759905314093,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759905384785,1759905399365,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759906260614,1759906266890,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759906535073,1759906613238,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759906637716,1759906708462,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759906720261,1759906803092,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759906815541,1759906921520,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759906932830,1759906942286,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759934224629,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759934814978,1759934817763,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759934823653,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759980064517,1759980073241,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759980129466,1759980142409,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759980676028,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759980778645,1759980787725,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759980795848,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759980949275,1759981552008,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759982322879,1759982376362,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759982390856,1759982398257,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759982481300,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759982688060,1759982940819,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759982951974,1759982993898,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759983007042,1759983107781,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759983123479,1759983396761,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759983412699,1759983445449,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759983475938,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759984227022,1759985304147,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759988168593,1759988184196,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759990378430,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759990501172,1759990515564,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759990541450,1759990620843,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759990632489,1759990846135,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759990859429,1759990907143,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759990922347,1759991240529,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759991251911,1759991306636,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759991320095,1759991420893,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759991432676,1759991438602,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759991602693,1759992088092,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759992099326,1759992182656,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759992629699,1759992860315,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759992915259,1759992980344,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759992992763,NULL,'127.0.0.1',NULL,1,'LIIM0000',0,'Admin','LIIM'),
(1759993175675,1759993206693,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759993221481,1759993269888,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1759993282307,1759993658976,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1759993672060,1759993848309,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1760021161006,1760021300659,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1760021308001,1760021422400,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1760021715435,1760021726076,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1760021738408,1760021914786,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1760021922871,1760021963368,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1760069081311,1760069211635,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1760069219797,1760069919017,'127.0.0.1','Inactividad',1,'LIIM0000',0,'JefedelServicio','LIIM'),
(1760069927219,1760070051972,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1760070067180,1760070069056,'127.0.0.1','Normal',1,'LIIM0000',0,'Admin','LIIM'),
(1760070074960,1760070104336,'127.0.0.1','Normal',1,'LIIM0000',0,'JefedelServicio','LIIM');
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
(2,'21Septiembreq',1,'21Septiembre','21Septiembreq','21Septiembreq','21Septiembreq@gmail.com'),
(3,'Prueba123',1,'hola','soy','una','holapruebajeje@gmail.com'),
(4,'21Septiembre2025',1,'21Septiembre2025','21Septiembre2025','21Septiembre2025','21Septiembre2025@gmail.com'),
(5,'PRUEBA0000',4,'Prueba Edicion','pruebaaaaa','pruebaaaaa','prueba@gmail.com'),
(6,'hola21Septiembre2025',1,'hola21Septiembre2025','hola21Septiembre2025','hola21Septiembre2025','hola21Septiembre2025'),
(7,'qweqwe',2,'qwe','qwe','qwe','qweqwe'),
(8,'asdasdasd',1,'asd','asdas','dasd','asdasd@gmail.com'),
(9,'25Septiembre',2,'25Septiembre','25Septiembre','25Septiembre','25Septiembre@gmail.com'),
(10,'ROJP000000',5,'Pedro Misael','Rodríguez','Jiménez','p.misaelrj@gmail.com'),
(11,'25Sept2025',6,'jejejeje','25Sept2025','25Sept2025','25Sept2025@gmail.com'),
(12,'24Septiembre',7,'24Septiembre','24Septiembre','24Septiembre','24Septiembre@gmail.com'),
(13,'29Septiembre2025',4,'29Septiembre','29Septiembre','29Septiembre','29Septiembre@gmail.com'),
(14,'8Octubre',5,'Edicion','Desde','JefeDeServicio','edicion.js@gmail.com'),
(15,'nueveOCT123',2,'9oCTUBRE','9Octubre','NueveOct','9oct@gmail.com'),
(22,'ELCP0000',4,'Paco','El','Chato','pacoelchato@gmail.com'),
(100,'REBM111111',5,'Maddie','Rebolledo','Bustillo','maddie.rb@gmail.com'),
(122,'asdasdasd',4,'asdasdasdas','dasdasdas','dasdasdas','asdasdasd'),
(1000,'6Octubre',8,'6Octubre','6Octubre','6Octubre','6Octubre@gmail.com'),
(321312,'ds',4,'asdasdasdas','dasdasdas','dasdasdas','rew');
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

-- Dump completed on 2025-10-11 14:49:58
