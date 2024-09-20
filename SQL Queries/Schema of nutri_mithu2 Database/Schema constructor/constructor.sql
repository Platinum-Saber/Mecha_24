-- Create the food_data table
DROP DATABASE IF EXISTS nutri_mithu2;

# noinspection SpellCheckingInspection
CREATE DATABASE IF NOT EXISTS nutri_mithu2;

USE nutri_mithu2;

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

DROP TABLE IF EXISTS `food_data`;

CREATE TABLE `food_data` (
    `food_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) UNIQUE NOT NULL,
    `type` ENUM(
        'carb',
        'protein',
        'vegetable',
        'snack'
    ) NOT NULL,
    `calories_per_100g` DECIMAL(10, 2) NOT NULL
);

DROP TABLE IF EXISTS `snacks`;

CREATE TABLE `snacks` (
    `snack_id` INT PRIMARY KEY,
    FOREIGN KEY (`snack_id`) references `food_data` (`food_id`)
);

DROP TABLE IF EXISTS `meal_plans`;
-- Create the meal_plans table
CREATE TABLE `meal_plans` (
    `meal_id` INT PRIMARY KEY AUTO_INCREMENT,
    `carb_id` INT,
    `protein_id` INT,
    `vegetable_id` INT,
    `other_id` INT,
    FOREIGN KEY (`carb_id`) REFERENCES `food_data` (`food_id`),
    FOREIGN KEY (`protein_id`) REFERENCES `food_data` (`food_id`),
    FOREIGN KEY (`vegetable_id`) REFERENCES `food_data` (`food_id`),
    FOREIGN KEY (`other_id`) REFERENCES `food_data` (`food_id`)
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
    `meal_id` INT NOT NULL,
    `total_calories` DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
    FOREIGN KEY (`meal_id`) REFERENCES `meal_plans` (`meal_id`)
);

DROP TRIGGER IF EXISTS after_user_insert;

DELIMITER / /

CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
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
END //

DELIMITER;