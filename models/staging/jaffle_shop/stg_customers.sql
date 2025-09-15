{{
    config(
        schema = 'dbt_josadri'
    )
}}

-- SOURCE --

with 

customers as (

    select
        id as customer_id,
        concat(first_name," ",last_name) as full_name,
        first_name,
        last_name
    from
        {{ source('jaffle_shop', 'customers') }}
)

select * from customers