.echo ON

SELECT
	lc.Zone,
	COUNT(*) AS Trips
FROM {{ ref('mart__fact_all_taxi_trips') }} tx
JOIN {{ ref('mart__dim_locations') }} lc ON tx.PUlocationID = lc.LocationID
GROUP BY ALL
HAVING Trips <100000
ORDER BY 2
