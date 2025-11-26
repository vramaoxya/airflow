{% macro get_southern_season(date_column) %}
    CASE
        WHEN EXTRACT(MONTH FROM {{ date_column }}) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH FROM {{ date_column }}) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH FROM {{ date_column }}) IN (6, 7, 8) THEN 'Summer'
        WHEN EXTRACT(MONTH FROM {{ date_column }}) IN (9, 10, 11) THEN 'Autumn'
    END
{% endmacro %}
