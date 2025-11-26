
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`sales_seasons_yearly_report`
    
    

    OPTIONS(
      description="""This model provides the **top-performing store by season** and per year over 3 years.\r\n\r\nIt provides a comprehensive view of each store, allowing for easy analysis of store performance."""
    )
    as (
      ------------------------------------------

------------------------------------------
WITH sales_stores_seasons AS (

  SELECT
    yeardate AS year,
    store_name AS store,
    season_name,
    ROUND(SUM(total_sales_amount), 2) AS sales_amount
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
  GROUP BY year,store,season_name

)

SELECT *
FROM sales_stores_seasons
PIVOT (
  SUM(sales_amount) AS sales
  FOR season_name IN ('Winter','Spring','Summer','Autumn')
)
ORDER BY year, store
------------------------------------------
    );
  