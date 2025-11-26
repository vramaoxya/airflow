SELECT
  order_id as order_id,
  item_id AS item_id,
  product_id as product_id,
  quantity as quantity,
  list_price as list_price,
  discount as discount,
  
    list_price * quantity * ( 1 - discount )
 AS total_item_discount_sold
FROM `databird-473015`.`src_local_bike`.`order_items`