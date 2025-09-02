with

payments as (

    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        {{ cents_to_dollars("amount","5") }} as payment_amount,
        created
    from
        {{source('stripe','payments')}} 
)

select * from payments