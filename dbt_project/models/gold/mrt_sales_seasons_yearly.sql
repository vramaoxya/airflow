------------------------------------------
{{
  config(
    alias = "sales_seasons_yearly_report"
  )
}}
------------------------------------------
WITH sales_stores_seasons AS (

  SELECT
    yeardate AS year,
    store_name AS store,
    season_name,
    ROUND(SUM(total_sales_amount), 2) AS sales_amount
  FROM {{ ref('int_src_local_bike_store_daily') }}
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