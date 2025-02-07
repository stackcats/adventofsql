WITH cte
         AS (SELECT
                 id,
                 CASE
                     WHEN XMLEXISTS('//total_count' PASSING BY REF menu_data)
                         THEN (XPATH('//total_count/text()', menu_data)::varchar[]::integer[])[1]
                     WHEN XMLEXISTS('//total_guests' PASSING BY REF menu_data)
                         THEN (XPATH('//total_guests/text()', menu_data)::varchar[]::integer[])[1]
                     WHEN XMLEXISTS('//guestCount' PASSING BY REF menu_data)
                         THEN (XPATH('//guestCount/text()', menu_data)::varchar[]::integer[])[1]
                     ELSE 0
                     END                                                      AS count,
                 UNNEST(XPATH('//food_item_id/text()', menu_data)::varchar[]) AS food_item_id
             FROM christmas_menus)
SELECT
    food_item_id
FROM cte
WHERE count > 78
GROUP BY food_item_id
ORDER BY COUNT(1) DESC
LIMIT 1;
