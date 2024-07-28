.echo ON

SELECT *
FROM {{ ref('events') }}
QUALIFY ROW_NUMBER()
	OVER (PARTITION BY event_id
				ORDER BY insert_timestamp DESC) = 1
