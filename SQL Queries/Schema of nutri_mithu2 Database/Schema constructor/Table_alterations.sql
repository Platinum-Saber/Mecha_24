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

DELIMITER //

CREATE TRIGGER update_calorie_diary_state BEFORE
UPDATE ON `calorie_diary` FOR EACH ROW BEGIN IF NEW.date < CURDATE()
    AND NEW.state = 'pending' THEN
SET NEW.state = 'missed';
END IF;
END //

DELIMITER ;

ALTER TABLE `calorie_diary`
MODIFY `meal_type` ENUM(
        'breakfast',
        'lunch',
        'dinner',
        'snack_1',
        'snack_2'
    ) NOT NULL;

ALTER TABLE `calorie_diary`
DROP FOREIGN KEY `calorie_diary_ibfk_2`;

TRUNCATE TABLE `calorie_diary`;