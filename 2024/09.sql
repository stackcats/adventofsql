WITH cte AS (SELECT
                 t.reindeer_id,
                 AVG(speed_record) avg_speed
             FROM training_sessions t
             GROUP BY t.reindeer_id, t.exercise_name)
SELECT
    r.reindeer_name,
    ROUND(MAX(avg_speed), 2) top_speed
FROM cte
         LEFT JOIN reindeers r ON r.reindeer_id = cte.reindeer_id
WHERE r.reindeer_name NOT IN ('Rudolph', 'Rudolf')
GROUP BY r.reindeer_name
ORDER BY top_speed DESC
LIMIT 3;
