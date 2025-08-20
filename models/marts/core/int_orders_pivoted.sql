with

payments as (

    select * from {{ref('stg_payments')}} where payment_status != 'fail'

),

pivoted as (

    select 
        order_id,
        sum(case when payment_method = 'bank_transfer' then payment_amount else 0 end) as bank_transfer_amount,
        sum(case when payment_method = 'coupon' then payment_amount else 0 end) as coupon_amount,
        sum(case when payment_method = 'credit_card' then payment_amount else 0 end) as credit_card_amount,
        sum(case when payment_method = 'gift_card' then payment_amount else 0 end) as gift_card_amount
    from payments
    group by 1
    order by 1
)

select * from pivoted