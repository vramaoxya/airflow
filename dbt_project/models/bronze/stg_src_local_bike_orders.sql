select
    order_id as order_id,
    customer_id as customer_id,
    order_status as order_status,
    CAST(order_date as date) as order_date,
    CAST(required_date as date) as required_date,
    CAST(shipped_date as date) as shipped_date,
    store_id as store_id,
    staff_id as staff_id,
    {{ get_southern_season( 'order_date' ) }} AS season_name
from {{ source("src_local_bike", "orders") }}