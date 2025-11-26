

  create or replace view `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_staff_daily`
  OPTIONS(
      description="""This model provides an aggregated view of staffs and stores. It enriches the store and staff data with the following metrics:\r\n- **Total item Amount**: The sum of all order items for each employe.\r\n- **Store Informations**: Enriches the store with user-specific data, such as city and state.\r\n- **Employee Informations**: Provides a hierarchical view of employees with user-specific data, such as store_id.\r\n\r\nIt provides a comprehensive view of each store and staffs, allowing for easy analysis of store performance, employee performance and geographic."""
    )
  as ------------------------------------------

------------------------------------------
WITH staff_list AS (

  SELECT
    s.staff_id,
    s.staff_first_name,
    s.staff_last_name,
    s.manager_id,
    s.store_id,
    s.path,
    s.level
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_staff_hierarchy` s

),
------------------------------------------
sales_by_employee AS (

  SELECT
    o.order_date as order_date,
    o.season_name,
    EXTRACT(YEAR FROM o.order_date) as yeardate,
    EXTRACT(YEAR FROM o.order_date) || '-' || LPAD(CAST( EXTRACT(MONTH FROM o.order_date) AS STRING), 2, '0') AS yearmonth,
    LPAD(CAST( EXTRACT(MONTH FROM o.order_date) AS STRING), 2, '0') || '-' || LPAD(CAST( EXTRACT(DAY FROM o.order_date) AS STRING), 2, '0') AS monthday,
    LPAD(CAST( EXTRACT(MONTH FROM o.order_date) AS STRING), 2, '0') as month_2digits,
    FORMAT_DATE('%B', DATE(CONCAT(EXTRACT(YEAR FROM o.order_date), '-', EXTRACT(MONTH FROM o.order_date), '-01'))) AS month_name,
    FORMAT_DATE('%b', DATE(CONCAT(EXTRACT(YEAR FROM o.order_date), '-', EXTRACT(MONTH FROM o.order_date), '-01'))) AS month_abbrev,
    LPAD(CAST(EXTRACT(ISOWEEK FROM o.order_date) AS STRING), 2, '0') AS week_number,
    o.staff_id,
    oi.total_item_discount_sold as total_item_discount_sold
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_orders` as o
  LEFT JOIN `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_order_items` as oi ON o.order_id = oi.order_id

),
------------------------------------------
stores AS (

  SELECT store_id,
         store_name,
         store_city, 
         store_state
  FROM  `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_stores`

),
------------------------------------------
map AS (

  SELECT  
         store_id,
         city, 
         state,
         latitude as store_latitude,
         longitude as store_longitude
  FROM  `databird-473015`.`dbt_bike_seeds`.`map`

)
------------------------------------------
SELECT 
    em.order_date,
    em.yeardate,
    em.monthday,
    em.yearmonth,
    em.month_2digits,
    em.month_name,
    em.month_abbrev,
    em.week_number,
    em.season_name,
    st.store_name,
    m.store_latitude,
    m.store_longitude,    
    st.store_city,
    st.store_state,    
    ROUND(em.total_item_discount_sold, 2) as total_item_sold_staff,
    s.*
FROM sales_by_employee as em 
JOIN staff_list as s ON em.staff_id = s.staff_id
LEFT JOIN map as m on s.store_id = m.store_id
LEFT JOIN stores as st on m.store_id = st.store_id
ORDER BY em.order_date;

