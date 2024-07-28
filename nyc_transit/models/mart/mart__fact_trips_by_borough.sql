SELECT
	lc.Borough AS Borough,
	COUNT(*) AS Trips
FROM {{ ref('mart__fact_all_taxi_trips') }} tx
JOIN {{ ref('mart__dim_locations') }} lc ON tx.PUlocationID = lc.LocationID
GROUP BY lc.Borough
