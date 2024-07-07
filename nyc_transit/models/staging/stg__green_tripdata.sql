with source as (

    select * from {{ source('main', 'green_tripdata') }}

),

renamed as (

    select
        vendorid,
        lpep_pickup_datetime,
        lpep_dropoff_datetime,
        store_and_fwd_flag,
        ratecodeid,
        pulocationid,
        dolocationid,
        passenger_count::int as passenger_count,
        trip_distance::double as trip_distance,
        fare_amount::double as fare_amount,
        extra::double as extra,
        mta_tax::double as mta_tax,
        tip_amount::double as tip_amount,
        tolls_amount::double as tolls_amount,
        --ehail_fee, only contains NULL values
        improvement_surcharge::double as improvement_surcharge,
        total_amount::double as total_amount,
        payment_type,
        trip_type,
        congestion_surcharge::double as congestion_surcharge,
        filename

    from source
	WHERE trip_distance >= 0 -- remove negative trip distances

)

select * from renamed
