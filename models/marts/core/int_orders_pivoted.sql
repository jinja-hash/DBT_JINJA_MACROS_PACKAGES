with

payments as (

    select * from {{ref('stg_payments')}} where payment_status != 'fail'

),

pivoted as (

    select 
        order_id,
        
        {% set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}
        {% for p_method in payment_methods -%}
            {% if not loop.last -%}
                sum(case when payment_method = '{{p_method}}' then payment_amount else 0 end) as {{p_method}}_amount,
            {% else -%}
                sum(case when payment_method = '{{p_method}}' then payment_amount else 0 end) as {{p_method}}_amount
            {% endif -%}
        {% endfor -%}
    from payments
    group by 1
    order by 1
)

select * from pivoted