------------------------------------------

------------------------------------------
SELECT
  yeardate AS year_date,
  store_name,
  store_latitude,
  store_longitude,
  ROUND(SUM(total_sales_amount), 2) AS total_sales,
  RANK() OVER (PARTITION BY yeardate ORDER BY SUM(total_sales_amount) DESC) AS store_rank
FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
GROUP BY yeardate, store_name,store_latitude,store_longitude
ORDER BY yeardate, store_rank
------------------------------------------