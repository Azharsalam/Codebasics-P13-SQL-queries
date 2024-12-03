SELECT
    dim_city.city_name,
    ROUND(SUM(CASE WHEN p.trip_count = 2 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "2_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 3 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "3_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 4 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "4_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 5 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "5_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 6 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "6_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 7 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "7_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 8 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "8_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 9 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "9_trips",
    ROUND(SUM(CASE WHEN p.trip_count = 10 THEN p.repeat_passenger_count ELSE 0 END) / MAX(p.total_repeat_passengers) * 100, 2) AS "10_trips"
FROM (
    SELECT
        city_id,
        trip_count,
        repeat_passenger_count,
        SUM(repeat_passenger_count) OVER (PARTITION BY city_id) AS total_repeat_passengers
    FROM dim_repeat_trip_distribution
    WHERE trip_count BETWEEN 2 AND 10
) AS p
JOIN dim_city
ON dim_city.city_id = p.city_id
GROUP BY dim_city.city_name
ORDER BY dim_city.city_name;
