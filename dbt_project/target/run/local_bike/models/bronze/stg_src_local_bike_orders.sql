

  create or replace view `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_orders`
  OPTIONS(
      description="""Order headers with key dates and statuses"""
    )
  as select
    order_id as order_id,
    customer_id as customer_id,
    order_status as order_status,
    CAST(order_date as date) as order_date,
    CAST(required_date as date) as required_date,
    CAST(shipped_date as date) as shipped_date,
    store_id as store_id,
    staff_id as staff_id,
    
    CASE
        WHEN EXTRACT(MONTH FROM order_date) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM order_date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM order_date) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM order_date) IN (9, 10, 11) THEN 'Autumn'
    END
 AS season_name
from `databird-473015`.`src_local_bike`.`orders`;

