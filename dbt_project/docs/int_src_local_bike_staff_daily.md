{% docs int_src_local_bike_staff_daily %}

This model provides an aggregated view of staffs and stores. It enriches the store and staff data with the following metrics:
- **Total item Amount**: The sum of all order items for each employe.
- **Store Informations**: Enriches the store with user-specific data, such as city and state.
- **Employee Informations**: Provides a hierarchical view of employees with user-specific data, such as store_id.

It provides a comprehensive view of each store and staffs, allowing for easy analysis of store performance, employee performance and geographic.

{% enddocs %}