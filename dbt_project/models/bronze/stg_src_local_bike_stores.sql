select
    store_id as store_id,
    INITCAP(store_name) as store_name,
    phone as store_phone,
    email as store_email,
    street as store_street,
    INITCAP(city) as store_city,
    UPPER(state) as store_state,
    zip_code as store_zip_code
from {{ source("src_local_bike", "stores") }}
