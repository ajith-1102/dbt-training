select
    -- from orders
    {{ dbt_utils.generate_surrogate_key(['o.orderid','c.customerid','p.productid']) }} as sk_order_key,
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
    p.subcategory,
    {{markup('ordersellingprice','ordercostprice')}} as markup,
    d.delivery_team as delivery_team
from {{ ref("raw_orders") }} as o
left join {{ ref("raw_customers") }} as c on o.customerid = c.customerid
left join {{ ref("raw_product") }} as p on o.productid = p.productid
left join {{ ref("delivery_team") }} as d on o.shipmode=d.shipmode
{{limit_data_in_dev(orderdate)}}