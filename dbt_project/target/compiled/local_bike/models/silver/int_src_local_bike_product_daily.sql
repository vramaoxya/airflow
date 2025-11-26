------------------------------------------

------------------------------------------
WITH order_items AS (
  SELECT 
        order_id as order_id,
        item_id as item_id,
        product_id as product_id,
        quantity as quantity,
        list_price as list_price,
        discount as discount,
        ROUND((discount * 100),2) as discount_percent,
        ROUND(total_item_discount_sold, 2) as total_item_discount_sold 
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_order_items`
),
------------------------------------------
orders_date AS (
  SELECT 
        order_id, 
        CAST(order_date as date) as order_date,
        store_id,
        season_name,
        EXTRACT(YEAR FROM order_date) as yeardate,
        EXTRACT(YEAR FROM order_date) || '-' || LPAD(CAST( EXTRACT(MONTH FROM order_date) AS STRING), 2, '0') AS yearmonth,
        LPAD(CAST( EXTRACT(MONTH FROM order_date) AS STRING), 2, '0') || '-' || LPAD(CAST( EXTRACT(DAY FROM order_date) AS STRING), 2, '0') AS monthday,
        LPAD(CAST( EXTRACT(MONTH FROM order_date) AS STRING), 2, '0') as month_2digits,
        FORMAT_DATE('%B', DATE(CONCAT(EXTRACT(YEAR FROM order_date), '-', EXTRACT(MONTH FROM order_date), '-01'))) AS month_name,
        FORMAT_DATE('%b', DATE(CONCAT(EXTRACT(YEAR FROM order_date), '-', EXTRACT(MONTH FROM order_date), '-01'))) AS month_abbrev,
        LPAD(CAST(EXTRACT(ISOWEEK FROM order_date) AS STRING), 2, '0') AS week_number
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_orders`
),
------------------------------------------
products AS (
  SELECT 
        product_id as product_id,
        product_name as product_name,
        brand_id as brand_id,
        category_id as category_id,
        model_year as product_model_year,
        ROUND(list_price,2) as list_price
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_products`
),
------------------------------------------
brands AS (
  SELECT 
        brand_id as brand_id,
        brand_name as brand_name
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_brands`
),
------------------------------------------
categories AS (
  SELECT 
        category_id as category_id,
        category_name as category_name
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_categories`
)
------------------------------------------
SELECT
  o.order_id,
  o.store_id,
  o.order_date,
  o.yeardate,
  o.monthday,
  o.yearmonth,
  o.month_2digits,
  o.month_name,
  o.month_abbrev,
  o.week_number,
  o.season_name,
  p.product_id,
  p.product_name,
  b.brand_name,
  c.category_name,
  oi.quantity,
  oi.list_price,
  oi.discount,
  oi.discount_percent,
  SUM(oi.total_item_discount_sold) as total_item_discount_sold,
  COUNT(*) as total_items
FROM orders_date as o
LEFT JOIN order_items as oi ON o.order_id = oi.order_id
LEFT JOIN products as p ON oi.product_id = p.product_id
LEFT JOIN brands as b ON p.brand_id = b.brand_id
LEFT JOIN categories as c ON p.category_id = c.category_id
GROUP BY 
  o.order_id,
  o.store_id,
  o.order_date,
  o.yeardate,
  o.monthday,
  o.yearmonth,
  o.month_2digits,
  o.month_name,
  o.month_abbrev,
  o.week_number,
  o.season_name, 
  p.product_id,
  p.product_name,
  b.brand_name,
  c.category_name,
  oi.quantity,
  oi.list_price,
  oi.discount,
  oi.discount_percent
ORDER BY o.yeardate, o.week_number, o.order_id