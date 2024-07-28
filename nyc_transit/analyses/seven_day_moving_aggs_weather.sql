.echo ON

SELECT
	date,
	MIN(prcp) OVER util_window AS Min_PRCP,
	MAX(prcp) OVER util_window AS Min_PRCP,
	AVG(prcp) OVER util_window AS Avg_PRCP,
	SUM(prcp) OVER util_window AS Sum_PRCP,
	MIN(snow) OVER util_window AS Min_Snow,
	MAX(snow) OVER util_window AS Max_Snow,
	AVG(snow) OVER util_window AS Avg_Snow,
	SUM(snow) OVER util_window AS Sum_Snow
FROM {{ ref('stg__central_park_weather') }}
WINDOW util_window AS (
	ORDER BY date ASC
	RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING)
