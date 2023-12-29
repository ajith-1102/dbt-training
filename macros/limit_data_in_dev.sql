{% macro limit_data_in_dev(columnname) %}
    {% if target.name == 'development' %}
        where columnname >= dateadd(columnname,-30,current_date)
    {% endif %}
{% endmacro %}