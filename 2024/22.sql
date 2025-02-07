WITH cte AS
         (SELECT id,
                 UNNEST(STRING_TO_ARRAY(skills, ',')) AS skill
          FROM elves)
SELECT COUNT(DISTINCT id)
FROM cte
WHERE skill = 'SQL';

