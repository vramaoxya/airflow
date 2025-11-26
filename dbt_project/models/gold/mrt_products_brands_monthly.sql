------------------------------------------
{{
  config(
    alias = "products_brands_monthly_report"
  )
}}
------------------------------------------
{% set month_list = get_month_list_from_table(ref('int_src_local_bike_staff_daily')) %}
{% set month_list_str = month_list | map('string') | join("','") %}
------------------------------------------
SELECT *
FROM (

  SELECT
    yearmonth AS month,
    brand_name as Brand,    
    ROUND(SUM(total_item_discount_sold), 2 ) AS total_sales
  FROM {{ ref('int_src_local_bike_product_daily') }}
  GROUP BY month, brand

)
PIVOT (

  SUM(total_sales) AS sales
  FOR month IN ( '{{ month_list_str }}' )

)
ORDER BY Brand
------------------------------------------