{% macro calculate_total_order_item_amount(price_column, quantity_column, discount_column) %}
    {{price_column}} * {{quantity_column}} * ( 1 - {{discount_column}} )
{% endmacro %}