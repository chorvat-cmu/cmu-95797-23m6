.echo on

SELECT
	lc.Borough AS Borough,
	lc.Zone AS Zone,
	COUNT(*) AS Trip_Count,
	AVG(tx.duration_min) AS Average_Duration
FROM {{ ref('mart__fact_all_taxi_trips') }} tx
JOIN {{ ref('mart__dim_locations') }} lc ON tx.PUlocationID = lc.LocationID
GROUP BY all
ORDER BY 1, 2
