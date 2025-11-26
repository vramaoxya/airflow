
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`stores_ranking_yearly_report`
    
    

    OPTIONS(
      description="""This model provides **the ranking of best stores** over 3 years.\r\n\r\nIt provides a comprehensive view of each store, allowing for easy analysis of store performance."""
    )
    as (
      ------------------------------------------

------------------------------------------
SELECT
  yeardate AS year_date,
  store_name,
  store_latitude,
  store_longitude,
  ROUND(SUM(total_sales_amount), 2) AS total_sales,
  RANK() OVER (PARTITION BY yeardate ORDER BY SUM(total_sales_amount) DESC) AS store_rank
FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
GROUP BY yeardate, store_name,store_latitude,store_longitude
ORDER BY yeardate, store_rank
------------------------------------------
    );
  