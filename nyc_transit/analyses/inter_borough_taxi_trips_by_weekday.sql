.echo on

-- weekday count of total trips
with total_trips as (
SELECT weekday(t.pickup_datetime) as weekday, count(*) as count_total_trips
FROM {{ ref('mart__fact_all_taxi_trips') }} t
GROUP BY weekday

)
-- weekday count of trips starting and ending in diff boroughs, joining taxis zones to get pickup and dropoff borough
, different_boroughs as (

SELECT weekday(tpu.pickup_datetime) as weekday, COUNT(*) as total_trips_diff_borough 
FROM {{ ref('mart__fact_all_taxi_trips') }} tpu
JOIN {{ ref('taxi+_zone_lookup') }} tz_tpu ON tpu.PUlocationID = tz_tpu.LocationID
JOIN {{ ref('taxi+_zone_lookup') }} tz_tdo ON tpu.DOlocationID = tz_tdo.LocationID
WHERE tz_tpu.Borough != tz_tdo.Borough
GROUP BY weekday

)

-- calc percentage
SELECT tt.weekday as weekday, tt.count_total_trips as count_total_trips, db.total_trips_diff_borough as total_trips_diff_borough, (db.total_trips_diff_borough / tt.count_total_trips) * 100 as percent_diff_borough
FROM total_trips tt
JOIN different_boroughs db ON tt.weekday = db.weekday
