WITH cte as
    (SELECT EXTRACT(YEAR FROM sale_date) as year,
            EXTRACT(QUARTER FROM sale_date) as quarter,
            amount
             FROM sales
)
SELECT year, quarter, sum(amount) /  lag(sum(amount)) OVER (ORDER BY year, quarter) rate
from cte
GROUP BY year, quarter
ORDER BY rate desc NULLS LAST
LIMIT 1;

