
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`sales_stores_monthly_report`
    
    

    OPTIONS(
      description="""This model provides **top sales by store** over 3 years.\r\n\r\nIt provides a comprehensive view of each store, allowing for easy analysis of store performance."""
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
    ROUND(SUM(total_sales_amount), 2) AS sales_items
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
  GROUP BY year, month, store_name

)
PIVOT (

  SUM(sales_items) AS total_sales
  FOR store_name IN ('Santa Cruz Bikes','Baldwin Bikes','Rowlett Bikes')

)
ORDER BY year, month
------------------------------------------
    );
  