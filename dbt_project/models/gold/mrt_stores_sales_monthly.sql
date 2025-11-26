------------------------------------------
{{
  config(
    alias = "sales_stores_monthly_report"
  )
}}
------------------------------------------
SELECT *
FROM (

  SELECT
    yeardate AS year,
    month_2digits as month,
    store_name,
    ROUND(SUM(total_sales_amount), 2) AS sales_items
  FROM {{ ref('int_src_local_bike_store_daily') }}
  GROUP BY year, month, store_name

)
PIVOT (

  SUM(sales_items) AS total_sales
  FOR store_name IN ({{ "'" ~ var('list_accepted_stores') | join("','") ~ "'" }})

)
ORDER BY year, month
------------------------------------------