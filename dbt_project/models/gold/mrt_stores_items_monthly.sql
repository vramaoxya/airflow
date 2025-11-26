------------------------------------------
{{
  config(
    alias = "items_stores_monthly_report"
  )
}}
------------------------------------------
SELECT *
FROM (

  SELECT
    yeardate AS year,
    month_2digits as month,
    store_name,
    COUNT(total_items) AS nb_items
  FROM {{ ref('int_src_local_bike_store_daily') }}
  GROUP BY year, month, store_name

)
PIVOT (

  SUM(nb_items) AS total_items
  FOR store_name IN ({{ "'" ~ var('list_accepted_stores') | join("','") ~ "'" }})

)
ORDER BY year, month
------------------------------------------