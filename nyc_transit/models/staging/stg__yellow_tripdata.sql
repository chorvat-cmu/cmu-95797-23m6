with source as (

    select * from {{ source('main', 'yellow_tripdata') }}

),

renamed as (

    select
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        passenger_count::int as passenger_count,
        trip_distance,
        ratecodeid,
        store_and_fwd_flag,
        pulocationid,
        dolocationid,
        payment_type::double as payment_type,
        fare_amount::double as fare_amount,
        extra::double as extra,
        mta_tax::double as mta_tax,
        tip_amount::double as tip_amount,
        tolls_amount::double as tolls_amount,
        improvement_surcharge::double as improvement_surcharge,
        total_amount::double as total_amount,
        congestion_surcharge::double as congestion_surcharge,
        airport_fee::double as airport_fee,
        filename

    from source
    WHERE trip_distance >= 0 -- remove negative trip distances

)

select * from renamed
