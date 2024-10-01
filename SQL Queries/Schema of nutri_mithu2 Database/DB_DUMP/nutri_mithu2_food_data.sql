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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 22:22:47
