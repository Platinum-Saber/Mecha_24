CREATE database nutri_mithu;
USE nutri_mithu;

CREATE TABLE `mealplans` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `mealPlan` VARCHAR(45),
  `calories` INT,
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
  PRIMARY KEY (`id`)
);

CREATE TABLE `ingredients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `mealPlan_id` INT,
  `quantity` VARCHAR(6),
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`mealPlan_id`) REFERENCES mealplans
);


CREATE TABLE `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `email` VARCHAR(255),
  `password` VARCHAR(255),
  `createdAt` DATETIME,
  `updatedAt` DATETIME,
  PRIMARY KEY (`id`)
);


