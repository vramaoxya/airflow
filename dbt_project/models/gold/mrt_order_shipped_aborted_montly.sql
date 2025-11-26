------------------------------------------
{{
  config(
    alias = "orders_shipped_aborted_monthly_report"
  )
}}
------------------------------------------

WITH total_aborted_orders AS (

  SELECT
    yearmonth AS month,
    COUNTIF(shipped_date IS NULL) AS nb_shipped_aborted,
    ROUND(SUM(total_sales_amount),2) as total_aborted_sales,
    store_name
  FROM  {{ ref('int_src_local_bike_store_daily') }}
  WHERE shipped_date is null
  GROUP BY month,store_name

)
------------------------------------------
SELECT *
FROM total_aborted_orders
------------------------------------------