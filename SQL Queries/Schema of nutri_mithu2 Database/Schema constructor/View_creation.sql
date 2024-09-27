USE nutri_mithu2;

DROP VIEW IF EXISTS meals;

# CREATE VIEW meals AS
# SELECT
#     mp.meal_id,
#     carb.name AS carb_name,
#     protein.name AS prot_name,
#     vegetable.name AS vegi_name,
#     COALESCE(other.name, 'None') AS other_name,
#     carb.calories_per_100g AS carb_calorie,
#     protein.calories_per_100g AS prot_calorie,
#     vegetable.calories_per_100g AS vegi_calorie,
#     COALESCE(other.calories_per_100g, 0) AS other_calorie,
#     mp.proportion,
#     CONCAT(
#         ROUND(
#             mp.proportion * (
#                 1 / (
#                     1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
#                 )
#             ),
#             2
#         ),
#         ':',
#         ROUND(
#             mp.proportion * (
#                 2 / (
#                     1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
#                 )
#             ),
#             2
#         ),
#         ':',
#         ROUND(
#             mp.proportion * (
#                 1 / (
#                     1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
#                 )
#             ),
#             2
#         ),
#         ':',
#         ROUND(
#             mp.proportion * (
#                 IF(mp.other_id IS NULL, 0, 1) / (
#                     1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
#                 )
#             ),
#             2
#         )
#     ) AS ratio,
#     (
#         SELECT @carb_cal := 0
#     ) AS dummy,
#     (
#         SELECT @prot_cal := 0
#     ) AS dummy2,
#     (
#         SELECT @vegi_cal := 0
#     ) AS dummy3,
#     (
#         SELECT @other_cal := 0
#     ) AS dummy4,
#     (
#         CALL calculate_meal_calories (
#             mp.meal_id,
#             @carb_cal,
#             @prot_cal,
#             @vegi_cal,
#             @other_cal
#         )
#     ) AS dummy5,
#     @carb_cal AS calc_carb_calorie,
#     @prot_cal AS calc_prot_calorie,
#     @vegi_cal AS calc_vegi_calorie,
#     @other_cal AS calc_other_calorie
# FROM
#     meal_plans mp
#     LEFT JOIN food_data carb ON mp.carb_id = carb.food_id
#     LEFT JOIN food_data protein ON mp.protein_id = protein.food_id
#     LEFT JOIN food_data vegetable ON mp.vegetable_id = vegetable.food_id
#     LEFT JOIN food_data other ON mp.other_id = other.food_id;

CREATE VIEW meals AS
SELECT
    mp.meal_id,
    carb.name AS carb_name,
    protein.name AS prot_name,
    vegetable.name AS vegi_name,
    COALESCE(other.name, 'None') AS other_name,
    carb.calories_per_100g AS carb_calorie,
    protein.calories_per_100g AS prot_calorie,
    vegetable.calories_per_100g AS vegi_calorie,
    COALESCE(other.calories_per_100g, 0) AS other_calorie,
    mp.proportion,
    CONCAT(
        ROUND(
            mp.proportion * (
                1 / (
                    1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
                )
            ),
            2
        ),
        ':',
        ROUND(
            mp.proportion * (
                2 / (
                    1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
                )
            ),
            2
        ),
        ':',
        ROUND(
            mp.proportion * (
                1 / (
                    1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
                )
            ),
            2
        ),
        ':',
        ROUND(
            mp.proportion * (
                IF(mp.other_id IS NULL, 0, 1) / (
                    1 + 2 + 1 + IF(mp.other_id IS NULL, 0, 1)
                )
            ),
            2
        )
    ) AS ratio,
    calculate_component_calories (mp.meal_id, 'carb') AS calc_carb_calorie,
    calculate_component_calories (mp.meal_id, 'protein') AS calc_prot_calorie,
    calculate_component_calories (mp.meal_id, 'vegetable') AS calc_vegi_calorie,
    calculate_component_calories (mp.meal_id, 'other') AS calc_other_calorie
FROM
    meal_plans mp
    LEFT JOIN food_data carb ON mp.carb_id = carb.food_id
    LEFT JOIN food_data protein ON mp.protein_id = protein.food_id
    LEFT JOIN food_data vegetable ON mp.vegetable_id = vegetable.food_id
    LEFT JOIN food_data other ON mp.other_id = other.food_id;