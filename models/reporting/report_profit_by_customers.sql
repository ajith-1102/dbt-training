{{ config(materialized="table") }}

select customerid, segment, customername, country, sum(orderprofit) as profit
from {{ ref("stg_orders") }}
group by customerid, segment, customername, country
