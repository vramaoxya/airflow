select
        product_id as product_id,
        INITCAP(product_name) as product_name,
        brand_id as brand_id,
        category_id as category_id,
        model_year as model_year,
        coalesce(list_price,0) as list_price
from {{ source("src_local_bike", "products") }}