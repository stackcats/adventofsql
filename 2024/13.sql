SELECT
    SPLIT_PART(email, '@', 2) as domain
FROM (SELECT UNNEST(email_addresses) email FROM contact_list) t
GROUP BY SPLIT_PART(email, '@', 2)
ORDER BY count(1) DESC
LIMIT 1

