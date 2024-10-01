CREATE DATABASE  IF NOT EXISTS `nutri_mithu2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `nutri_mithu2`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nutri_mithu2
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `snacks`
--

DROP TABLE IF EXISTS `snacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snacks` (
  `snack_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `calories_per_serving` decimal(10,2) NOT NULL,
  PRIMARY KEY (`snack_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=40083 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snacks`
--

LOCK TABLES `snacks` WRITE;
/*!40000 ALTER TABLE `snacks` DISABLE KEYS */;
INSERT INTO `snacks` VALUES (40001,'1 Cup Tea',90.00),(40002,'Munchee Marie Biscuit',115.00),(40003,'Maliban Marie Biscuit',120.00),(40004,'Munchee Chocolate Biscuit',100.00),(40005,'Maliban Chocolate Biscuit',105.00),(40006,'Munchee Lemon Puff',110.00),(40007,'Maliban Lemon Puff',120.00),(40008,'Munchee Ginger Biscuit',110.00),(40009,'Maliban Smart Cream Cracker',100.00),(40010,'Munchee Milk Short Cake',130.00),(40011,'Maliban Gold Marie',125.00),(40012,'Munchee Hawaiian Cookies',140.00),(40013,'Maliban Nice Biscuit',150.00),(40014,'Munchee Chocolate Puff',125.00),(40015,'Marshmallow (generic)',100.00),(40016,'Munchee Ginger Roll',120.00),(40017,'Pebble Sweets (generic)',130.00),(40018,'Murukku (generic)',150.00),(40019,'Seeni Murukku',160.00),(40020,'Coconut Toffee',120.00),(40021,'Cadbury Dairy Milk Chocolate',135.00),(40022,'Kit Kat (4 finger)',218.00),(40023,'Tic Tac Toffees',110.00),(40024,'Ferrero Rocher',150.00),(40025,'Kithul Jaggery',130.00),(40026,'Munchee Milk Toffees',125.00),(40027,'Chikki (Peanut Brittle)',150.00),(40028,'Cadbury Gems',140.00),(40029,'Snickers Bar',250.00),(40030,'Sri Lankan Kokis',110.00),(40031,'Aluwa (Sri Lankan sweet)',120.00),(40032,'Traditional Athirasa',150.00),(40033,'Sesame Rolls',120.00),(40034,'Bombai Motai',115.00),(40035,'Rulang Aluwa',140.00),(40036,'Sri Lankan Watalappan',200.00),(40037,'Pol Toffee (Coconut Toffee)',120.00),(40038,'Munchee Chocolate Cream Biscuit',140.00),(40039,'Cadbury Crunchie Bar',190.00),(40040,'Kaju Aluwa (Cashew Sweet)',140.00),(40041,'Munchee Nice Biscuit',150.00),(40042,'Maliban Cheese Puff',130.00),(40043,'Elephant House Ice Cream Cup',160.00),(40044,'Elephant House Lemonade',90.00),(40045,'Coca-Cola (Can)',140.00),(40046,'Elephant House Cream Soda',120.00),(40047,'Fanta (Can)',135.00),(40048,'Pepsi (Can)',150.00),(40049,'Ceylon Biscuits Chocolate Chips',140.00),(40050,'Ceylon Biscuits Orange Cream',150.00),(40051,'Kist Nectar',110.00),(40052,'Tipi Tip (Snack)',160.00),(40053,'Munchee Milk Short Bread',130.00),(40054,'Lays (Chips)',130.00),(40055,'Pringles (Original)',210.00),(40056,'Oreo Cookies',160.00),(40057,'Munchee Chocolate Fingers',150.00),(40058,'Maliban Chocolate Puff',150.00),(40059,'Munchee Swiss Roll',190.00),(40060,'Maliban Swiss Roll',195.00),(40061,'Munchee Cracker',130.00),(40062,'Elephant House Milk Toffee',120.00),(40063,'Elephant House Jelly Cup',90.00),(40064,'Munchee Cashew Nut Cookies',140.00),(40065,'Ceylon Biscuits Strawberry Cream',140.00),(40066,'Nestlé Milo (Drink Pack)',160.00),(40067,'Nestlé Nespray Milk',130.00),(40068,'Ceylon Biscuits Milk Shortbread',120.00),(40069,'Kist Mixed Fruit Nectar',110.00),(40070,'MD Pineapple Jam',90.00),(40071,'Elephant House Orange Barley',95.00),(40072,'Munchee Hawaiian Shortcake',140.00),(40073,'Maliban Gold Cracker',120.00),(40074,'Kothmale Curd with Honey',190.00),(40075,'Elephant House Choc Chip Ice Cream',180.00),(40076,'Elephant House Necto',120.00),(40077,'Coca-Cola (Pet Bottle)',210.00),(40078,'Keells Polos Roll (Packaged)',200.00),(40079,'KFC Crispy Fries (Small Pack)',300.00),(40080,'Peanut Brittle (Generic)',150.00),(40081,'Munchee Milk Wafer',140.00),(40082,'Munchee Vanilla Wafer',130.00);
/*!40000 ALTER TABLE `snacks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 22:22:47
