.echo on

SELECT 
	tz.service_zone as "Service Zone",
	count(*) as "Total Trips Ending"
FROM
	{{ ref('mart__fact_all_taxi_trips') }} tdo
JOIN
	{{ ref('taxi+_zone_lookup') }} tz
ON
	tdo.DOlocationID = tz.LocationID
WHERE -- Filter rows where service_zone not 'Airports' or 'EWR'
	tz.service_zone in ('Airports', 'EWR')
GROUP BY
	tz.service_zone
