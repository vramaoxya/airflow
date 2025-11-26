

  create or replace view `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_staff_hierarchy`
  OPTIONS(
      description="""This model provides an hirarchical view of employees. It enriches the store data with the following data:\r\n- **Employee Informations**: Provides a hierarchical view of employees with user-specific data, such as store_id.\r\n\r\nIt provides a comprehensive view of each employe.."""
    )
  as ------------------------------------------
  WITH RECURSIVE staff_hierarchy AS (

  -- Niveau 0 : managers racine
  SELECT
    m.staff_id,
    m.staff_first_name,
    m.staff_last_name,
    m.manager_id,
    m.store_id,
    m.staff_first_name || ' ' || m.staff_last_name AS path,
    0 AS level
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_staffs` m
  WHERE m.manager_id IS NULL

  UNION ALL

  -- Niveaux suivants : rattacher les subordonnés
  SELECT
    s.staff_id,
    s.staff_first_name,
    s.staff_last_name,
    s.manager_id,
    s.store_id,    
    CONCAT(h.path, ' → ', s.staff_first_name, ' ', s.staff_last_name) AS path,
    h.level + 1 AS level
  FROM `databird-473015`.`dbt_bike_bronze`.`stg_src_local_bike_staffs` s
  JOIN staff_hierarchy as h ON s.manager_id = h.staff_id
  
)
------------------------------------------
SELECT 
     * 
FROM staff_hierarchy
ORDER BY path, level;

