{% macro get_month_list_from_table(table_name) %}
    {% set sql %}
        SELECT DISTINCT yearmonth as ym
        FROM {{ table_name }}
        ORDER BY ym
    {% endset %}

    {% set result = run_query(sql) %}
    {% if execute %}
        {% set months = result.columns[0].values() %}
        {{ return(months) }}
    {% else %}
        {{ return([]) }}
    {% endif %}
{% endmacro %}