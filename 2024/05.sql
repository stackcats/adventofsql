SELECT
    t.production_date                                                       production_date,
    t.toys_produced                                                         toys_produced,
    p.toys_produced                                                         previous_day_production,
    t.toys_produced - p.toys_produced                                       production_change,
    ROUND((t.toys_produced - p.toys_produced) * 100.0 / p.toys_produced, 2) production_change_percentage
FROM toy_production t
         LEFT JOIN toy_production p ON t.production_date = p.production_date + 1
ORDER BY production_change_percentage DESC NULLS LAST
