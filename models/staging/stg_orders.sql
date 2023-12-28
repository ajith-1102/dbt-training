{{ config(materialized="table") }}

select
    -- from orders
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    o.ordercostprice,
    o.ordersellingprice,
    o.ordersellingprice - o.ordercostprice as orderprofit,
    -- -from customers
    c.customerid,
    c.segment,
    c.customername,
    c.country,
    -- from product
    p.productid,
    p.productname,
    p.category,
    p.subcategory
from {{ ref("raw_orders") }} as o
left join {{ ref("raw_customers") }} as c on o.customerid = c.customerid
left join {{ ref("raw_product") }} as p on o.productid = p.productid
