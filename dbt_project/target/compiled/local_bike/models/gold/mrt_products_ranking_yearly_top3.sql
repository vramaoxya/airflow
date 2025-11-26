------------------------------------------

------------------------------------------
WITH product_sales AS (
  SELECT
    p.yeardate AS year,
    s.store_name AS store,
    p.product_name,
    p.brand_name,
    ROUND(SUM(total_item_discount_sold), 2) AS total_sales
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_product_daily` AS p
  LEFT JOIN `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_store_daily`AS s
    ON p.order_id = s.order_id 
   AND p.store_id = s.store_id
  GROUP BY year,store,product_name,brand_name
)
------------------------------------------
SELECT
  year,
  store,
  product_name,
  brand_name,
  total_sales
FROM (
  SELECT
    *,
    RANK() OVER ( PARTITION BY year, store ORDER BY total_sales DESC ) AS rank_product
  FROM product_sales
)
WHERE rank_product <= 3
ORDER BY year, store
------------------------------------------