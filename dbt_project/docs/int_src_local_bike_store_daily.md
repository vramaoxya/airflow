{% docs int_src_local_bike_store_daily %}

This model provides an aggregated view of stores. It enriches the store data with the following metrics:
- **Total Order Amount**: The sum of all order items for each store.
- **Total Items**: The quantity of items in the store.
- **Total Distinct Items**: The count of distinct product types in the order.
- **Store Informations**: Enriches the store with user-specific data, such as city and state.

It provides a comprehensive view of each store, allowing for easy analysis of store performance and geographic.

{% enddocs %}