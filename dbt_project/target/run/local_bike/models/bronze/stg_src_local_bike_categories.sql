

  create or replace view `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_categories`
  OPTIONS(
      description="""Product categories such as road, mountain, and electric bikes."""
    )
  as select
        category_id as category_id,
        INITCAP(category_name) as category_name
from `databird-473015`.`src_local_bike`.`categories`;

