.echo ON

SELECT
	COUNT(tx.*) AS Total_Num_Trips_No_Pickup
FROM {{ ref('mart__fact_all_taxi_trips')}} tx
LEFT JOIN {{ ref('mart__dim_locations') }} lc ON tx.PUlocationID = lc.LocationID
WHERE lc.LocationID IS NULL
