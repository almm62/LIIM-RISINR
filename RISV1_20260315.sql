/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: RISV1
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `AgendaDeServicio`
--

DROP TABLE IF EXISTS `AgendaDeServicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Aplicacion` (
  `idAplicacion` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Descrpcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idAplicacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(6,'Alta de Usuarios','Alta de usuario nuevo'),
(7,'CONSULTA CITAS','Aplicación de consultar citas'),
(8,'AGENDA CITA','Aplicación de agendar citas'),
(9,'REAGENDA CITA','Aplicación de reagendar citas'),
(10,'CANCELA CITA','Aplicación de cancelar citas');
/*!40000 ALTER TABLE `Aplicacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AreaDeServicio`
--

DROP TABLE IF EXISTS `AreaDeServicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AreaDeServicio` (
  `idArea` int(11) NOT NULL,
  `Nombre` varchar(60) NOT NULL,
  `Descripcion` varchar(120) NOT NULL,
  PRIMARY KEY (`idArea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AsignacionEstudio` (
  `EquipoImagenologia_NSerie` varchar(50) NOT NULL,
  `Estudio_idEstudio` int(11) NOT NULL,
  `FechaPk` bigint(20) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`EquipoImagenologia_NSerie`,`Estudio_idEstudio`,`FechaPk`),
  KEY `fk_EquipoImagenologia_has_Estudio_Estudio1_idx` (`Estudio_idEstudio`),
  KEY `fk_EquipoImagenologia_has_Estudio_EquipoImagenologia1_idx` (`EquipoImagenologia_NSerie`),
  CONSTRAINT `fk_EquipoImagenologia_has_Estudio_EquipoImagenologia1` FOREIGN KEY (`EquipoImagenologia_NSerie`) REFERENCES `EquipoImagenologia` (`NSerie`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_EquipoImagenologia_has_Estudio_Estudio1` FOREIGN KEY (`Estudio_idEstudio`) REFERENCES `Estudio` (`idEstudio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AsignacionEstudio`
--

LOCK TABLES `AsignacionEstudio` WRITE;
/*!40000 ALTER TABLE `AsignacionEstudio` DISABLE KEYS */;
INSERT INTO `AsignacionEstudio` VALUES
('EquipoA1',1,1699981200000,'2023-11-14 17:00:00','Activo');
/*!40000 ALTER TABLE `AsignacionEstudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ConfiguracionRIS`
--

DROP TABLE IF EXISTS `ConfiguracionRIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ConfiguracionRIS` (
  `Equipo_NSerie` varchar(50) NOT NULL,
  `TipoConfiguracion` varchar(45) NOT NULL,
  `IPAddress` varchar(15) DEFAULT NULL,
  `Puerto` int(11) DEFAULT NULL,
  `NombreEntidad` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Equipo_NSerie`),
  CONSTRAINT `fk_ConfiguracionRIS_Equipo1` FOREIGN KEY (`Equipo_NSerie`) REFERENCES `Equipo` (`NSerie`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
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
  `EquipoImagenologia_NSerie` varchar(50) NOT NULL,
  `Medico_NumEmpleado` int(11) NOT NULL,
  `Medico_CURP` varchar(45) NOT NULL,
  PRIMARY KEY (`Usuario_NumEmpleado`,`Usuario_CURP`,`Paciente_IDPaciente`,`Estudio_idEstudio`,`FechaControlPk`,`EquipoImagenologia_NSerie`,`Medico_NumEmpleado`,`Medico_CURP`),
  KEY `fk_Usuario_has_Paciente_Paciente1_idx` (`Paciente_IDPaciente`),
  KEY `fk_Usuario_has_Paciente_Usuario1_idx` (`Usuario_NumEmpleado`,`Usuario_CURP`),
  KEY `fk_ControlEstudios_Estudio1_idx` (`Estudio_idEstudio`),
  KEY `fk_ControlEstudios_EquipoImagenologia1_idx` (`EquipoImagenologia_NSerie`),
  KEY `fk_ControlEstudios_Medico1_idx` (`Medico_NumEmpleado`,`Medico_CURP`),
  CONSTRAINT `fk_ControlEstudios_EquipoImagenologia1` FOREIGN KEY (`EquipoImagenologia_NSerie`) REFERENCES `EquipoImagenologia` (`NSerie`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ControlEstudios_Estudio1` FOREIGN KEY (`Estudio_idEstudio`) REFERENCES `Estudio` (`idEstudio`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ControlEstudios_Medico1` FOREIGN KEY (`Medico_NumEmpleado`, `Medico_CURP`) REFERENCES `Medico` (`NumEmpleado`, `CURP`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Paciente_Paciente1` FOREIGN KEY (`Paciente_IDPaciente`) REFERENCES `Paciente` (`idPaciente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Usuario_has_Paciente_Usuario1` FOREIGN KEY (`Usuario_NumEmpleado`, `Usuario_CURP`) REFERENCES `Usuario` (`NumEmpleado`, `CURP`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ControlEstudios`
--

LOCK TABLES `ControlEstudios` WRITE;
/*!40000 ALTER TABLE `ControlEstudios` DISABLE KEYS */;
INSERT INTO `ControlEstudios` VALUES
(11,'RecepcionistaA1','102',1,1699981200000,'2023-11-14 17:00:00','Programado',0,'Prueba 27Nov2025','EquipoA1',102,'MedicoRM');
/*!40000 ALTER TABLE `ControlEstudios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DatosAcceso`
--

DROP TABLE IF EXISTS `DatosAcceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DatosAcceso` (
  `Contraseña` varchar(20) NOT NULL,
  `UsuarioID` varchar(45) NOT NULL,
  `Usuario_NumEmpleado` int(11) NOT NULL,
  `Usuario_CURP` varchar(45) NOT NULL,
  `Estado` varchar(45) NOT NULL,
  PRIMARY KEY (`UsuarioID`,`Usuario_NumEmpleado`,`Usuario_CURP`),
  KEY `fk_DatosAcceso_Usuario1_idx` (`Usuario_NumEmpleado`,`Usuario_CURP`),
  CONSTRAINT `fk_DatosAcceso_Usuario1` FOREIGN KEY (`Usuario_NumEmpleado`, `Usuario_CURP`) REFERENCES `Usuario` (`NumEmpleado`, `CURP`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DatosAcceso`
--

LOCK TABLES `DatosAcceso` WRITE;
/*!40000 ALTER TABLE `DatosAcceso` DISABLE KEYS */;
INSERT INTO `DatosAcceso` VALUES
('abc123','carlos',0,'PEPC000000','Activo'),
('holaMundo','LIIM',1,'LIIM','Activo'),
('MEDICO','Medico',3,'MEDICO','Inicial'),
('MedicoMN','MedicoMN',104,'MedicoMN','Inicial'),
('MedicoRM','MedicoRM',102,'MedicoRM','Inicial'),
('MedicoRX','MedicoRX',101,'MedicoRX','Inicial'),
('MedicoTC','MedicoTC',103,'MedicoTC','Inicial'),
('hola','MisaelRJ',2,'ROJP000000','Activo'),
('hola','RecepcionistaA1',11,'RecepcionistaA1','Activo'),
('RecepcionistaA2','RecepcionistaA2',12,'RecepcionistaA2','Inicial'),
('RecepcionistaA3','RecepcionistaA3',13,'RecepcionistaA3','Inicial'),
('RecepcionistaA4','RecepcionistaA4',14,'RecepcionistaA4','Inicial');
/*!40000 ALTER TABLE `DatosAcceso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Domicilio`
--

DROP TABLE IF EXISTS `Domicilio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Domicilio`
--

LOCK TABLES `Domicilio` WRITE;
/*!40000 ALTER TABLE `Domicilio` DISABLE KEYS */;
INSERT INTO `Domicilio` VALUES
('101','AV. INSURGENTES SUR','1234','DEL VALLE','BENITO JUAREZ','CIUDAD DE MEXICO','03100',0,'5512345678'),
('102','CALLE REFORMA','567','JUAREZ','CUAUHTEMOC','CIUDAD DE MEXICO','06600',0,'5523456789'),
('103','AV. UNIVERSIDAD','890','COPILCO','COYOACAN','CIUDAD DE MEXICO','04360',1,'5534567890'),
('104','CALLE PUEBLA','234','ROMA NORTE','CUAUHTEMOC','CIUDAD DE MEXICO','06700',0,'5545678901'),
('105','AV. REVOLUCION','456','SAN ANGEL','ALVARO OBREGON','CIUDAD DE MEXICO','01000',1,'5556789012'),
('106','AV. LAZARO CARDENAS','2345','CENTRO','MONTERREY','NUEVO LEON','64000',8,'8187654321'),
('107','CALLE COLON','3456','ZONA CENTRO','GUADALAJARA','JALISCO','44100',7,'3398765432'),
('108','AV. HEROES DE NACOZARI','4567','MODERNA','HERMOSILLO','SONORA','83190',10,'6629876543'),
('109','CALLE MADERO','5678','CENTRO','MERIDA','YUCATAN','97000',12,'9991098765'),
('110','AV. CONSTITUCION','6789','ZONA RIO','TIJUANA','BAJA CALIFORNIA','22010',15,'6642109876'),
('111','AV. JUAREZ','234','CENTRO','TOLUCA','ESTADO DE MEXICO','50000',2,'7221234567'),
('112','CALLE HIDALGO','456','CENTRO','CUERNAVACA','MORELOS','62000',2,'7773456789'),
('113','AV. LOPEZ MATEOS','789','LAS AMERICAS','NAUCALPAN','ESTADO DE MEXICO','53040',1,'5554567890'),
('114','CALLE MORELOS','321','CENTRO','PACHUCA','HIDALGO','42000',2,'7715678901'),
('115','AV. BENITO JUAREZ','654','JIUTEPEC','JIUTEPEC','MORELOS','62550',2,'7776789012'),
('116','CALLE ALLENDE','987','CENTRO','TLAXCALA','TLAXCALA','90000',2,'2467890123'),
('117','AV. CONSTITUYENTES','147','SANTIAGO TLAXOMULCO','TLALNEPANTLA','ESTADO DE MEXICO','54040',1,'5558901234'),
('118','CALLE GUERRERO','258','CENTRO','CUAUTLA','MORELOS','62740',2,'7359012345'),
('119','AV. ADOLFO LOPEZ MATEOS','369','ATIZAPAN','ATIZAPAN DE ZARAGOZA','ESTADO DE MEXICO','52900',1,'5550123456'),
('120','CALLE INDEPENDENCIA','741','CENTRO','PUEBLA','PUEBLA','72000',3,'2221234567');
/*!40000 ALTER TABLE `Domicilio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Equipo`
--

DROP TABLE IF EXISTS `Equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Equipo` (
  `NSerie` varchar(50) NOT NULL,
  `AreaDeServicio_idArea` int(11) NOT NULL,
  `Ubicacion` varchar(60) NOT NULL,
  PRIMARY KEY (`NSerie`),
  KEY `fk_Equipo_AreaDeServicio1_idx` (`AreaDeServicio_idArea`),
  CONSTRAINT `fk_Equipo_AreaDeServicio1` FOREIGN KEY (`AreaDeServicio_idArea`) REFERENCES `AreaDeServicio` (`idArea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Equipo`
--

LOCK TABLES `Equipo` WRITE;
/*!40000 ALTER TABLE `Equipo` DISABLE KEYS */;
INSERT INTO `Equipo` VALUES
('EquipoA1',1,'SALA 1'),
('EquipoA1_2',1,'SALA 1'),
('EquipoA2',2,'SALA 2'),
('EquipoA2_2',2,'SALA 2'),
('EquipoA3',3,'SALA 3'),
('EquipoA3_2',3,'SALA 3'),
('EquipoA4',4,'SALA 4'),
('EquipoA4_2',4,'SALA 4');
/*!40000 ALTER TABLE `Equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EquipoImagenologia`
--

DROP TABLE IF EXISTS `EquipoImagenologia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EquipoImagenologia`
--

LOCK TABLES `EquipoImagenologia` WRITE;
/*!40000 ALTER TABLE `EquipoImagenologia` DISABLE KEYS */;
INSERT INTO `EquipoImagenologia` VALUES
('EquipoA1',1,'EquipoPruebaRX','Generico','2025','RX','2025-11-20','Disponible'),
('EquipoA1_2',1,'EquipoPruebaRX','Generico','2025','RX','2025-11-20','Disponible'),
('EquipoA2',2,'EquipoPruebaRM','Generico','2025','RM','2025-11-20','Disponible'),
('EquipoA2_2',2,'EquipoPruebaRM','Generico','2025','RM','2025-11-20','Disponible'),
('EquipoA3',3,'EquipoPruebaTC','Generico','2025','TC','2025-11-20','Disponible'),
('EquipoA3_2',3,'EquipoPruebaTC','Generico','2025','TC','2025-11-20','Disponible'),
('EquipoA4',4,'EquipoPruebaMN','Generico','2025','MN','2025-11-20','Disponible'),
('EquipoA4_2',4,'EquipoPruebaMN','Generico','2025','MN','2025-11-20','Disponible');
/*!40000 ALTER TABLE `EquipoImagenologia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Especialidad`
--

DROP TABLE IF EXISTS `Especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Especialidad` (
  `idEspecialidad` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idEspecialidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Especialidad`
--

LOCK TABLES `Especialidad` WRITE;
/*!40000 ALTER TABLE `Especialidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `Especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Especialidad_Medica`
--

DROP TABLE IF EXISTS `Especialidad_Medica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Estudio` (
  `idEstudio` int(11) NOT NULL,
  `AreaDeServicio_idArea` int(11) NOT NULL,
  `Nombre` varchar(64) NOT NULL,
  `Descripcion` varchar(65) NOT NULL,
  PRIMARY KEY (`idEstudio`),
  KEY `fk_Estudio_AreaDeServicio1_idx` (`AreaDeServicio_idArea`),
  CONSTRAINT `fk_Estudio_AreaDeServicio1` FOREIGN KEY (`AreaDeServicio_idArea`) REFERENCES `AreaDeServicio` (`idArea`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Evento` (
  `idEvento` int(11) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idEvento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(12,'Consulta de cita correcta'),
(13,'Asignación de cita correcta'),
(14,'Agendamiento de cita correcto'),
(15,'Reagendamiento de cita correcto'),
(16,'Cancelación de cita correcta'),
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
(1012,'Adición de usuario fallida por datos incompletos'),
(1013,'Edición de usuario fallida por datos incompletos'),
(1014,'Agendamiento de cita incorrecto'),
(1015,'Asignación de cita incorrecta'),
(1016,'Reagendamiento de cita incorrecto'),
(1017,'Cancelación de cita incorrecta');
/*!40000 ALTER TABLE `Evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medico`
--

DROP TABLE IF EXISTS `Medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Medico` (
  `NumEmpleado` int(11) NOT NULL,
  `CURP` varchar(45) NOT NULL,
  PRIMARY KEY (`NumEmpleado`,`CURP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medico`
--

LOCK TABLES `Medico` WRITE;
/*!40000 ALTER TABLE `Medico` DISABLE KEYS */;
INSERT INTO `Medico` VALUES
(3,'MEDICO'),
(10,'MedicoRX'),
(101,'MedicoRX'),
(102,'MedicoRM'),
(103,'MedicoTC'),
(104,'MedicoMN');
/*!40000 ALTER TABLE `Medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Paciente`
--

DROP TABLE IF EXISTS `Paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Paciente` (
  `idPaciente` varchar(20) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `ApellidoPaterno` varchar(45) NOT NULL,
  `ApellidoMaterno` varchar(45) NOT NULL,
  `Sexo` varchar(40) NOT NULL,
  `FechaNacimiento` date NOT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Paciente`
--

LOCK TABLES `Paciente` WRITE;
/*!40000 ALTER TABLE `Paciente` DISABLE KEYS */;
INSERT INTO `Paciente` VALUES
('101','CARLOS','GARCIA','LOPEZ','MASCULINO','1995-03-15'),
('102','MARIA','HERNANDEZ','MARTINEZ','FEMENINO','1988-07-22'),
('103','JOSE','GONZALEZ','PEREZ','MASCULINO','1992-11-08'),
('104','ANA','RODRIGUEZ','SANCHEZ','FEMENINO','1998-05-30'),
('105','LUIS','FERNANDEZ','RAMIREZ','MASCULINO','1985-09-12'),
('106','LAURA','MARTINEZ','FLORES','FEMENINO','2000-02-18'),
('107','MIGUEL','LOPEZ','TORRES','MASCULINO','1993-06-25'),
('108','SOFIA','PEREZ','RIVERA','FEMENINO','1997-12-03'),
('109','JORGE','SANCHEZ','GOMEZ','MASCULINO','1990-04-17'),
('110','DIANA','RAMIREZ','DIAZ','FEMENINO','1996-08-09'),
('111','RICARDO','FLORES','MORALES','MASCULINO','1987-10-21'),
('112','PATRICIA','TORRES','CRUZ','FEMENINO','1999-01-14'),
('113','FERNANDO','GOMEZ','ORTIZ','MASCULINO','1994-07-06'),
('114','ELENA','DIAZ','GUTIERREZ','FEMENINO','1991-03-28'),
('115','ROBERTO','MORALES','CHAVEZ','MASCULINO','1989-11-19'),
('116','CLAUDIA','CRUZ','HERRERA','FEMENINO','2002-05-07'),
('117','ANTONIO','ORTIZ','MENDOZA','MASCULINO','1986-09-23'),
('118','GABRIELA','GUTIERREZ','VARGAS','FEMENINO','1995-12-11'),
('119','DANIEL','CHAVEZ','CASTILLO','MASCULINO','1998-02-04'),
('120','VERONICA','HERRERA','REYES','FEMENINO','1993-08-16');
/*!40000 ALTER TABLE `Paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Perfil`
--

DROP TABLE IF EXISTS `Perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Perfil`
--

LOCK TABLES `Perfil` WRITE;
/*!40000 ALTER TABLE `Perfil` DISABLE KEYS */;
INSERT INTO `Perfil` VALUES
(0,'PEPC000000',1,0),
(0,'PEPC000000',4,0),
(0,'PEPC000000',5,0),
(0,'PEPC000000',6,0),
(1,'LIIM',1,0),
(1,'LIIM',2,0),
(1,'LIIM',3,0),
(1,'LIIM',4,0),
(1,'LIIM',5,0),
(1,'LIIM',6,0),
(1,'LIIM',7,0),
(2,'ROJP000000',2,0),
(3,'MEDICO',3,0),
(3,'MEDICO',4,0),
(11,'RecepcionistaA1',2,0),
(12,'RecepcionistaA2',2,0),
(13,'RecepcionistaA3',2,0),
(14,'RecepcionistaA4',6,0),
(101,'MedicoRX',3,0),
(102,'MedicoRM',3,0),
(103,'MedicoTC',3,0),
(104,'MedicoMN',3,0);
/*!40000 ALTER TABLE `Perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ProtocoloEstudio`
--

DROP TABLE IF EXISTS `ProtocoloEstudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProtocoloEstudio` (
  `idProtocolo` int(11) NOT NULL AUTO_INCREMENT,
  `Estudio_idEstudio` int(11) NOT NULL,
  `Nombre` varchar(65) NOT NULL,
  `Descripcion` varchar(65) NOT NULL,
  PRIMARY KEY (`idProtocolo`),
  KEY `fk_ProtocoloEstudio_Estudio1` (`Estudio_idEstudio`),
  CONSTRAINT `fk_ProtocoloEstudio_Estudio1` FOREIGN KEY (`Estudio_idEstudio`) REFERENCES `Estudio` (`idEstudio`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RegistroEvento`
--

LOCK TABLES `RegistroEvento` WRITE;
/*!40000 ALTER TABLE `RegistroEvento` DISABLE KEYS */;
INSERT INTO `RegistroEvento` VALUES
(1,0,1764709652716,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764728047262,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764728213263,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764728942536,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764729128207,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764729208550,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764729319090,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764729339064,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764731188943,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764731810388,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764831148038,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764831311704,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764831545403,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764831623584,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764831710754,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764831863626,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764832009674,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764832168285,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764832744204,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764832959261,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764833914358,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764833953975,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764834136674,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764834480847,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764834685371,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764835459291,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764835504197,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764835640676,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764835711092,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764835745968,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764835859923,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764836090222,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764836437223,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764836572646,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764836997093,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764837047243,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764837108210,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1764837328183,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764838765993,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764839069451,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764839167534,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764877911086,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764878136467,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764878310064,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1764878408373,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765140515324,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765140582018,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765141838475,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765141952303,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765142105928,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765142190396,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765142262582,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765143484530,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765144517253,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765145621162,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765145718421,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765145835610,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765145909190,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765145966526,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(1,0,1765146166541,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765149490804,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765150458230,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765151196839,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765163183428,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765165933823,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765168040560,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765169419547,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765170605734,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765170795299,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765173207744,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765173440043,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765173985763,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765174506762,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765222464681,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765222994516,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765223109466,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765223741675,'{\"usuarioId\":\"RecepcionistaA1\",\"contrasena\":\"hola\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765223791508,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765223899023,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765224094192,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765224241449,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765224513151,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765224565026,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765224945497,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765225717370,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1765226009324,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"127.0.0.1\"}'),
(1,0,1773610326362,'{\"usuarioId\":\"LIIM\",\"contrasena\":\"holaMundo\",\"ipAddress\":\"0:0:0:0:0:0:0:1\"}'),
(5,1,1764728219839,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(5,1,1764729135245,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(5,1,1764832171309,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(5,1,1764836580365,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(5,1,1765144519185,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(5,1,1765224946977,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(5,1,1773610332881,'{\"Area\":\"Rayos X\",\"NumEmpleado\":1,\"CURP\":\"LIIM\"}'),
(12,7,1764728053251,'{\"SesionActiva\":{\"horaInicio\":1764728047262,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764728950072,'{\"SesionActiva\":{\"horaInicio\":1764728942536,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764729145886,'{\"SesionActiva\":{\"horaInicio\":1764729128207,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764729341734,'{\"SesionActiva\":{\"horaInicio\":1764729339064,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764731197645,'{\"SesionActiva\":{\"horaInicio\":1764731188943,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764731811388,'{\"SesionActiva\":{\"horaInicio\":1764731810388,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764732244771,'{\"SesionActiva\":{\"horaInicio\":1764731810388,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764732255334,'{\"SesionActiva\":{\"horaInicio\":1764731810388,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764831152236,'{\"SesionActiva\":{\"horaInicio\":1764831148038,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831164392,'{\"SesionActiva\":{\"horaInicio\":1764831148038,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831358615,'{\"SesionActiva\":{\"horaInicio\":1764831148038,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831553324,'{\"SesionActiva\":{\"horaInicio\":1764831545403,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831625866,'{\"SesionActiva\":{\"horaInicio\":1764831623584,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831713031,'{\"SesionActiva\":{\"horaInicio\":1764831710754,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831803008,'{\"SesionActiva\":{\"horaInicio\":1764831710754,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764831865699,'{\"SesionActiva\":{\"horaInicio\":1764831863626,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764832011711,'{\"SesionActiva\":{\"horaInicio\":1764832009674,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764832221509,'{\"SesionActiva\":{\"horaInicio\":1764832168285,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764832747840,'{\"SesionActiva\":{\"horaInicio\":1764832744204,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764832963875,'{\"SesionActiva\":{\"horaInicio\":1764832959261,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764833916605,'{\"SesionActiva\":{\"horaInicio\":1764833914358,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764833955930,'{\"SesionActiva\":{\"horaInicio\":1764833953975,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764834139029,'{\"SesionActiva\":{\"horaInicio\":1764834136674,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764834298525,'{\"SesionActiva\":{\"horaInicio\":1764834136674,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764834485320,'{\"SesionActiva\":{\"horaInicio\":1764834480847,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764834689905,'{\"SesionActiva\":{\"horaInicio\":1764834685371,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764835461652,'{\"SesionActiva\":{\"horaInicio\":1764835459291,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764835508383,'{\"SesionActiva\":{\"horaInicio\":1764835504197,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764835643049,'{\"SesionActiva\":{\"horaInicio\":1764835640676,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764835713190,'{\"SesionActiva\":{\"horaInicio\":1764835711092,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764835748709,'{\"SesionActiva\":{\"horaInicio\":1764835745968,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764835863160,'{\"SesionActiva\":{\"horaInicio\":1764835859923,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764836093745,'{\"SesionActiva\":{\"horaInicio\":1764836090222,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764836121661,'{\"SesionActiva\":{\"horaInicio\":1764836090222,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764836444855,'{\"SesionActiva\":{\"horaInicio\":1764836437223,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764836580944,'{\"SesionActiva\":{\"horaInicio\":1764836572646,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764837004399,'{\"SesionActiva\":{\"horaInicio\":1764836997093,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764837111685,'{\"SesionActiva\":{\"horaInicio\":1764837108210,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764837330841,'{\"SesionActiva\":{\"horaInicio\":1764837328183,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1764838768850,'{\"SesionActiva\":{\"horaInicio\":1764838765993,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764839071719,'{\"SesionActiva\":{\"horaInicio\":1764839069451,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1764839170940,'{\"SesionActiva\":{\"horaInicio\":1764839167534,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765140518942,'{\"SesionActiva\":{\"horaInicio\":1765140515324,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765140587875,'{\"SesionActiva\":{\"horaInicio\":1765140582018,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765141841912,'{\"SesionActiva\":{\"horaInicio\":1765141838475,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765141954798,'{\"SesionActiva\":{\"horaInicio\":1765141952303,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765142107948,'{\"SesionActiva\":{\"horaInicio\":1765142105928,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765142192356,'{\"SesionActiva\":{\"horaInicio\":1765142190396,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765142272395,'{\"SesionActiva\":{\"horaInicio\":1765142262582,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765142348211,'{\"SesionActiva\":{\"horaInicio\":1765142262582,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765143594334,'{\"SesionActiva\":{\"horaInicio\":1765143484530,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765144520688,'{\"SesionActiva\":{\"horaInicio\":1765144517253,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765145624169,'{\"SesionActiva\":{\"horaInicio\":1765145621162,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765145720654,'{\"SesionActiva\":{\"horaInicio\":1765145718421,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765145837319,'{\"SesionActiva\":{\"horaInicio\":1765145835610,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765145910558,'{\"SesionActiva\":{\"horaInicio\":1765145909190,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765145968204,'{\"SesionActiva\":{\"horaInicio\":1765145966526,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765146167901,'{\"SesionActiva\":{\"horaInicio\":1765146166541,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765149527756,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765149592003,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765149667036,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765149715382,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765149743609,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765149951862,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765150359984,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765150385986,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765150390392,'{\"SesionActiva\":{\"horaInicio\":1765149490804,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765150460424,'{\"SesionActiva\":{\"horaInicio\":1765150458230,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765151199777,'{\"SesionActiva\":{\"horaInicio\":1765151196839,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765163184948,'{\"SesionActiva\":{\"horaInicio\":1765163183428,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765163484631,'{\"SesionActiva\":{\"horaInicio\":1765163183428,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765165936052,'{\"SesionActiva\":{\"horaInicio\":1765165933823,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765166122504,'{\"SesionActiva\":{\"horaInicio\":1765165933823,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765166418989,'{\"SesionActiva\":{\"horaInicio\":1765165933823,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765166456458,'{\"SesionActiva\":{\"horaInicio\":1765165933823,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765166518343,'{\"SesionActiva\":{\"horaInicio\":1765165933823,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765166616382,'{\"SesionActiva\":{\"horaInicio\":1765165933823,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765168041765,'{\"SesionActiva\":{\"horaInicio\":1765168040560,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765168106918,'{\"SesionActiva\":{\"horaInicio\":1765168040560,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765168146380,'{\"SesionActiva\":{\"horaInicio\":1765168040560,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765168178084,'{\"SesionActiva\":{\"horaInicio\":1765168040560,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765168247904,'{\"SesionActiva\":{\"horaInicio\":1765168040560,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765168399150,'{\"SesionActiva\":{\"horaInicio\":1765168040560,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765170612742,'{\"SesionActiva\":{\"horaInicio\":1765170605734,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765170798181,'{\"SesionActiva\":{\"horaInicio\":1765170795299,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765171214627,'{\"SesionActiva\":{\"horaInicio\":1765170795299,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765173210041,'{\"SesionActiva\":{\"horaInicio\":1765173207744,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765173213105,'{\"SesionActiva\":{\"horaInicio\":1765173207744,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765173219893,'{\"SesionActiva\":{\"horaInicio\":1765173207744,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765173444071,'{\"SesionActiva\":{\"horaInicio\":1765173440043,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173453711,'{\"SesionActiva\":{\"horaInicio\":1765173440043,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173498333,'{\"SesionActiva\":{\"horaInicio\":1765173440043,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173520453,'{\"SesionActiva\":{\"horaInicio\":1765173440043,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173531385,'{\"SesionActiva\":{\"horaInicio\":1765173440043,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173815273,'{\"SesionActiva\":{\"horaInicio\":1765173440043,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173987509,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173993186,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765173997746,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174001271,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174005664,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174009733,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174017825,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174029493,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174036339,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174039577,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174059626,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174125634,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174130683,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174134253,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174165886,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174277272,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174282505,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174285108,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174287303,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174293103,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174350763,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174437587,'{\"SesionActiva\":{\"horaInicio\":1765173985763,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765174508797,'{\"SesionActiva\":{\"horaInicio\":1765174506762,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765222466555,'{\"SesionActiva\":{\"horaInicio\":1765222464681,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(12,7,1765223005146,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223010530,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223012378,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223016415,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223019237,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223021058,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223025324,'{\"SesionActiva\":{\"horaInicio\":1765222994516,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223113085,'{\"SesionActiva\":{\"horaInicio\":1765223109466,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765223900417,'{\"SesionActiva\":{\"horaInicio\":1765223899023,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224096814,'{\"SesionActiva\":{\"horaInicio\":1765224094192,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224518078,'{\"SesionActiva\":{\"horaInicio\":1765224513151,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224544052,'{\"SesionActiva\":{\"horaInicio\":1765224513151,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224549910,'{\"SesionActiva\":{\"horaInicio\":1765224513151,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224558422,'{\"SesionActiva\":{\"horaInicio\":1765224513151,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224566565,'{\"SesionActiva\":{\"horaInicio\":1765224565026,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765224948104,'{\"SesionActiva\":{\"horaInicio\":1765224945497,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765225035590,'{\"SesionActiva\":{\"horaInicio\":1765224945497,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765225165758,'{\"SesionActiva\":{\"horaInicio\":1765224945497,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765225718969,'{\"SesionActiva\":{\"horaInicio\":1765225717370,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765225822942,'{\"SesionActiva\":{\"horaInicio\":1765225717370,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765225886347,'{\"SesionActiva\":{\"horaInicio\":1765225717370,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765226023254,'{\"SesionActiva\":{\"horaInicio\":1765226009324,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765226304325,'{\"SesionActiva\":{\"horaInicio\":1765226009324,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1765226861493,'{\"SesionActiva\":{\"horaInicio\":1765226009324,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(12,7,1773610334641,'{\"SesionActiva\":{\"horaInicio\":1773610326362,\"usuarioCURP\":\"LIIM\",\"usuarioNumEmpleado\":1,\"aplicacionID\":0}}'),
(13,8,1764831323839,'{\"dto\":{\"eqNoSerie\":\"EquipoA1\",\"idestudio\":1,\"fechacontrolpk\":1699981200000,\"fechacontrol\":\"2023-11-14T17:00:00.000+00:00\",\"idPaciente\":\"102\",\"medNumEmpleado\":102,\"medCurp\":\"MedicoRM\"},\"SesionActiva\":{\"horaInicio\":1764831311704,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(14,8,1764831332376,'{\"dto\":{\"idpaciente\":\"102\",\"idestudio\":1,\"fechacontrolpk\":1699981200000,\"fechacontrol\":\"2023-11-14T17:00:00.000+00:00\",\"estado\":\"Programado\",\"cerrado\":false,\"observaciones\":\"Prueba 27Nov2025\",\"eqNoSerie\":\"EquipoA1\",\"medNumEmpleado\":102,\"medCurp\":\"MedicoRM\"},\"SesionActiva\":{\"horaInicio\":1764831311704,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}'),
(1014,8,1764878148746,'{\"dto\":{\"idpaciente\":\"102\",\"idestudio\":1,\"fechacontrolpk\":1699981200000,\"fechacontrol\":\"2023-11-14T17:00:00.000+00:00\",\"estado\":\"Programado\",\"cerrado\":false,\"observaciones\":\"Prueba 27Nov2025\",\"eqNoSerie\":\"EquipoA1\",\"medNumEmpleado\":102,\"medCurp\":\"MedicoRM\"},\"SesionActiva\":{\"horaInicio\":1764878136467,\"usuarioCURP\":\"RecepcionistaA1\",\"usuarioNumEmpleado\":11,\"aplicacionID\":0}}');
/*!40000 ALTER TABLE `RegistroEvento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rol`
--

DROP TABLE IF EXISTS `Rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rol` (
  `idRol` int(11) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
(6,'CoordinadordelServicio','Coordinador del Servicio'),
(7,'TecnicoRadiologo','Técnico Radiólogo');
/*!40000 ALTER TABLE `Rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RolAplicacion`
--

DROP TABLE IF EXISTS `RolAplicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RolAplicacion` (
  `Aplicacion_idAplicacion` int(11) NOT NULL,
  `Rol_idRol` int(11) NOT NULL,
  PRIMARY KEY (`Aplicacion_idAplicacion`,`Rol_idRol`),
  KEY `fk_RolAplicacion_Rol1_idx` (`Rol_idRol`),
  CONSTRAINT `fk_RolAplicacion_Aplicacion1` FOREIGN KEY (`Aplicacion_idAplicacion`) REFERENCES `Aplicacion` (`idAplicacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_RolAplicacion_Rol1` FOREIGN KEY (`Rol_idRol`) REFERENCES `Rol` (`idRol`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
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
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sesion`
--

LOCK TABLES `Sesion` WRITE;
/*!40000 ALTER TABLE `Sesion` DISABLE KEYS */;
INSERT INTO `Sesion` VALUES
(1763623748124,1763623775461,'0:0:0:0:0:0:0:1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1763624157316,1763624256724,'0:0:0:0:0:0:0:1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1763624278141,1763624295710,'0:0:0:0:0:0:0:1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1763624310935,1763624340073,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763624349984,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1763650775714,1763651127048,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763651157663,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1763666326616,1763666513860,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763666518153,1763667488023,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1763667637150,1763667697375,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763667787696,1763668027338,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM',0,'Admin','LIIM'),
(1763668894230,1763669045264,'0:0:0:0:0:0:0:1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1763669053181,1763669112266,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763669124660,1763669192639,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763669203501,1763669215156,'0:0:0:0:0:0:0:1','Normal',2,'ROJP000000',0,'Recepcionista','MisaelRJ'),
(1763669226121,1763669245046,'0:0:0:0:0:0:0:1','Normal',2,'ROJP000000',0,'Recepcionista','MisaelRJ'),
(1763669262896,1763669277343,'0:0:0:0:0:0:0:1','Normal',2,'ROJP000000',0,'Recepcionista','MisaelRJ'),
(1763669291346,1763669329117,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763670322807,1763671479356,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1763672858474,1763672974563,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763698091682,1763698129885,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763698155854,1763698248227,'0:0:0:0:0:0:0:1','Normal',0,'PEPC000000',0,'Admin','carlos'),
(1763698385348,1763701968679,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1763701977397,1763702956479,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1763703286353,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1763757346405,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1763954298950,1763955301654,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM',0,'Admin','LIIM'),
(1763955392939,1763956082554,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM',0,'Admin','LIIM'),
(1763956272798,1763956855944,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM',0,'Admin','LIIM'),
(1763957099924,1763957503890,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM',0,'Admin','LIIM'),
(1763957528852,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1763965804877,1763966629334,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1763966638087,NULL,'127.0.0.1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1763966726292,1763966736009,'0:0:0:0:0:0:0:1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1763966914883,1763966919697,'0:0:0:0:0:0:0:1','NormalPostman',1,'LIIM',0,'Admin','LIIM'),
(1763966959868,1763967197654,'0:0:0:0:0:0:0:1','NormalPostman',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1763967370821,1763968656117,'0:0:0:0:0:0:0:1','Inactividad',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1763968776923,1763968970041,'0:0:0:0:0:0:0:1','NormalPostman',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1763968984917,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1763968989600,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1764015767737,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764123914863,1764124007383,'0:0:0:0:0:0:0:1','NormalPostman',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764136631892,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764277121053,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764278162977,1764278180565,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764278189565,1764278377060,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764585952401,1764586016117,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764586033232,1764586371003,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764586392904,1764586597029,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764586610266,1764586702608,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764586716820,1764587316003,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764588044231,NULL,'127.0.0.1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1764588511546,1764588545501,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764588558797,1764588662231,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764588684221,1764588692092,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764588791937,1764588806796,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764594374605,1764594397334,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764594508952,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1764595592000,1764595842077,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764595855587,1764595920345,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764595945314,1764596023942,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596038691,1764596213806,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596239405,1764596252879,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596345469,1764596367645,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596383902,1764596390181,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596438794,1764596560964,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596582880,1764596757740,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596772920,1764596860785,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764596878428,1764597060572,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764597075627,1764597087366,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764597207588,1764597217542,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764684038176,1764684131880,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764684160091,1764684333185,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764684359766,1764684973020,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764685415383,1764685486339,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764685503940,1764685534415,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764685586757,1764685673388,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764685900359,1764685932173,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764686264237,1764687426017,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764708385726,1764708422034,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764708444060,NULL,'127.0.0.1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1764708588335,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764709652716,1764710258040,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764728047262,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1764728213263,1764728819020,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764728942536,1764728962497,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764729128207,1764729193125,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764729208550,1764729262371,'0:0:0:0:0:0:0:1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764729319090,1764729334231,'0:0:0:0:0:0:0:1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764729339064,1764729941024,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764731188943,1764731797013,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764731810388,1764732484646,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764831148038,1764831387695,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764831311704,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764831545403,1764831606033,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764831623584,1764831694321,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764831710754,1764831846945,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764831863626,1764831904898,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764832009674,1764832043244,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764832168285,1764832717310,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764832744204,1764832939551,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764832959261,1764833563022,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764833914358,1764833938679,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764833953975,1764834094781,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764834136674,1764834456847,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764834480847,1764834666810,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764834685371,1764835289021,'0:0:0:0:0:0:0:1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1764835459291,1764835485242,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764835504197,1764835619682,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764835640676,1764835692238,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764835711092,1764835723552,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764835745968,1764835772859,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764835859923,1764836052128,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764836090222,1764836412907,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764836437223,1764836508491,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764836572646,1764836974500,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764836997093,1764837022665,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764837047243,1764837081709,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764837108210,1764837310346,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764837328183,1764837930048,'0:0:0:0:0:0:0:1','Inactividad',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764838765993,1764838911839,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764839069451,1764839143733,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1764839167534,NULL,'0:0:0:0:0:0:0:1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1764877911086,1764878029554,'0:0:0:0:0:0:0:1','NormalPostman',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764878136467,1764878277019,'0:0:0:0:0:0:0:1','NormalPostman',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764878310064,1764878349786,'0:0:0:0:0:0:0:1','NormalPostman',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1764878408373,NULL,'0:0:0:0:0:0:0:1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765140515324,1765140562861,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765140582018,1765141267021,'127.0.0.1','Inactividad',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765141838475,1765141931382,'0:0:0:0:0:0:0:1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765141952303,1765141969039,'0:0:0:0:0:0:0:1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765142105928,1765142127551,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765142190396,1765142214029,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765142262582,1765143066023,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1765143484530,1765144194015,'127.0.0.1','Inactividad',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765144517253,1765145422218,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765145621162,1765145702863,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765145718421,1765145731513,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765145835610,1765145844612,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765145909190,1765145941140,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Recepcionista','LIIM'),
(1765145966526,1765146020400,'0:0:0:0:0:0:0:1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765146166541,1765146783016,'127.0.0.1','Inactividad',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765149490804,1765150439119,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765150458230,1765151063015,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1765151196839,1765151800024,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1765163183428,1765164152483,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1765165933823,1765167217024,'127.0.0.1','Inactividad',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765168040560,1765169001008,'127.0.0.1','Inactividad',1,'LIIM',0,'Recepcionista','LIIM'),
(1765169419547,1765170119017,'127.0.0.1','Inactividad',1,'LIIM',0,'Recepcionista','LIIM'),
(1765170605734,1765170772695,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765170795299,NULL,'127.0.0.1',NULL,11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765173207744,1765173314119,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765173440043,1765173960095,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765173985763,1765174439992,'127.0.0.1','Normal',1,'LIIM',0,'Recepcionista','LIIM'),
(1765174506762,1765175109108,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1765222464681,1765222982846,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765222994516,1765223091893,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765223109466,1765223393196,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765223741675,1765223783087,'127.0.0.1','Normal',11,'RecepcionistaA1',0,'Recepcionista','RecepcionistaA1'),
(1765223791508,1765223879609,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765223899023,1765224076435,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765224094192,1765224223886,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765224241449,1765224446290,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765224513151,1765224560179,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765224565026,NULL,'127.0.0.1',NULL,1,'LIIM',0,'Recepcionista','LIIM'),
(1765224945497,NULL,'127.0.0.1',NULL,1,'LIIM',0,'Admin','LIIM'),
(1765225717370,1765225975161,'127.0.0.1','Normal',1,'LIIM',0,'Admin','LIIM'),
(1765226009324,1765227472018,'127.0.0.1','Inactividad',1,'LIIM',0,'Admin','LIIM'),
(1773610326362,1773610338196,'0:0:0:0:0:0:0:1','Normal',1,'LIIM',0,'Admin','LIIM');
/*!40000 ALTER TABLE `Sesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SolicitudDeEstudio`
--

DROP TABLE IF EXISTS `SolicitudDeEstudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SolicitudDeEstudio`
--

LOCK TABLES `SolicitudDeEstudio` WRITE;
/*!40000 ALTER TABLE `SolicitudDeEstudio` DISABLE KEYS */;
INSERT INTO `SolicitudDeEstudio` VALUES
('101',101,'MedicoRX',1699977600000,'2025-12-04 06:54:00','URGENCIAS','2023-11-21 16:00:00','FRACTURA DE RADIO DISTAL','PACIENTE REFIERE CAIDA, SE SOLICITA RADIOGRAFIA','SOLICITADO'),
('102',102,'MedicoRM',1699981200000,'2025-12-04 06:54:00','NEUROLOGIA','2023-11-28 15:00:00','SOSPECHA DE ESCLEROSIS MULTIPLE','SE REQUIERE RESONANCIA MAGNETICA CEREBRAL','Programado'),
('103',103,'MedicoTC',1699984800000,'2023-11-14 18:00:00','ONCOLOGIA','2023-11-22 20:00:00','NODULO PULMONAR DETECTADO','TOMOGRAFIA COMPUTARIZADA DE TORAX PARA EVALUACION','SOLICITADO'),
('104',104,'MedicoMN',1699988400000,'2023-11-14 19:00:00','CARDIOLOGIA','2023-11-30 14:00:00','ENFERMEDAD ARTERIAL CORONARIA','GAMMAGRAFIA CARDIACA SOLICITADA','SOLICITADO'),
('105',101,'MedicoRX',1699992000000,'2023-11-14 20:00:00','TRAUMATOLOGIA','2023-11-23 17:00:00','ESGUINCE DE TOBILLO GRADO II','RADIOGRAFIA PARA DESCARTAR FRACTURA','SOLICITADO'),
('106',102,'MedicoRM',1699995600000,'2023-11-14 21:00:00','GINECOLOGIA','2023-11-29 16:00:00','MIOMATOSIS UTERINA','RESONANCIA MAGNETICA PELVICA INDICADA','SOLICITADO'),
('107',103,'MedicoTC',1699999200000,'2023-11-14 22:00:00','GASTROENTEROLOGIA','2023-11-24 19:00:00','SOSPECHA DE PANCREATITIS CRONICA','TC ABDOMINAL CON CONTRASTE','SOLICITADO'),
('108',104,'MedicoMN',1700002800000,'2023-11-14 23:00:00','ENDOCRINOLOGIA','2023-12-01 15:00:00','HIPERTIROIDISMO','GAMMAGRAFIA TIROIDEA PROGRAMADA','SOLICITADO'),
('109',101,'MedicoRX',1700006400000,'2023-11-15 00:00:00','ORTOPEDIA','2023-11-25 18:00:00','HERNIA DISCAL L4-L5','RADIOGRAFIA DE COLUMNA LUMBAR','SOLICITADO'),
('110',102,'MedicoRM',1700010000000,'2023-11-15 15:00:00','NEUROCIRUGIA','2023-11-27 21:00:00','TUMOR CEREBRAL','RM CEREBRAL CON Y SIN CONTRASTE','SOLICITADO'),
('111',103,'MedicoTC',1700013600000,'2023-11-15 16:00:00','NEUMOLOGIA','2023-11-26 17:00:00','ENFISEMA PULMONAR','TC DE TORAX DE ALTA RESOLUCION','SOLICITADO'),
('112',104,'MedicoMN',1700017200000,'2023-11-15 17:00:00','NEFROLOGIA','2023-12-02 16:00:00','INSUFICIENCIA RENAL CRONICA','GAMMAGRAFIA RENAL DINAMICA','SOLICITADO'),
('113',101,'MedicoRX',1700020800000,'2023-11-15 18:00:00','URGENCIAS','2023-11-28 20:00:00','TRAUMATISMO CRANEOENCEFALICO LEVE','RADIOGRAFIA DE CRANEO SIMPLE','SOLICITADO'),
('114',102,'MedicoRM',1700024400000,'2023-11-15 19:00:00','REUMATOLOGIA','2023-11-30 22:00:00','ARTRITIS REUMATOIDE','RM DE MANOS Y MUÑECAS','SOLICITADO'),
('115',103,'MedicoTC',1700028000000,'2023-11-15 20:00:00','UROLOGIA','2023-12-03 15:00:00','LITIASIS RENAL MULTIPLE','TC ABDOMINAL SIN CONTRASTE','SOLICITADO'),
('116',104,'MedicoMN',1700031600000,'2023-11-15 21:00:00','ONCOLOGIA','2023-12-04 17:00:00','LINFOMA NO HODGKIN','PET-CT PARA ESTADIFICACION','SOLICITADO'),
('117',101,'MedicoRX',1700035200000,'2023-11-15 22:00:00','TRAUMATOLOGIA','2023-11-29 19:00:00','LUXACION DE HOMBRO','RADIOGRAFIA DE HOMBRO AP Y LATERAL','SOLICITADO'),
('118',102,'MedicoRM',1700038800000,'2023-11-15 23:00:00','CARDIOLOGIA','2023-12-05 16:00:00','MIOCARDIOPATIA DILATADA','RM CARDIACA CON GADOLINIO','SOLICITADO'),
('119',103,'MedicoTC',1700042400000,'2023-11-16 00:00:00','OTORRINOLARINGOLOGIA','2023-12-01 20:00:00','SINUSITIS CRONICA','TC DE SENOS PARANASALES','SOLICITADO'),
('120',104,'MedicoMN',1700046000000,'2023-11-16 15:00:00','HEMATOLOGIA','2023-12-06 14:00:00','ANEMIA APLASICA','GAMMAGRAFIA OSEA CORPORAL TOTAL','SOLICITADO');
/*!40000 ALTER TABLE `SolicitudDeEstudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `NumEmpleado` int(11) NOT NULL,
  `CURP` varchar(45) NOT NULL,
  `Area_idArea` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `ApellidoPaterno` varchar(45) NOT NULL,
  `ApellidoMaterno` varchar(45) NOT NULL,
  `CorreoElectronico` varchar(45) NOT NULL,
  PRIMARY KEY (`NumEmpleado`,`CURP`),
  KEY `fk_Usuario_Area1_idx` (`Area_idArea`),
  CONSTRAINT `fk_Usuario_Area1` FOREIGN KEY (`Area_idArea`) REFERENCES `AreaDeServicio` (`idArea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES
(0,'PEPC000000',5,'Carlos Alberto','Pérez','Pérez','carlos@gmail.com'),
(1,'LIIM',1,'Laboratorio','Informatica','Medica','LIIM@gmail.com'),
(2,'ROJP000000',1,'Misael','Rosriguez','Jimenez','Misael@gmail.com'),
(3,'MEDICO',2,'Med','Med','Med','med@gmail.com'),
(11,'RecepcionistaA1',1,'RA1','RB1','RC1','RecepcionistaA1@gmail.com'),
(12,'RecepcionistaA2',2,'RA2','RB2','RC2','RecepcionistaA2@gmail.com'),
(13,'RecepcionistaA3',3,'RA3','RB3','RC3','RecepcionistaA3@gmail.com'),
(14,'RecepcionistaA4',4,'RA4','RB4','RC4','RecepcionistaA4'),
(101,'MedicoRX',1,'A1','B1','C1','MedicoRX@gmail.com'),
(102,'MedicoRM',2,'A2','B2','C2','MedicoRM@gmail.com'),
(103,'MedicoTC',3,'A3','B3','C3','MedicoTC@gmail.com'),
(104,'MedicoMN',4,'A4','B4','C4','MedicoMN@gmail.com');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-03-15 16:18:44
