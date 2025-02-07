CREATE OR REPLACE FUNCTION array_last(arr anyarray) RETURNS anyelement AS
$$
SELECT arr[ARRAY_UPPER(arr, 1)]
$$ LANGUAGE sql;


SELECT SUM(CASE
               WHEN array_last(year_end_performance_scores)
                   >= (SELECT AVG(array_last(year_end_performance_scores))
                       FROM employees) THEN salary * 1.15
               ELSE
                   salary
    END)
FROM employees;
