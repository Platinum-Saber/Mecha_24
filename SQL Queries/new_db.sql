-- Create the food_data table
DROP DATABASE IF EXISTS nutri_mithu2;

CREATE DATABASE IF NOT EXISTS nutri_mithu2;

USE nutri_mithu2;

DROP TABLE IF EXISTS `food_data`;

CREATE TABLE `food_data` (
    `food_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `type` ENUM(
        'carb',
        'protein',
        'vitamin',
        'snack'
    ) NOT NULL,
    `calories_per_100g` DECIMAL(10, 2) NOT NULL,
    `protein_per_100g` DECIMAL(10, 2),
    `carbs_per_100g` DECIMAL(10, 2),
    `fat_per_100g` DECIMAL(10, 2),
    `fiber_per_100g` DECIMAL(10, 2)
);

DROP TABLE IF EXISTS `users`;
-- Create the users table
CREATE TABLE `users` (
    `user_id` INT PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(50) UNIQUE NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS `calorie_diary`;
-- Create the calorie_diary table
CREATE TABLE `calorie_diary` (
    `entry_id` INT PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `date` DATE NOT NULL,
    `meal_type` ENUM(
        'breakfast',
        'lunch',
        'dinner',
        'snack'
    ) NOT NULL,
    `food_id` INT NOT NULL,
    `quantity_grams` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    FOREIGN KEY (`food_id`) REFERENCES `food_data` (`food_id`)
);

DROP TABLE IF EXISTS `meal_plans`;
-- Create the meal_plans table
CREATE TABLE `meal_plans` (
    `meal_id` INT PRIMARY KEY AUTO_INCREMENT,
    `carb_id` INT,
    `protein_id` INT,
    `vitamin_id` INT,
    `snack_id` INT,
    FOREIGN KEY (`carb_id`) REFERENCES `food_data` (`food_id`),
    FOREIGN KEY (`protein_id`) REFERENCES `food_data` (`food_id`),
    FOREIGN KEY (`vitamin_id`) REFERENCES `food_data` (`food_id`),
    FOREIGN KEY (`snack_id`) REFERENCES `food_data` (`food_id`)
);

DROP TABLE IF EXISTS `user_profiles`;
-- Create the user_profiles table
CREATE TABLE `user_profiles` (
    `user_id` INT PRIMARY KEY,
    `gender` ENUM('male', 'female', 'other') NOT NULL,
    `date_of_birth` DATE NOT NULL,
    `height_cm` DECIMAL(5, 2) NOT NULL,
    `weight_kg` DECIMAL(5, 2) NOT NULL,
    `dietary_preference` ENUM(
        'vegetarian',
        'non_vegetarian',
        'vegan'
    ) NOT NULL,
    `allergies` TEXT,
    `ethnicity` ENUM(
        'sri_lankan',
        'south_asian',
        'asian',
        'non_asian'
    ) NOT NULL,
    `activity_level` ENUM(
        'light',
        'moderate',
        'active',
        'very_active'
    ) NOT NULL,
    `current_calories_per_day` INT NOT NULL,
    `weight_goal` ENUM('maintain', 'lose', 'gain') NOT NULL,
    `target_weight_kg` DECIMAL(5, 2),
    `weight_change_rate` ENUM(
        '0',
        '200',
        '400',
        '600',
        '800'
    ) NOT NULL,
    `bmi` DECIMAL(4, 2),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
);

DELIMITER //

CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO user_profiles (user_id)
  VALUES (NEW.user_id);
END //

DELIMITER ;