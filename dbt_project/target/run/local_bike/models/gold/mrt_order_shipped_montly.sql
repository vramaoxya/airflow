
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`orders_shipped_monthly_report`
    
    

    OPTIONS(
      description="""This model provides an aggregated view of the orders sent. It enriches the order data with the following metrics:\r\n- **nb_order_shipped**: The quantity of orders shipped.\r\n- **total_sales**: The cost of orders shipped.\r\n- **Order Informations**: Enriches the product with user-specific data, such as store name.\r\n\r\nIt provides a comprehensive view the aborted order, allowing for easy analysis of order performance."""
    )
    as (
      ------------------------------------------

------------------------------------------

WITH total_orders AS (

  SELECT
    yearmonth AS month,
    COUNT(order_date) AS nb_order_shipped,
    ROUND(SUM(total_sales_amount),2) as total_sales,
    store_name
  FROM  `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
  WHERE shipped_date is not null
  GROUP BY month,store_name

)
------------------------------------------
SELECT *
FROM total_orders
------------------------------------------
    );
  