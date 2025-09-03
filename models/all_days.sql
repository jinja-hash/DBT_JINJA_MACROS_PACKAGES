
{{ config(
    materialized = 'view'
) }}

with

all_days as (
   {{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2010-01-01' as date)",
    end_date="cast('2020-12-31' as date)"
   )
}}
)

select * from all_days