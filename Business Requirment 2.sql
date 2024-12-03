SELECT 
    dim_city.city_name AS city,
    dim_date.month_name,
    COUNT(fact_trips.trip_id) AS actual_trips,
    targets_db.monthly_target_trips.total_target_trips AS target_trips,
    CASE
        WHEN COUNT(fact_trips.trip_id) > targets_db.monthly_target_trips.total_target_trips THEN 'Above Target' ELSE 'Below Target'
    END AS performance,
		round(
				((COUNT(fact_trips.trip_id) - targets_db.monthly_target_trips.total_target_trips) / 
					targets_db.monthly_target_trips.total_target_trips) * 100, 2) AS percentage_difference
FROM 
    fact_trips 
JOIN 
    dim_city ON fact_trips.city_id = dim_city.city_id
JOIN 
    dim_date ON fact_trips.date = dim_date.date
JOIN 
    targets_db.monthly_target_trips  ON fact_trips.city_id = targets_db.monthly_target_trips.city_id 
GROUP BY 
    dim_city.city_name, dim_date.month_name, targets_db.monthly_target_trips.total_target_trips
ORDER BY 
    dim_city.city_name, dim_date.month_name;
