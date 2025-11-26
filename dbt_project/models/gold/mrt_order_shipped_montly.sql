------------------------------------------
{{
  config(
    alias = "orders_shipped_monthly_report"
  )
}}
------------------------------------------

WITH total_orders AS (

  SELECT
    yearmonth AS month,
    COUNT(order_date) AS nb_order_shipped,
    ROUND(SUM(total_sales_amount),2) as total_sales,
    store_name
  FROM  {{ ref('int_src_local_bike_store_daily') }}
  WHERE shipped_date is not null
  GROUP BY month,store_name

)
------------------------------------------
SELECT *
FROM total_orders
------------------------------------------