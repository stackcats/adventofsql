-- ERROR: time zone "Europe/Kyiv" not recognized
UPDATE workshops
SET timezone = 'Europe/Kiev'
WHERE timezone = 'Europe/Kyiv';

SELECT
        business_start_time AT TIME ZONE 'UTC'
        + ((business_start_time AT TIME ZONE 'UTC')::time -
           (business_start_time AT TIME ZONE timezone)::time)::interval
        meeting_start_utc
FROM workshops
ORDER BY meeting_start_utc DESC
LIMIT 1;
