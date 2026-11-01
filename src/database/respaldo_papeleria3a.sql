/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: papeleria3a
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB-log

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
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `claveCargo` int(11) NOT NULL AUTO_INCREMENT,
  `cargo` varchar(20) DEFAULT NULL,
  `salario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`claveCargo`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES
(41,'Gerente',15000.00),
(42,'Cajero',8000.00),
(43,'Auxiliar',7000.00),
(44,'Almacenista',7500.00),
(45,'Vendedor',9000.00),
(46,'Supervisor',10000.00),
(47,'Recepcionista',8500.00),
(48,'Diseñador',12000.00),
(49,'Contador',14000.00),
(50,'Marketing',11000.00),
(51,'Logística',9500.00),
(52,'Compras',9200.00),
(53,'Atención Cliente',8800.00),
(54,'Seguridad',8000.00),
(55,'Gerente Tienda',16000.00),
(56,'Técnico',9500.00),
(57,'Soporte TI',10500.00),
(58,'Jefe Almacén',13000.00),
(59,'Asist. Admin.',8700.00),
(60,'Limpieza',7000.00);
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `IDcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES
(1,'Papelería'),
(2,'Oficina'),
(3,'Escolar'),
(4,'Arte'),
(5,'Manualidades'),
(6,'Dibujo Técnico'),
(7,'Rotulación'),
(8,'Decoración'),
(9,'Impresión'),
(10,'Fotografía'),
(11,'Tecnología'),
(12,'Higiene'),
(13,'Mobiliario'),
(14,'Electrónica'),
(15,'Didáctico'),
(16,'Juguetes'),
(17,'Herramientas'),
(18,'Accesorios'),
(19,'Libros'),
(20,'Revistas');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `segundoNombre` varchar(50) DEFAULT NULL,
  `apellidoP` varchar(20) DEFAULT NULL,
  `apellidoM` varchar(20) DEFAULT NULL,
  `numeroTelefonico` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES
(1,'Juan','Carlos','Pérez','Gómez',5551234567),
(2,'Ana','María','López','Hernández',5559876543),
(3,'Pedro',NULL,'Martínez','Ruiz',5553456789),
(4,'María','Luisa','García','Ramírez',5552345678),
(5,'Luis',NULL,'Hernández','Morales',5554567890),
(6,'Carmen','Elena','Vargas','Ortega',5556789012),
(7,'José',NULL,'Díaz','Sánchez',5557890123),
(8,'Laura',NULL,'Fernández','Jiménez',5558901234),
(9,'Ricardo',NULL,'Castro','Medina',5559012345),
(10,'Sofía',NULL,'Reyes','Núñez',5550123456),
(11,'Andrea','Isabel','Ríos','Delgado',5551239876),
(12,'Mario',NULL,'Torres','Estrada',5559876123),
(13,'Diana',NULL,'Ramírez','Cortés',5554321098),
(14,'Arturo',NULL,'González','Silva',5558901234),
(15,'Victoria',NULL,'Navarro','Campos',5556781234),
(16,'Alonso',NULL,'Guerrero','Vega',5553210987),
(17,'Paola',NULL,'León','Cruz',5557654321),
(18,'Roberto',NULL,'Rivera','Flores',5552340987),
(19,'Adriana',NULL,'Jiménez','Muñoz',5556543210),
(20,'Miguel',NULL,'Salas','Galindo',5558765432),
(21,'erahin','pacheco','luna','luna',975632675);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `detallepedido`
--

DROP TABLE IF EXISTS `detallepedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallepedido` (
  `numOrden` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) DEFAULT NULL,
  `importe` decimal(8,2) DEFAULT NULL,
  `precioTotal` decimal(8,2) DEFAULT NULL,
  `codigoBarra` varchar(32) DEFAULT NULL,
  `numPedido` int(11) DEFAULT NULL,
  PRIMARY KEY (`numOrden`),
  KEY `fkProducto2` (`codigoBarra`),
  KEY `fkPedido` (`numPedido`),
  CONSTRAINT `fkPedido` FOREIGN KEY (`numPedido`) REFERENCES `pedido` (`numPedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkProducto2` FOREIGN KEY (`codigoBarra`) REFERENCES `producto` (`codigoBarra`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallepedido`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `detallepedido` WRITE;
/*!40000 ALTER TABLE `detallepedido` DISABLE KEYS */;
INSERT INTO `detallepedido` VALUES
(1,3,20.00,60.00,'750000000001',1),
(2,2,50.00,100.00,'750000000002',2),
(3,4,25.00,100.00,'750000000003',3),
(4,1,30.00,30.00,'750000000004',4),
(5,5,15.00,75.00,'750000000005',5),
(6,2,70.00,140.00,'750000000006',6),
(7,3,40.00,120.00,'750000000007',7),
(8,1,120.00,120.00,'750000000008',8),
(9,6,10.00,60.00,'750000000009',9),
(10,2,500.00,1000.00,'750000000010',10),
(11,3,30.00,90.00,'750000000011',11),
(12,1,250.00,250.00,'750000000012',12),
(13,1,12.00,12.00,'750000000013',13),
(14,2,20.00,40.00,'750000000014',14),
(15,4,15.00,60.00,'750000000015',15),
(16,2,80.00,160.00,'750000000016',16),
(17,5,10.00,50.00,'750000000017',17),
(18,3,60.00,180.00,'750000000018',18),
(19,4,35.00,140.00,'750000000019',19),
(20,1,75.00,75.00,'750000000020',20);
/*!40000 ALTER TABLE `detallepedido` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `direccion`
--

DROP TABLE IF EXISTS `direccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `direccion` (
  `idDireccion` int(11) NOT NULL AUTO_INCREMENT,
  `calle` varchar(100) DEFAULT NULL,
  `numero` smallint(6) DEFAULT NULL,
  `codigoPostal` int(11) DEFAULT NULL,
  `localidad` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idDireccion`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `direccion`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `direccion` WRITE;
/*!40000 ALTER TABLE `direccion` DISABLE KEYS */;
INSERT INTO `direccion` VALUES
(1,'Av. Reforma',123,68000,'Oaxaca Centro'),
(2,'Calle Hidalgo',45,68100,'Xochimilco'),
(3,'Callejón del Arte',7,68020,'Jalatlaco'),
(4,'Calle Independencia',56,68030,'Oaxaca Centro'),
(5,'Av. Juárez',89,68110,'San Felipe del Agua'),
(6,'Calle Morelos',10,68050,'Jalatlaco'),
(7,'Boulevard Guadalupe',25,68200,'Santa Lucía'),
(8,'Calle Bustamante',33,68150,'Oaxaca Centro'),
(9,'Privada del Sol',4,68120,'Reforma'),
(10,'Calle Porfirio Díaz',15,68140,'Centro'),
(11,'Calle Madero',22,68130,'San Sebastián'),
(12,'Calle 5 de Mayo',18,68160,'Centro'),
(13,'Calle Aldama',9,68010,'San Felipe'),
(14,'Calle Matamoros',30,68210,'Xochimilco'),
(15,'Calle Netzahualcóyotl',40,68015,'Volcanes'),
(16,'Calle Victoria',27,68025,'Oaxaca Centro'),
(17,'Calle Armenta',50,68170,'San Juanito'),
(18,'Calle Díaz Ordaz',14,68180,'La Noria'),
(19,'Calle García Vigil',8,68190,'Centro'),
(20,'Av. Universidad',100,68230,'Fovissste');
/*!40000 ALTER TABLE `direccion` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `RFC` varchar(13) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `segundoNombre` varchar(50) DEFAULT NULL,
  `apellidoP` varchar(20) DEFAULT NULL,
  `apellidoM` varchar(20) DEFAULT NULL,
  `numTelefonico` bigint(20) DEFAULT NULL,
  `idDireccion` int(11) DEFAULT NULL,
  UNIQUE KEY `RFC` (`RFC`),
  KEY `fkDireccion` (`idDireccion`),
  CONSTRAINT `fkDireccion` FOREIGN KEY (`idDireccion`) REFERENCES `direccion` (`idDireccion`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES
('EMP00000001A','Luis','Fernando','Ramírez','Pérez',5556543210,1),
('EMP00000002B','Sofía',NULL,'García','Sánchez',5554321987,2),
('EMP00000003C','María','José','Cruz','Hernández',5556789012,3),
('EMP00000004D','Carlos','Enrique','Martínez','Morales',5551234567,4),
('EMP00000005E','Ana','Luisa','Vargas','Ortega',5559876543,5),
('EMP00000006F','Pedro',NULL,'Díaz','Sánchez',5553456789,6),
('EMP00000007G','Carmen','Elena','Fernández','Jiménez',5552345678,7),
('EMP00000008H','José',NULL,'Castro','Medina',5554567890,8),
('EMP00000009I','Ricardo',NULL,'Reyes','Núñez',5556789012,9),
('EMP00000010J','Laura','María','Navarro','Campos',5558901234,10),
('EMP00000011K','Andrea',NULL,'León','Cruz',5550123456,11),
('EMP00000012L','Mario',NULL,'Rivera','Flores',5551239876,12),
('EMP00000013M','Diana','Isabel','Torres','Estrada',5559876123,13),
('EMP00000014N','Victoria',NULL,'Ramírez','Cortés',5554321098,14),
('EMP00000015O','Miguel',NULL,'González','Silva',5558901234,15),
('EMP00000016P','Adriana',NULL,'Guerrero','Vega',5556781234,16),
('EMP00000017Q','Roberto',NULL,'Jiménez','Muñoz',5553210987,17),
('EMP00000018R','Paola',NULL,'Salas','Galindo',5557654321,18),
('EMP00000019S','Arturo',NULL,'Cruz','Hernández',5552340987,19),
('EMP00000020T','Alonso',NULL,'Díaz','Sánchez',5556543210,20);
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario` (
  `idHorario` int(11) NOT NULL AUTO_INCREMENT,
  `HoraEntrada` time DEFAULT NULL,
  `HoraSalida` time DEFAULT NULL,
  `RFC` varchar(13) DEFAULT NULL,
  `claveCargo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idHorario`),
  KEY `fkempleadoH` (`RFC`),
  KEY `fkcargo` (`claveCargo`),
  CONSTRAINT `fkcargo` FOREIGN KEY (`claveCargo`) REFERENCES `cargo` (`claveCargo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkempleadoH` FOREIGN KEY (`RFC`) REFERENCES `empleado` (`RFC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES
(21,'08:00:00','16:00:00','EMP00000001A',41),
(22,'09:00:00','17:00:00','EMP00000002B',42),
(23,'10:00:00','18:00:00','EMP00000003C',43),
(24,'08:00:00','16:00:00','EMP00000004D',44),
(25,'09:00:00','17:00:00','EMP00000005E',45),
(26,'10:00:00','18:00:00','EMP00000006F',46),
(27,'08:00:00','16:00:00','EMP00000007G',47),
(28,'09:00:00','17:00:00','EMP00000008H',48),
(29,'10:00:00','18:00:00','EMP00000009I',49),
(30,'08:00:00','16:00:00','EMP00000010J',50),
(31,'09:00:00','17:00:00','EMP00000011K',51),
(32,'10:00:00','18:00:00','EMP00000012L',52),
(33,'08:00:00','16:00:00','EMP00000013M',53),
(34,'09:00:00','17:00:00','EMP00000014N',54),
(35,'10:00:00','18:00:00','EMP00000015O',55),
(36,'08:00:00','16:00:00','EMP00000016P',56),
(37,'09:00:00','17:00:00','EMP00000017Q',57),
(38,'10:00:00','18:00:00','EMP00000018R',58),
(39,'08:00:00','16:00:00','EMP00000019S',59),
(40,'09:00:00','17:00:00','EMP00000020T',60);
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `marca` (
  `IDmarca` varchar(20) NOT NULL,
  `nombreMarca` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDmarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` VALUES
('M001','Bic'),
('M002','Staedtler'),
('M003','Faber-Castell'),
('M004','Pilot'),
('M005','Paper Mate'),
('M006','Sharpie'),
('M007','Pentel'),
('M008','Canson'),
('M009','Prismacolor'),
('M010','Crayola'),
('M011','Stabilo'),
('M012','Dixon'),
('M013','Pelikan'),
('M014','Lyra'),
('M015','Tombow'),
('M016','Uniball'),
('M017','Koh-i-Noor'),
('M018','Sakura'),
('M019','Winsor & Newton'),
('M020','Derwent');
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `numPedido` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `precioTotal` decimal(10,2) DEFAULT NULL,
  `RFC` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`numPedido`),
  KEY `fkProvedores` (`RFC`),
  CONSTRAINT `fkProvedores` FOREIGN KEY (`RFC`) REFERENCES `provedores` (`RFC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES
(1,'2024-10-01',2000.00,'PROV00000001'),
(2,'2024-10-02',1500.00,'PROV00000002'),
(3,'2024-10-03',2500.00,'PROV00000003'),
(4,'2024-10-04',3000.00,'PROV00000004'),
(5,'2024-10-05',1000.00,'PROV00000005'),
(6,'2024-10-06',2200.00,'PROV00000006'),
(7,'2024-10-07',1800.00,'PROV00000007'),
(8,'2024-10-08',1700.00,'PROV00000008'),
(9,'2024-10-09',2600.00,'PROV00000009'),
(10,'2024-10-10',900.00,'PROV00000010'),
(11,'2024-10-11',2800.00,'PROV00000011'),
(12,'2024-10-12',3200.00,'PROV00000012'),
(13,'2024-10-13',4000.00,'PROV00000013'),
(14,'2024-10-14',1100.00,'PROV00000014'),
(15,'2024-10-15',900.00,'PROV00000015'),
(16,'2024-10-16',2000.00,'PROV00000016'),
(17,'2024-10-17',3300.00,'PROV00000017'),
(18,'2024-10-18',1200.00,'PROV00000018'),
(19,'2024-10-19',2700.00,'PROV00000019'),
(20,'2024-10-20',3500.00,'PROV00000020');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `codigoBarra` varchar(32) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `existencia` int(11) DEFAULT NULL,
  `IDmarca` varchar(20) DEFAULT NULL,
  `IDcategoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigoBarra`),
  KEY `fkMarca` (`IDmarca`),
  KEY `fkCategoria` (`IDcategoria`),
  CONSTRAINT `fkCategoria` FOREIGN KEY (`IDcategoria`) REFERENCES `categoria` (`IDcategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkMarca` FOREIGN KEY (`IDmarca`) REFERENCES `marca` (`IDmarca`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES
('1','lapicera mascotas2',24.00,138,'M004',5),
('101','libreta cuadros',6.00,123,'M001',3),
('106','libro cuentos de hadas',78.00,56,'M001',4),
('12111','zacapuntas',5.56,128,'M018',2),
('2','cuaderno de dibujos',45.00,16,'M005',2),
('5','rompeabeza',56.00,53,'M002',2),
('750000000001','Lápiz HB',12.50,100,'M001',3),
('750000000002','Cuaderno Profesional',35.00,50,'M002',1),
('750000000003','Marcador Permanente',25.00,75,'M003',2),
('750000000004','Regla 30cm',15.00,60,'M004',1),
('750000000005','Tijeras Escolares',30.00,40,'M005',3),
('750000000006','Pegamento en Barra',20.00,100,'M006',2),
('750000000007','Papel Bond A4',150.00,20,'M007',1),
('750000000008','Compás Metálico',60.00,30,'M008',3),
('750000000009','Borrador Grande',10.00,200,'M009',2),
('750000000010','Calculadora Científica',500.00,15,'M010',1),
('750000000011','Marcador para Pizarra',40.00,80,'M011',3),
('750000000012','Cinta Adhesiva',25.00,90,'M012',2),
('750000000013','Clips Metálicos',15.00,150,'M013',1),
('750000000014','Goma para Borrar',8.00,300,'M014',3),
('750000000015','Lapicero Azul',18.00,120,'M015',2),
('750000000016','Lapicero Negro',18.00,110,'M016',2),
('750000000017','Carpeta Escolar',70.00,25,'M017',1),
('750000000018','Colores de Madera',100.00,50,'M018',3),
('750000000019','Sacapuntas Metálico',20.00,80,'M019',2),
('750000000020','Plumones Lavables',120.00,40,'M020',3),
('75000000233','agenda',145.88,12,'M003',2);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `provedores`
--

DROP TABLE IF EXISTS `provedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `provedores` (
  `RFC` varchar(12) NOT NULL,
  `razonSocial` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RFC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provedores`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `provedores` WRITE;
/*!40000 ALTER TABLE `provedores` DISABLE KEYS */;
INSERT INTO `provedores` VALUES
('PROV00000001','Proveedor 1 S.A.'),
('PROV00000002','Proveedor 2 S.A.'),
('PROV00000003','Proveedor 3 S.A.'),
('PROV00000004','Proveedor 4 S.A.'),
('PROV00000005','Proveedor 5 S.A.'),
('PROV00000006','Proveedor 6 S.A.'),
('PROV00000007','Proveedor 7 S.A.'),
('PROV00000008','Proveedor 8 S.A.'),
('PROV00000009','Proveedor 9 S.A.'),
('PROV00000010','Proveedor 10 S.A.'),
('PROV00000011','Proveedor 11 S.A.'),
('PROV00000012','Proveedor 12 S.A.'),
('PROV00000013','Proveedor 13 S.A.'),
('PROV00000014','Proveedor 14 S.A.'),
('PROV00000015','Proveedor 15 S.A.'),
('PROV00000016','Proveedor 16 S.A.'),
('PROV00000017','Proveedor 17 S.A.'),
('PROV00000018','Proveedor 18 S.A.'),
('PROV00000019','Proveedor 19 S.A.'),
('PROV00000020','Proveedor 20 S.A.');
/*!40000 ALTER TABLE `provedores` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `numTicket` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) DEFAULT NULL,
  `precioUnitario` decimal(8,2) DEFAULT NULL,
  `precioTotal` decimal(8,2) DEFAULT NULL,
  `codigoBarra` varchar(32) DEFAULT NULL,
  `idVenta` int(11) DEFAULT NULL,
  PRIMARY KEY (`numTicket`),
  KEY `fkProducto` (`codigoBarra`),
  KEY `fkVenta` (`idVenta`),
  CONSTRAINT `fkProducto` FOREIGN KEY (`codigoBarra`) REFERENCES `producto` (`codigoBarra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkVenta` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES
(1,2,12.50,25.00,'750000000001',1),
(2,1,35.00,35.00,'750000000002',2),
(3,3,25.00,75.00,'750000000003',3),
(4,1,15.00,15.00,'750000000004',4),
(5,2,30.00,60.00,'750000000005',5),
(6,1,20.00,20.00,'750000000006',6),
(7,1,150.00,150.00,'750000000007',7),
(8,1,60.00,60.00,'750000000008',8),
(9,5,10.00,50.00,'750000000009',9),
(10,1,500.00,500.00,'750000000010',10),
(11,4,40.00,160.00,'750000000011',11),
(12,3,25.00,75.00,'750000000012',12),
(13,2,15.00,30.00,'750000000013',13),
(14,2,8.00,16.00,'750000000014',14),
(15,3,18.00,54.00,'750000000015',15),
(16,3,18.00,54.00,'750000000016',16),
(17,1,70.00,70.00,'750000000017',17),
(18,1,100.00,100.00,'750000000018',18),
(19,2,20.00,40.00,'750000000019',19),
(20,3,120.00,360.00,'750000000020',20);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `nombreUser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(1,'era');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `usuario2`
--

DROP TABLE IF EXISTS `usuario2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario2` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `nombreUser` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario2`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `usuario2` WRITE;
/*!40000 ALTER TABLE `usuario2` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario2` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `venta`
--

DROP TABLE IF EXISTS `venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `venta` (
  `idVenta` int(11) NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `idCliente` int(11) DEFAULT NULL,
  `RFC` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`idVenta`),
  KEY `fkCliente` (`idCliente`),
  KEY `fkEmpleado` (`RFC`),
  CONSTRAINT `fkCliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkEmpleado` FOREIGN KEY (`RFC`) REFERENCES `empleado` (`RFC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venta`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `venta` WRITE;
/*!40000 ALTER TABLE `venta` DISABLE KEYS */;
INSERT INTO `venta` VALUES
(1,1200.50,'2024-11-01',1,'EMP00000001A'),
(2,450.00,'2024-11-02',2,'EMP00000002B'),
(3,750.00,'2024-11-03',3,'EMP00000003C'),
(4,300.00,'2024-11-04',4,'EMP00000004D'),
(5,900.00,'2024-11-05',5,'EMP00000005E'),
(6,600.00,'2024-11-06',6,'EMP00000006F'),
(7,1500.00,'2024-11-07',7,'EMP00000007G'),
(8,850.00,'2024-11-08',8,'EMP00000008H'),
(9,400.00,'2024-11-09',9,'EMP00000009I'),
(10,250.00,'2024-11-10',10,'EMP00000010J'),
(11,3000.00,'2024-11-11',11,'EMP00000011K'),
(12,750.00,'2024-11-12',12,'EMP00000012L'),
(13,950.00,'2024-11-13',13,'EMP00000013M'),
(14,1200.00,'2024-11-14',14,'EMP00000014N'),
(15,400.00,'2024-11-15',15,'EMP00000015O'),
(16,600.00,'2024-11-16',16,'EMP00000016P'),
(17,2200.00,'2024-11-17',17,'EMP00000017Q'),
(18,1500.00,'2024-11-18',18,'EMP00000018R'),
(19,850.00,'2024-11-19',19,'EMP00000019S'),
(20,300.00,'2024-11-20',20,'EMP00000020T');
/*!40000 ALTER TABLE `venta` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping events for database 'papeleria3a'
--

--
-- Dumping routines for database 'papeleria3a'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-10-31 20:56:24
