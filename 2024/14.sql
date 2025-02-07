SELECT
    record ->> 'drop_off'
FROM (SELECT JSONB_ARRAY_ELEMENTS(cleaning_receipts) record FROM santarecords) t
WHERE record ->> 'color' = 'green'
  AND record ->> 'garment' = 'suit'
ORDER BY record ->> 'drop_off' DESC
LIMIT 1
