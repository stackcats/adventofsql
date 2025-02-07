CREATE OR REPLACE FUNCTION inter(a1 anyarray, a2 anyarray)
    RETURNS anyarray AS
$$
SELECT
    ARRAY(
            SELECT UNNEST($1) INTERSECT ALL SELECT UNNEST($2)
    );
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION diff(a1 anyarray, a2 anyarray)
    RETURNS anyarray AS
$$
SELECT
    ARRAY(
            SELECT UNNEST($1) EXCEPT ALL SELECT UNNEST($2)
    );
$$ LANGUAGE sql;


SELECT
    toy_id,
    ARRAY_LENGTH(diff(new_tags, previous_tags), 1)  AS added_tags,
    ARRAY_LENGTH(inter(previous_tags, new_tags), 1) AS unchanged_tags,
    ARRAY_LENGTH(diff(previous_tags, new_tags), 1)  AS removed_tags
FROM toy_production
ORDER BY added_tags DESC NULLS LAST
LIMIT 1;
