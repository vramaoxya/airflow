SELECT
  order_id as order_id,
  item_id AS item_id,
  product_id as product_id,
  quantity as quantity,
  list_price as list_price,
  discount as discount,
  {{ calculate_total_order_item_amount('list_price','quantity','discount') }} AS total_item_discount_sold
FROM {{ source("src_local_bike", "order_items") }}