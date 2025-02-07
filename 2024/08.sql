CREATE OR REPLACE FUNCTION leaders(id integer) RETURNS integer[] AS
$$
WITH RECURSIVE cte AS
                   (SELECT
                        staff_id,
                        staff_name,
                        manager_id
                    FROM staff
                    WHERE staff_id = $1
                    UNION
                    SELECT
                        staff.staff_id,
                        staff.staff_name,
                        staff.manager_id
                    FROM staff
                             JOIN cte ON cte.manager_id = staff.staff_id)
SELECT
    ARRAY_AGG(staff_id ORDER BY staff_id)
FROM cte
$$ LANGUAGE sql;

SELECT
    staff_id,
    staff_name,
    ARRAY_LENGTH(leaders(staff_id), 1) AS level,
    leaders(staff_id)
FROM staff
ORDER BY level DESC
LIMIT 1;

