------------------------------------------

------------------------------------------
SELECT *
FROM (

  SELECT
    yeardate AS year,
    month_2digits as month,
    store_name,
    COUNT(total_items) AS nb_items
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`
  GROUP BY year, month, store_name

)
PIVOT (

  SUM(nb_items) AS total_items
  FOR store_name IN ('Santa Cruz Bikes','Baldwin Bikes','Rowlett Bikes')

)
ORDER BY year, month
------------------------------------------