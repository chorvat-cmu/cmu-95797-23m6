.echo ON

SELECT
   date,
   prcp,
   AVG(prcp) OVER (ORDER BY date ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING) as Seven_Day_Avg_Prcp
FROM {{ ref('stg__central_park_weather') }}
