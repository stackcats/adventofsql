SELECT
    a.place_name
FROM areas AS a,
     sleigh_locations AS b
WHERE ST_Intersects(a.polygon, b.coordinate)
GROUP BY a.place_name
ORDER BY MAX(b.timestamp) - MIN(b.timestamp) DESC
LIMIT 1
