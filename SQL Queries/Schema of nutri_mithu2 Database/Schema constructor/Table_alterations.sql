USE nutri_mithu2;

DROP TABLE IF EXISTS `snacks`;

CREATE TABLE `snacks` (
    `snack_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `calories_per_serving` DECIMAL(10, 2) NOT NULL
);

ALTER TABLE meal_plans
ADD COLUMN proportion DECIMAL(5, 2) NOT NULL DEFAULT 1.00;