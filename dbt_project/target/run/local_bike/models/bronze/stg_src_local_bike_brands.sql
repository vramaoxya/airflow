

  create or replace view `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_brands`
  OPTIONS(
      description="""Bike brands sold by Local Bike."""
    )
  as select
        brand_id as brand_id,
        INITCAP(brand_name) as brand_name
from `databird-473015`.`src_local_bike`.`brands`;

