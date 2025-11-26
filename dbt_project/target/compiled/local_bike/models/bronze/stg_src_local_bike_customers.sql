select
    customer_id as customer_id,
    INITCAP(first_name) as customer_first_name,
    INITCAP(last_name) as customer_last_name,
    phone as customer_phone,
    email as customer_email,
    INITCAP(street) as customer_street,
    INITCAP(city) as customer_city,
    UPPER(state) as customer_state,
    zip_code as customer_zip_code
from `databird-473015`.`src_local_bike`.`customers`