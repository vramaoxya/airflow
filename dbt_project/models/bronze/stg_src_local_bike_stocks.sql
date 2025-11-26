select
    store_id   as store_id,
    product_id as product_id,
    quantity   as stock_quantity
from {{ source('src_local_bike', 'stocks') }}
