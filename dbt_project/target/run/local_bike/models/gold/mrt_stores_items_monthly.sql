
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`items_stores_monthly_report`
    
    

    OPTIONS(
      description="""This model provides the **total number of items sold** per store over 3 years.\r\n\r\nIt provides a comprehensive view of each store, allowing for easy analysis of store performance."""
    )
    as (
      ------------------------------------------

------------------------------------------
SELECT *
FROM (

  SELECT
    yeardate AS year,
    month_2digits as month,
    store_name,
    COUNT(total_items) AS nb_items
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
  GROUP BY year, month, store_name

)
PIVOT (

  SUM(nb_items) AS total_items
  FOR store_name IN ('Santa Cruz Bikes','Baldwin Bikes','Rowlett Bikes')

)
ORDER BY year, month
------------------------------------------
    );
  