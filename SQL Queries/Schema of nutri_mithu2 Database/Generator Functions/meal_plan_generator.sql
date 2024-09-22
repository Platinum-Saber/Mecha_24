use nutri_mithu2;

DELIMITER / /

CREATE PROCEDURE generate_meal_plans()
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
END //

DELIMITER ;

-- Call the procedure to generate 10 meal plans
CALL generate_meal_plans ();