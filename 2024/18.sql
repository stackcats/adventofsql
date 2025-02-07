CREATE OR REPLACE FUNCTION leaders(id integer) RETURNS integer[] AS
$$
WITH RECURSIVE cte AS
                   (SELECT staff_id,
                           manager_id
                    FROM staff
                    WHERE staff_id = $1
                    UNION
                    SELECT staff.staff_id,
                           staff.manager_id
                    FROM staff
                             JOIN cte ON cte.manager_id = staff.staff_id)

SELECT ARRAY_AGG(staff_id ORDER BY staff_id)
FROM cte;
$$ LANGUAGE sql;

WITH cte AS (SELECT staff_id,
                    staff_name,
                    ARRAY_LENGTH(leaders(staff_id), 1) AS level,
                    leaders(staff_id)                     path,
                    manager_id
             FROM staff)
SELECT c.*,
       m.ct peers_same_manager,
       l.ct total_peers_same_level
FROM cte c
         LEFT JOIN (SELECT manager_id, COUNT(1) ct
                    FROM staff
                    GROUP BY manager_id) m ON m.manager_id = c.manager_id
         LEFT JOIN (SELECT level, COUNT(1) ct
                    FROM cte
                    GROUP BY level) l ON l.level = c.level
ORDER BY l.ct DESC, c.level, c.staff_id;
