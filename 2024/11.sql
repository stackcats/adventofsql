CREATE OR REPLACE FUNCTION season_to_int(season varchar) RETURNS int AS
$$
SELECT
    CASE
        WHEN $1 = 'Spring' THEN 1
        WHEN $1 = 'Summer' THEN 2
        WHEN $1 = 'Fall' THEN 3
        ELSE 4
        END;
$$ LANGUAGE sql;

SELECT
    field_name,
    harvest_year,
    season,
    ROUND(AVG(trees_harvested) OVER (
        PARTITION BY field_name, harvest_year
        ORDER BY season_to_int(season)
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS moving_average
FROM treeharvests
ORDER BY moving_average DESC
LIMIT 1;

