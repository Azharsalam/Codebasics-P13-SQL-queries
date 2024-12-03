SELECT 
    city_name AS city,
    COUNT(trip_id) AS total_trips,
    ROUND(AVG(fare_amount / distance_travelled_km), 2) AS avg_fare_per_km,
    ROUND(AVG(fare_amount), 2) AS avg_fare_per_trip,
    ROUND(
          (COUNT(trip_id) * 100.0 / 
          (SELECT COUNT(*) FROM fact_trips)), 2
		) AS percentage_contribution
FROM 
    fact_trips 
JOIN 
    dim_city  ON dim_city.city_id = fact_trips.city_id
GROUP BY 
    dim_city.city_name
ORDER BY 
    total_trips DESC;