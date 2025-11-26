select
        category_id as category_id,
        INITCAP(category_name) as category_name
from {{ source('src_local_bike', 'categories') }}