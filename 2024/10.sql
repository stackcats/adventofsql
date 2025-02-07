CREATE OR REPLACE FUNCTION find(
    hot_cocoa integer,
    eggnog integer,
    peppermint integer)
    RETURNS date AS
$$
SELECT
    date
FROM drinks
WHERE drink_name = 'Hot Cocoa'
GROUP BY date
HAVING SUM(quantity) = hot_cocoa
INTERSECT
SELECT
    date
FROM drinks
WHERE drink_name = 'Peppermint Schnapps'
GROUP BY date
HAVING SUM(quantity) = peppermint
INTERSECT
SELECT
    date
FROM drinks
WHERE drink_name = 'Eggnog'
GROUP BY date
HAVING SUM(quantity) = eggnog;
$$ LANGUAGE sql;

SELECT find(38, 198, 298);
