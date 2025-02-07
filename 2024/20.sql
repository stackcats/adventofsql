WITH cte AS
         (SELECT url,
                 SPLIT_PART(UNNEST(STRING_TO_ARRAY(SPLIT_PART(url, '?', 2), '&')), '=', 1) params
          FROM web_requests
          WHERE url ~ 'utm_source=advent-of-sql')
SELECT url
FROM cte
GROUP BY url
ORDER BY COUNT(DISTINCT params) DESC, url
LIMIT 1;
