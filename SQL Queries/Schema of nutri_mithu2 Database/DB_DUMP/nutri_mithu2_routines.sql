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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 22:22:47
