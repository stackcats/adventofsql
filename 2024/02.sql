SELECT
    STRING_AGG(v, '')
FROM (SELECT
          id,
          CHR(value) AS v
      FROM letters_a
      UNION ALL
      SELECT
          id,
          CHR(value) AS v
      FROM letters_b)
WHERE v ~ '[-a-zA-Z\s(),\.\!:;\?"'']'
