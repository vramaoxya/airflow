------------------------------------------
{{
  config(
    alias = "staffs_sales_monthly_report"
  )
}}
------------------------------------------
{% set month_list = get_month_list_from_table(ref('int_src_local_bike_staff_daily')) %}
{% set month_list_str = month_list | map('string') | join("','") %}
------------------------------------------
SELECT *
FROM (

  SELECT
    staff_first_name || '-' || staff_last_name AS staff_name,
    yearmonth AS month,
    ROUND(SUM(total_item_sold_staff), 2 ) AS total_items
  FROM {{ ref('int_src_local_bike_staff_daily') }}
  GROUP BY month, staff_name

)
PIVOT (

  SUM(total_items) AS sales
  FOR month IN ( '{{ month_list_str }}' )

)
ORDER BY staff_name
------------------------------------------