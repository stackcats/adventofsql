SELECT
    c.name
FROM gifts g
         LEFT JOIN children c ON c.child_id = g.child_id
WHERE price > (SELECT SUM(price) / COUNT(1) FROM gifts)
ORDER BY price 
