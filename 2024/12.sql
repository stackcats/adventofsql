WITH cte AS
         (SELECT
              gift_id,
              COUNT(1) ct
          FROM gift_requests
          GROUP BY gift_id)
SELECT DISTINCT ON (pr)
    gift_name,
    ROUND(PERCENT_RANK() OVER ( ORDER BY ct)::numeric, 2) pr
FROM cte
         LEFT JOIN gifts ON cte.gift_id = gifts.gift_id
ORDER BY pr DESC, gift_name
LIMIT 2;
