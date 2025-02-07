WITH cte AS (SELECT id, LAG(id) OVER (ORDER BY id) prev
             FROM sequence_table)
SELECT prev + 1 gap_start,
       id - 1   gap_end,
       (SELECT ARRAY_AGG(num) FROM GENERATE_SERIES(prev + 1, id - 1) num)
FROM cte
WHERE id - 1 != prev;
