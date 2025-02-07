SELECT
    children.name,
    wishes ->> 'first_choice'             AS primary_wish,
    wishes ->> 'second_choice'            AS second_wish,
    wishes -> 'colors' ->> 0              AS favorite_color,
    JSON_ARRAY_LENGTH(wishes -> 'colors') AS color_count,
    CASE
        WHEN toy_catalogue.difficulty_to_make = 1 THEN 'Simple Gift'
        WHEN toy_catalogue.difficulty_to_make = 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
        END                               AS gift_complexity,
    CASE
        WHEN toy_catalogue.category = 'outdoor' THEN 'Outside Workshop'
        WHEN toy_catalogue.category = 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
        END                               AS workshop_assignment
FROM wish_lists
         LEFT JOIN children ON wish_lists.child_id = children.child_id
         LEFT JOIN toy_catalogue ON toy_catalogue.toy_name = wishes ->> 'first_choice'
ORDER BY children.name
LIMIT 5;
