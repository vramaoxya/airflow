

  create or replace view `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_products`
  OPTIONS(
      description="""Products sold, linked to brands and categories."""
    )
  as select
        product_id as product_id,
        INITCAP(product_name) as product_name,
        brand_id as brand_id,
        category_id as category_id,
        model_year as model_year,
        coalesce(list_price,0) as list_price
from `databird-473015`.`src_local_bike`.`products`;

