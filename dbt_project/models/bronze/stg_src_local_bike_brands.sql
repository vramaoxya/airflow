select
        brand_id as brand_id,
        INITCAP(brand_name) as brand_name
from {{ source('src_local_bike', 'brands') }}
