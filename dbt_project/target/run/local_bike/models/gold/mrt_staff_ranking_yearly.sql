
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`ranking_sales_staffs_yearly_top3_report`
    
    

    OPTIONS(
      description="""This model provides **Top seller** per store and per year over 3 years.\r\n\r\nIt provides a comprehensive view of each seller, allowing for easy analysis of seller performance."""
    )
    as (
      ------------------------------------------

------------------------------------------
WITH sales_staffs_stores AS (

  SELECT
    yeardate AS year,
    staff_first_name || '-' || staff_last_name || ' ('|| store_name || ')' AS staff_name,
    ROUND(SUM(total_item_sold_staff), 2) AS total_sales
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_staff_daily`
  GROUP BY year, staff_name

)
SELECT
  year,
  staff_name,
  total_sales
FROM (
  SELECT
    *,
    RANK() OVER (PARTITION BY year ORDER BY total_sales DESC) AS rank_sales
  FROM sales_staffs_stores
)
WHERE rank_sales <= 3 
ORDER BY year, total_sales
    );
  