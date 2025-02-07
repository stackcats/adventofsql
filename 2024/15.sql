SELECT
    place_name
FROM areas AS a,
     sleigh_locations AS b
WHERE ST_Intersects(a.polygon, b.coordinate)
