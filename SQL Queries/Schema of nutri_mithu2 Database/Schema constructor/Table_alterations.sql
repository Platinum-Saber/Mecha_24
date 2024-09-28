USE nutri_mithu2;
DROP TABLE IF EXISTS `snacks`;
CREATE TABLE `snacks` (
    `snack_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `calories_per_serving` DECIMAL(10, 2) NOT NULL
);
ALTER TABLE meal_plans
ADD COLUMN proportion DECIMAL(5, 2) NOT NULL DEFAULT 1.00;
ALTER TABLE `calorie_diary`
ADD COLUMN `state` ENUM('done', 'missed', 'pending') DEFAULT 'pending';
DELIMITER // CREATE TRIGGER update_calorie_diary_state BEFORE
UPDATE ON `calorie_diary` FOR EACH ROW BEGIN IF NEW.date < CURDATE()
    AND NEW.state = 'pending' THEN
SET NEW.state = 'missed';
END IF;
END // DELIMITER;