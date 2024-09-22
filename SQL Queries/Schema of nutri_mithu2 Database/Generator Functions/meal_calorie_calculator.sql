DELIMITER / /

CREATE PROCEDURE calculate_meal_calories(IN meal_id INT, OUT carb_calorie DECIMAL(10, 2), OUT prot_calorie DECIMAL(10, 2), OUT vegi_calorie DECIMAL(10, 2), OUT other_calorie DECIMAL(10, 2))
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
END //

DELIMITER;

DELIMITER / /

CREATE FUNCTION calculate_component_calories(
    meal_id INT, 
    component_type ENUM('carb', 'protein', 'vegetable', 'other')
) 
RETURNS DECIMAL(10, 2)
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
END //

DELIMITER;