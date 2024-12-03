SELECT
    dc.city_name,
    MONTHNAME(fps.month) AS month,
    SUM(fps.total_passengers) AS total_passengers,
    (SUM(fps.repeat_passengers) / SUM(fps.total_passengers)) * 100 AS monthly_repeat_passenger_rate,
    city_totals.city_repeat_passenger_rate
FROM
    fact_passenger_summary AS fps
JOIN dim_city AS dc
    ON fps.city_id = dc.city_id
JOIN (
    SELECT
        city_id,
        SUM(total_passengers) AS total_passengers,
        SUM(repeat_passengers) AS total_repeat_passengers,
        (SUM(repeat_passengers) / SUM(total_passengers)) * 100 AS city_repeat_passenger_rate
    FROM
        fact_passenger_summary
    GROUP BY
        city_id
) AS city_totals
    ON fps.city_id = city_totals.city_id
GROUP BY
    dc.city_name, MONTHNAME(fps.month), city_totals.city_repeat_passenger_rate
ORDER BY
    dc.city_name, MONTHNAME(fps.month);
