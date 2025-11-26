

  create or replace view `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_stocks`
  OPTIONS(
      description="""Stock of products and availability."""
    )
  as select
    store_id   as store_id,
    product_id as product_id,
    quantity   as stock_quantity
from `databird-473015`.`src_local_bike`.`stocks`;

