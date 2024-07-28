.echo ON

SELECT
yl.fare_amount AS Fare_Amt,
AVG(yl.fare_amount) 
	OVER() AS Avg_Fare,
lc.Borough AS Borough,
AVG(yl.fare_amount) 
	OVER(PARTITION BY lc.Borough) AS Avg_Borough_Fare,
lc.Zone AS Zone,
AVG(yl.fare_amount) 
	OVER(PARTITION BY lc.Zone) AS Avg_Zone_Fare
FROM {{ ref('stg__yellow_tripdata') }} yl
JOIN {{ ref('mart__dim_locations') }} lc ON yl.PUlocationID = lc.LocationID
GROUP BY yl.fare_amount, lc.Borough, lc.Zone
ORDER BY Borough, Zone
-- Instructions indicate a large file so imposing a limit on row returns
LIMIT 100
