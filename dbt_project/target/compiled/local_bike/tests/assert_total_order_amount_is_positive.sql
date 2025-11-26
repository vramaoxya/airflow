-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where total_amount < 0 to make the test fail
select
    order_id,
    sum(total_item_discount_sold) as total_amount  
from `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_order_items`
group by 1
having total_amount < 0