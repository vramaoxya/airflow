select
    CAST(staff_id AS int) as staff_id,
    INITCAP(first_name) as staff_first_name,
    INITCAP(last_name) as staff_last_name,
    phone as staff_phone,
    email as staff_email,
    active as staff_active,
    store_id as store_id,
    CAST(manager_id AS int)  as manager_id
from `databird-473015`.`src_local_bike`.`staffs`