
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`orders_shipped_aborted_monthly_report`
    
    

    OPTIONS(
      description="""This model provides an aggregated view of the canceled orders. It enriches the order data with the following metrics:\r\n- **nb_shipped_aborted**: The quantity of order aborted.\r\n- **total_aborted_sales**: The cost of aborted orders.\r\n- **Order Informations**: Enriches the product with user-specific data, such as store name.\r\n\r\nIt provides a comprehensive view the aborted order, allowing for easy analysis of order performance."""
    )
    as (
      ------------------------------------------

------------------------------------------

WITH total_aborted_orders AS (

  SELECT
    yearmonth AS month,
    COUNTIF(shipped_date IS NULL) AS nb_shipped_aborted,
    ROUND(SUM(total_sales_amount),2) as total_aborted_sales,
    store_name
  FROM  `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
  WHERE shipped_date is null
  GROUP BY month,store_name

)
------------------------------------------
SELECT *
FROM total_aborted_orders
------------------------------------------
    );
  