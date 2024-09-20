USE nutri_mithu2;

ALTER TABLE `snacks` DROP FOREIGN KEY `snack_id`;

DROP TABLE IF EXISTS `snacks`;

CREATE TABLE `snacks` (
    `snack_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `calories_per_serving` DECIMAL(10, 2) NOT NULL
);