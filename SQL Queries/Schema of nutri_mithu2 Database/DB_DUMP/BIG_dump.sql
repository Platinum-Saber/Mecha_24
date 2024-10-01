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
-- Table structure for table `calorie_diary`
--

DROP TABLE IF EXISTS `calorie_diary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calorie_diary` (
  `entry_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `date` date NOT NULL,
  `meal_type` enum('breakfast','lunch','dinner','snack_1','snack_2') NOT NULL,
  `meal_id` int NOT NULL,
  `total_calories` decimal(10,2) NOT NULL,
  `state` enum('done','missed','pending') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`entry_id`),
  KEY `user_id` (`user_id`),
  KEY `meal_id` (`meal_id`),
  CONSTRAINT `calorie_diary_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calorie_diary`
--

LOCK TABLES `calorie_diary` WRITE;
/*!40000 ALTER TABLE `calorie_diary` DISABLE KEYS */;
INSERT INTO `calorie_diary` VALUES (1,2,'2024-09-30','breakfast',15,200.00,'pending'),(2,2,'2024-09-30','dinner',20,200.00,'pending'),(3,2,'2024-09-30','snack_1',40041,200.00,'pending'),(4,2,'2024-09-30','lunch',4,200.00,'pending'),(5,2,'2024-09-30','snack_2',40018,200.00,'pending'),(6,1,'2024-09-30','breakfast',2,300.00,'pending'),(7,1,'2024-09-30','snack_1',40032,300.00,'pending'),(8,1,'2024-09-30','lunch',10,300.00,'pending'),(9,1,'2024-09-30','snack_2',40003,300.00,'pending'),(10,1,'2024-09-30','dinner',7,300.00,'pending');
/*!40000 ALTER TABLE `calorie_diary` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_calorie_diary_state` BEFORE UPDATE ON `calorie_diary` FOR EACH ROW BEGIN
        IF NEW.date < CURDATE() AND NEW.state = 'pending' THEN
          SET NEW.state = 'missed';
        END IF;
      END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `food_data`
--

DROP TABLE IF EXISTS `food_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_data` (
  `food_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` enum('carb','protein','vegetable') NOT NULL,
  `calories_per_100g` decimal(10,2) NOT NULL,
  PRIMARY KEY (`food_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=30054 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_data`
--

LOCK TABLES `food_data` WRITE;
/*!40000 ALTER TABLE `food_data` DISABLE KEYS */;
INSERT INTO `food_data` VALUES (10001,'Rice (Cooked)','carb',133.00),(10002,'Rice (polished, steamed)','carb',133.00),(10003,'Rice porridge (medium viscosity)','carb',64.00),(10004,'Rice (glutinous, polished, steamed)','carb',228.00),(10005,'Rice (boiled, water 42%)','carb',58.00),(10006,'Rice (white, cooked)','carb',130.00),(10007,'Rice (brown, cooked)','carb',111.00),(10008,'Rice (parboiled, cooked)','carb',123.00),(10009,'Rice (Basmati, cooked)','carb',121.00),(10010,'Rice (Jasmine, cooked)','carb',129.00),(10011,'Rice (red, cooked)','carb',123.00),(10012,'Rice (black, cooked)','carb',135.00),(10013,'Instant Noodles','carb',457.00),(10014,'Noodles (rice, vermicelli, soaked)','carb',166.00),(10015,'Noodles (rice, small size, fresh)','carb',220.00),(10016,'Noodle (mungbean, soaked)','carb',169.00),(10017,'Potatoes (Boiled)','carb',80.00),(10018,'Bread','carb',230.00),(10019,'Rice (White Boiled)','carb',120.00),(10020,'Cornflakes with Milk','carb',205.00),(10021,'Wheat Bran','carb',200.00),(10022,'Bajra','carb',360.00),(10023,'Maize Flour','carb',355.00),(10024,'Wheat Flour','carb',341.00),(10025,'1 Medium Chapatti','carb',238.00),(10026,'1 Slice White Bread','carb',240.00),(10027,'1 Paratha (no filling)','carb',560.00),(10028,'Sugar (1 tbsp)','carb',48.00),(10029,'Honey (1 tbsp)','carb',90.00),(10030,'Chinese Roll (100g)','carb',175.00),(10031,'Dhal Wade (50g)','carb',200.00),(10032,'1 Bun (50g)','carb',310.00),(10033,'Chocolate Cake (40g)','carb',358.00),(10034,'1 tbsp Pol Sambol','carb',90.00),(10035,'1 Slice of Pittu (50g)','carb',282.00),(10036,'6 String Hoppers (75g)','carb',213.00),(10037,'1 Thosai (50g)','carb',160.00),(10038,'1 Pizza (100g)','carb',271.00),(10039,'Medium Size Rotti (50g)','carb',342.00),(10040,'1 Hopper (50g)','carb',100.00),(10041,'Buttermilk','carb',19.00),(10042,'Millet (cooked)','carb',119.00),(10043,'Sorghum (cooked)','carb',120.00),(10044,'Barley (cooked)','carb',123.00),(10045,'Corn (cooked)','carb',96.00),(10046,'Polenta (cooked)','carb',70.00),(10047,'Sweet Potatoes (cooked)','carb',90.00),(10048,'Taro (cooked)','carb',142.00),(10049,'Cassava (cooked)','carb',160.00),(10050,'Yam (cooked)','carb',118.00),(10051,'Arrowroot (cooked)','carb',100.00),(10052,'Tapioca (cooked)','carb',98.00),(10053,'Plantains (cooked)','carb',122.00),(20001,'Pork (tenderloin, raw)','protein',116.00),(20002,'Pork (meatball, blanched)','protein',140.00),(20003,'Pork (loin, whole, lean, raw)','protein',149.00),(20004,'Pork (liver, raw)','protein',124.00),(20005,'Pork (blood, cooked)','protein',49.00),(20006,'Pork (spare ribs, raw)','protein',208.00),(20007,'Pork (minced, raw)','protein',229.00),(20008,'Fish (Striped snake-head, raw)','protein',109.00),(20009,'Fish (Short-bodied mackerel, steamed)','protein',137.00),(20010,'Fish (Short-bodied mackerel, raw)','protein',122.00),(20011,'Fish (Nile tilapia, raw)','protein',87.00),(20012,'Fish (Gunther\'s walking catfish, raw)','protein',209.00),(20013,'Fish (fermented/Pla-ra, liquid)','protein',14.00),(20014,'Fish (fermented/Pla-ra)','protein',102.00),(20015,'Fish (Batrachian walking catfish, raw)','protein',117.00),(20016,'Egg (hen, whole, raw)','protein',133.00),(20017,'Egg (hen, yolk, raw)','protein',336.00),(20018,'Chicken (thigh, raw)','protein',212.00),(20019,'Chicken (meat, raw)','protein',186.00),(20020,'Chicken (liver, all classes, raw)','protein',114.00),(20021,'Chicken (blood, cooked)','protein',29.00),(20022,'Beef (meat, lean, raw)','protein',145.00),(20023,'Beef (meatball, blanched)','protein',84.00),(20024,'Squid (splendid, raw)','protein',68.00),(20025,'Soybean curd (with egg, soft packed in pouch)','protein',66.00),(20026,'Shrimp (small size, salted, dried, with shell)','protein',263.00),(20027,'Shrimp (banana, raw)','protein',82.00),(20028,'Egg Omelet','protein',240.00),(20029,'Curd (100g)','protein',100.00),(20030,'Cashew Nuts (28g)','protein',589.00),(20031,'1 Tea Cup Boiled Green Gram (150g)','protein',107.00),(20032,'1 Tea Cup Boiled Kadala (150g)','protein',117.00),(20033,'Cheese','protein',315.00),(20034,'Milk Buffalo','protein',115.00),(20035,'Milk Cow','protein',100.00),(20036,'Oats (cooked)','protein',71.00),(20037,'Quinoa (cooked)','protein',120.00),(20038,'Amaranth (cooked)','protein',102.00),(20039,'Buckwheat (cooked)','protein',92.00),(20040,'Teff (cooked)','protein',104.00),(20041,'Bulgur (cooked)','protein',83.00),(20042,'Freekeh (cooked)','protein',101.00),(20043,'Farro (cooked)','protein',120.00),(20044,'Spelt (cooked)','protein',123.00),(20045,'Rye (cooked)','protein',123.00),(20046,'Lentils (cooked)','protein',116.00),(20047,'Chickpeas (cooked)','protein',164.00),(20048,'Kidney Beans (cooked)','protein',127.00),(20049,'Black Beans (cooked)','protein',132.00),(20050,'Mung Beans (cooked)','protein',105.00),(20051,'Green Peas (cooked)','protein',81.00),(20052,'Soybeans (cooked)','protein',173.00),(30001,'Apple (100g)','vegetable',50.00),(30002,'Banana','vegetable',95.00),(30003,'Grapes','vegetable',60.00),(30004,'Grapes Black','vegetable',45.00),(30005,'Orange','vegetable',35.00),(30006,'Orange Juice (100ml)','vegetable',47.00),(30007,'Peach','vegetable',50.00),(30009,'Pears','vegetable',51.00),(30010,'Papaya','vegetable',32.00),(30011,'Lychees','vegetable',61.00),(30012,'Cabbage (Chinese, white, raw)','vegetable',12.00),(30013,'Cabbage (raw)','vegetable',23.00),(30014,'Cabbage (Boiled)','vegetable',10.00),(30015,'Chinese convolvulus (raw)','vegetable',20.00),(30016,'Cabbage (Chinese/PAI TSAI, raw)','vegetable',20.00),(30017,'Cauliflower (raw)','vegetable',28.00),(30018,'Cauliflower (Boiled)','vegetable',10.00),(30019,'Carrot (raw)','vegetable',32.00),(30020,'Carrot (Boiled)','vegetable',20.00),(30021,'Celery','vegetable',16.00),(30022,'Cucumber (Raw)','vegetable',10.00),(30023,'Green beans (raw)','vegetable',31.00),(30024,'Green beans (Boiled)','vegetable',24.00),(30025,'Kale (Chinese, raw)','vegetable',21.00),(30026,'Lettuce','vegetable',21.00),(30027,'Mushroom (straw, raw)','vegetable',31.00),(30028,'Mushroom','vegetable',18.00),(30029,'Onion (raw)','vegetable',26.00),(30030,'Onion','vegetable',50.00),(30031,'Peas (Boiled)','vegetable',50.00),(30032,'Spinach','vegetable',23.00),(30033,'Tomato (raw)','vegetable',23.00),(30034,'Tomato juice (100ml)','vegetable',22.00),(30035,'Avocado Pear','vegetable',190.00),(30036,'Broccoli','vegetable',25.00),(30037,'Brinjal','vegetable',24.00),(30038,'Fenugreek (Methi)','vegetable',49.00),(30039,'French beans','vegetable',26.00),(30040,'Guava','vegetable',44.00),(30041,'Papaya (unripe, raw)','vegetable',25.00),(30042,'Papaya (ripe)','vegetable',39.00),(30043,'Pineapple','vegetable',59.00),(30044,'Watermelon','vegetable',24.00),(30045,'Rambutan','vegetable',73.00),(30046,'Kiwi Fruit','vegetable',45.00),(30049,'Strawberry','vegetable',77.00),(30050,'Pomegranate','vegetable',77.00),(30051,'Mangoes','vegetable',70.00),(30052,'Cherries','vegetable',50.00),(30053,'Dates','vegetable',281.00);
/*!40000 ALTER TABLE `food_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal_plans`
--

DROP TABLE IF EXISTS `meal_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meal_plans` (
  `meal_id` int NOT NULL AUTO_INCREMENT,
  `carb_id` int DEFAULT NULL,
  `protein_id` int DEFAULT NULL,
  `vegetable_id` int DEFAULT NULL,
  `other_id` int DEFAULT NULL,
  `proportion` decimal(5,2) NOT NULL DEFAULT '1.00',
  PRIMARY KEY (`meal_id`),
  KEY `carb_id` (`carb_id`),
  KEY `protein_id` (`protein_id`),
  KEY `vegetable_id` (`vegetable_id`),
  KEY `other_id` (`other_id`),
  CONSTRAINT `meal_plans_ibfk_1` FOREIGN KEY (`carb_id`) REFERENCES `food_data` (`food_id`),
  CONSTRAINT `meal_plans_ibfk_2` FOREIGN KEY (`protein_id`) REFERENCES `food_data` (`food_id`),
  CONSTRAINT `meal_plans_ibfk_3` FOREIGN KEY (`vegetable_id`) REFERENCES `food_data` (`food_id`),
  CONSTRAINT `meal_plans_ibfk_4` FOREIGN KEY (`other_id`) REFERENCES `food_data` (`food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal_plans`
--

LOCK TABLES `meal_plans` WRITE;
/*!40000 ALTER TABLE `meal_plans` DISABLE KEYS */;
INSERT INTO `meal_plans` VALUES (1,10029,20001,30024,NULL,1.00),(2,10020,20016,30029,NULL,1.00),(3,10007,20039,30014,NULL,1.00),(4,10032,20042,30003,NULL,1.00),(5,10037,20012,30026,NULL,1.00),(6,10023,20002,30031,NULL,1.00),(7,10004,20025,30041,NULL,1.00),(8,10047,20035,30001,NULL,1.00),(9,10008,20040,30013,NULL,1.00),(10,10004,20018,30045,NULL,1.00),(11,10013,20020,30044,NULL,1.00),(12,10016,20006,30037,NULL,1.00),(13,10029,20027,30025,NULL,1.00),(14,10021,20021,30029,NULL,1.00),(15,10002,20027,30037,NULL,1.00),(16,10021,20019,30006,NULL,1.00),(17,10014,20005,30005,NULL,1.00),(18,10007,20037,30052,NULL,1.00),(19,10039,20016,30021,NULL,1.00),(20,10014,20037,30049,NULL,1.00);
/*!40000 ALTER TABLE `meal_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `meals`
--

DROP TABLE IF EXISTS `meals`;
/*!50001 DROP VIEW IF EXISTS `meals`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `meals` AS SELECT 
 1 AS `meal_id`,
 1 AS `carb_name`,
 1 AS `prot_name`,
 1 AS `vegi_name`,
 1 AS `other_name`,
 1 AS `carb_calorie`,
 1 AS `prot_calorie`,
 1 AS `vegi_calorie`,
 1 AS `other_calorie`,
 1 AS `proportion`,
 1 AS `ratio`,
 1 AS `calc_carb_calorie`,
 1 AS `calc_prot_calorie`,
 1 AS `calc_vegi_calorie`,
 1 AS `calc_other_calorie`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequelizemeta` (
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequelizemeta`
--

LOCK TABLES `sequelizemeta` WRITE;
/*!40000 ALTER TABLE `sequelizemeta` DISABLE KEYS */;
INSERT INTO `sequelizemeta` VALUES ('20240828155411-create-user.js'),('20240828155424-create-meal-plan.js'),('20240828155432-create-ingredient.js'),('20240920063902-update_schema.js'),('20240920094121-modify_snacks_and_food_data.js'),('20240920100702-drop_unnecessary_tables.js'),('20240920101027-drop_mealplans_table.js'),('20240928104521-add-state-to-calorie-diary.js');
/*!40000 ALTER TABLE `sequelizemeta` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `user_id` int NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `date_of_birth` date NOT NULL,
  `height_cm` decimal(5,2) NOT NULL,
  `weight_kg` decimal(5,2) NOT NULL,
  `dietary_preference` enum('vegetarian','non_vegetarian','vegan') NOT NULL,
  `allergies` text,
  `ethnicity` enum('sri_lankan','south_asian','asian','non_asian') NOT NULL,
  `activity_level` enum('light','moderate','active','very_active') NOT NULL,
  `current_calories_per_day` int NOT NULL,
  `weight_goal` enum('maintain','lose','gain') NOT NULL,
  `target_weight_kg` decimal(5,2) DEFAULT NULL,
  `weight_change_rate` enum('0','200','400','600','800') NOT NULL,
  `bmi` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profiles`
--

LOCK TABLES `user_profiles` WRITE;
/*!40000 ALTER TABLE `user_profiles` DISABLE KEYS */;
INSERT INTO `user_profiles` VALUES (1,'male','1999-09-20',176.00,80.00,'non_vegetarian','none','sri_lankan','moderate',1000,'lose',65.00,'200',NULL),(2,'female','2000-09-12',169.00,61.00,'vegetarian','peanuts','south_asian','light',1200,'lose',50.00,'400',NULL),(3,'male','2002-08-07',187.00,57.00,'vegan','milk','non_asian','active',1236,'gain',64.00,'200',NULL),(4,'male','2011-09-20',120.00,46.00,'non_vegetarian','pineapple','sri_lankan','light',600,'maintain',46.00,'0',NULL),(5,'male','2024-09-21',179.00,81.00,'vegetarian','no','sri_lankan','moderate',1000,'lose',68.00,'200',NULL);
/*!40000 ALTER TABLE `user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user1','user1@gmail.com','$2b$10$aogVYplbYdaPbly5vXt53O5QKwibAGLdu8iQBVJDwJyXQVaIaQVzu','2024-09-20 07:28:36','2024-09-20 07:28:36'),(2,'user2','user2@gmail.com','$2b$10$CGXB1Ulr7v1ElUijYcNHle5aM7VqB/PZ7pzVR9mKeU8j4ySRT.Ehi','2024-09-20 07:34:17','2024-09-20 07:34:17'),(3,'user3','user3@gmail.com','$2b$10$6KHr9WjLDHs2NXqO7KFZT.MLqT6S7iWvSDVo6ePgUg7t4nmerlQLm','2024-09-20 07:41:45','2024-09-20 07:41:45'),(4,'user4','user4@gmail.com','$2b$10$FBThXabvC/.IDJGVcRQiiOqijqgxEn/ToPQYROdxuf.fk6Npr/SGm','2024-09-20 07:56:54','2024-09-20 07:56:54'),(5,'user11','user11@gmail.com','$2b$10$aKfkT9c194wcGaM11TpGg.myalbDjuIC1BReAfhHiyM38ZZPsYive','2024-09-21 17:21:34','2024-09-21 17:21:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_user_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
  INSERT INTO user_profiles (
    user_id,
    gender,
    date_of_birth,
    height_cm,
    weight_kg,
    dietary_preference,
    allergies,
    ethnicity,
    activity_level,
    current_calories_per_day,
    weight_goal,
    target_weight_kg,
    weight_change_rate,
    bmi
  ) VALUES (
    NEW.user_id,
    'other',  -- Enum: keeping previous value
    CURDATE(),  -- Current date as default
    0,
    0,
    'non_vegetarian',  -- Enum: keeping previous value
    'not set',
    'sri_lankan',  -- Enum: keeping previous value
    'moderate',  -- Enum: keeping previous value
    0,
    'maintain',  -- Enum: keeping previous value
    0,
    '0',  -- Enum: keeping previous value
    NULL  -- Calculated field, keeping as NULL
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'nutri_mithu2'
--

--
-- Dumping routines for database 'nutri_mithu2'
--
/*!50003 DROP FUNCTION IF EXISTS `calculate_component_calories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_component_calories`(
    meal_id INT, 
    component_type ENUM('carb', 'protein', 'vegetable', 'other')
) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE component_calories DECIMAL(10, 2);
    DECLARE total_ratio DECIMAL(5, 2);
    DECLARE component_cal DECIMAL(10, 2);
    DECLARE component_ratio DECIMAL(5, 2);
    -- Get the proportion and food data
    SELECT 
        mp.proportion,
        fd.calories_per_100g
    INTO 
        total_ratio, component_cal
    FROM 
        meal_plans mp
    JOIN 
        food_data fd ON (
            CASE 
                WHEN component_type = 'carb' THEN mp.carb_id
                WHEN component_type = 'protein' THEN mp.protein_id
                WHEN component_type = 'vegetable' THEN mp.vegetable_id
                ELSE mp.other_id
            END = fd.food_id
        )
    WHERE 
        mp.meal_id = meal_id;
    -- Calculate the ratio
    SET component_ratio = CASE
        WHEN component_type = 'protein' THEN 2
        WHEN component_type = 'other' THEN IF(component_cal > 0, 1, 0)
        ELSE 1
    END / (1 + 2 + 1 + IF(component_type = 'other' AND component_cal > 0, 1, 0));
    -- Calculate the calories for 100 grams
    SET component_calories = ROUND(100 * component_ratio * component_cal / total_ratio, 2);
    RETURN component_calories;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calculate_meal_calories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_meal_calories`(IN meal_id INT, OUT carb_calorie DECIMAL(10, 2), OUT prot_calorie DECIMAL(10, 2), OUT vegi_calorie DECIMAL(10, 2), OUT other_calorie DECIMAL(10, 2))
BEGIN
    DECLARE carb_ratio DECIMAL(5, 2);
    DECLARE prot_ratio DECIMAL(5, 2);
    DECLARE vegi_ratio DECIMAL(5, 2);
    DECLARE other_ratio DECIMAL(5, 2);
    DECLARE total_ratio DECIMAL(5, 2);
    DECLARE carb_cal DECIMAL(10, 2);
    DECLARE prot_cal DECIMAL(10, 2);
    DECLARE vegi_cal DECIMAL(10, 2);
    DECLARE other_cal DECIMAL(10, 2);
    -- Get the proportion and food data
    SELECT 
        mp.proportion,
        carb.calories_per_100g,
        protein.calories_per_100g,
        vegetable.calories_per_100g,
        COALESCE(other.calories_per_100g, 0)
    INTO 
        total_ratio, carb_cal, prot_cal, vegi_cal, other_cal
    FROM 
        meal_plans mp
    LEFT JOIN 
        food_data carb ON mp.carb_id = carb.food_id
    LEFT JOIN 
        food_data protein ON mp.protein_id = protein.food_id
    LEFT JOIN 
        food_data vegetable ON mp.vegetable_id = vegetable.food_id
    LEFT JOIN 
        food_data other ON mp.other_id = other.food_id
    WHERE 
        mp.meal_id = meal_id;
    -- Calculate the ratios
    SET carb_ratio = 1 / (1 + 2 + 1 + IF(other_cal > 0, 1, 0));
    SET prot_ratio = 2 / (1 + 2 + 1 + IF(other_cal > 0, 1, 0));
    SET vegi_ratio = 1 / (1 + 2 + 1 + IF(other_cal > 0, 1, 0));
    SET other_ratio = IF(other_cal > 0, 1, 0) / (1 + 2 + 1 + IF(other_cal > 0, 1, 0));
    -- Calculate the calories for 100 grams
    SET carb_calorie = ROUND(100 * carb_ratio * carb_cal / total_ratio, 2);
    SET prot_calorie = ROUND(100 * prot_ratio * prot_cal / total_ratio, 2);
    SET vegi_calorie = ROUND(100 * vegi_ratio * vegi_cal / total_ratio, 2);
    SET other_calorie = ROUND(100 * other_ratio * other_cal / total_ratio, 2);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_meal_plans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `generate_meal_plans`()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE carb_id INT;
    DECLARE protein_id INT;
    DECLARE vegetable_id INT;
    DECLARE other_id INT;

    WHILE i <= 10 DO
        -- Select random carb
        SELECT food_id INTO carb_id
        FROM food_data
        WHERE type = 'carb'
        ORDER BY RAND()
        LIMIT 1;

        -- Select random protein
        SELECT food_id INTO protein_id
        FROM food_data
        WHERE type = 'protein'
        ORDER BY RAND()
        LIMIT 1;

        -- Select random vegetable
        SELECT food_id INTO vegetable_id
        FROM food_data
        WHERE type = 'vegetable'
        ORDER BY RAND()
        LIMIT 1;

        -- Select random other (if applicable)
        SELECT food_id INTO other_id
        FROM food_data
        WHERE type NOT IN ('carb', 'protein', 'vegetable')
        ORDER BY RAND()
        LIMIT 1;

        -- Insert into meal_plans
        INSERT INTO meal_plans (carb_id, protein_id, vegetable_id, other_id)
        VALUES (carb_id, protein_id, vegetable_id, other_id);

        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `meals`
--

/*!50001 DROP VIEW IF EXISTS `meals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `meals` AS select `mp`.`meal_id` AS `meal_id`,`carb`.`name` AS `carb_name`,`protein`.`name` AS `prot_name`,`vegetable`.`name` AS `vegi_name`,coalesce(`other`.`name`,'None') AS `other_name`,`carb`.`calories_per_100g` AS `carb_calorie`,`protein`.`calories_per_100g` AS `prot_calorie`,`vegetable`.`calories_per_100g` AS `vegi_calorie`,coalesce(`other`.`calories_per_100g`,0) AS `other_calorie`,`mp`.`proportion` AS `proportion`,concat(round((`mp`.`proportion` * (1 / (((1 + 2) + 1) + if((`mp`.`other_id` is null),0,1)))),2),':',round((`mp`.`proportion` * (2 / (((1 + 2) + 1) + if((`mp`.`other_id` is null),0,1)))),2),':',round((`mp`.`proportion` * (1 / (((1 + 2) + 1) + if((`mp`.`other_id` is null),0,1)))),2),':',round((`mp`.`proportion` * (if((`mp`.`other_id` is null),0,1) / (((1 + 2) + 1) + if((`mp`.`other_id` is null),0,1)))),2)) AS `ratio`,`calculate_component_calories`(`mp`.`meal_id`,'carb') AS `calc_carb_calorie`,`calculate_component_calories`(`mp`.`meal_id`,'protein') AS `calc_prot_calorie`,`calculate_component_calories`(`mp`.`meal_id`,'vegetable') AS `calc_vegi_calorie`,`calculate_component_calories`(`mp`.`meal_id`,'other') AS `calc_other_calorie` from ((((`meal_plans` `mp` left join `food_data` `carb` on((`mp`.`carb_id` = `carb`.`food_id`))) left join `food_data` `protein` on((`mp`.`protein_id` = `protein`.`food_id`))) left join `food_data` `vegetable` on((`mp`.`vegetable_id` = `vegetable`.`food_id`))) left join `food_data` `other` on((`mp`.`other_id` = `other`.`food_id`))) */;
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

-- Dump completed on 2024-10-01 22:27:06
