.echo ON

-- First will calculate the difference in time between pickup_datetimes using LEAD
WITH Time_Diff AS (
SELECT
	lc.Zone,
	tx.pickup_datetime,
	LEAD(tx.pickup_datetime) OVER (PARTITION BY lc.Zone ORDER BY tx.pickup_datetime ASC) AS NZ_Pickup,
	DATEDIFF('minute', tx.pickup_datetime, NZ_Pickup) AS Diff_Time
FROM {{ ref('mart__fact_all_taxi_trips') }} tx
JOIN {{ ref('mart__dim_locations') }} lc ON tx.PUlocationID = lc.LocationID
)

-- Then average the 'Diff_Time' values from the Time_Diff CTE
SELECT
	Zone,
	AVG(Diff_Time) AS Avg_Time_Between_Pickups
FROM Time_Diff
GROUP BY 1
ORDER BY 1
