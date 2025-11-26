
  
    

    create or replace table `databird-473015`.`dbt_bike_gold`.`staffs_sales_monthly_report`
    
    

    OPTIONS(
      description="""This model provides the **best-seller** per month over 3 years.\r\n\r\nIt provides a comprehensive view of each seller, allowing for easy analysis of sellers performance."""
    )
    as (
      ------------------------------------------

------------------------------------------


------------------------------------------
SELECT *
FROM (

  SELECT
    staff_first_name || '-' || staff_last_name AS staff_name,
    yearmonth AS month,
    ROUND(SUM(total_item_sold_staff), 2 ) AS total_items
  FROM `databird-473015`.`dbt_bike_silver`.`int_src_local_bike_staff_daily`
  GROUP BY month, staff_name

)
PIVOT (

  SUM(total_items) AS sales
  FOR month IN ( '2016-01','2016-02','2016-03','2016-04','2016-05','2016-06','2016-07','2016-08','2016-09','2016-10','2016-11','2016-12','2017-01','2017-02','2017-03','2017-04','2017-05','2017-06','2017-07','2017-08','2017-09','2017-10','2017-11','2017-12','2018-01','2018-02','2018-03','2018-04','2018-06','2018-07','2018-08','2018-09','2018-10','2018-11','2018-12' )

)
ORDER BY staff_name
------------------------------------------
    );
  