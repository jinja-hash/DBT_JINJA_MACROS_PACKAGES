{% macro union_table_by_prefix(database, schema, prefix) %}
    {% set table = dbt_utils.get_relations_by_prefix(database = database, schema = schema, prefix = prefix) -%}
    {% for t in table -%}
        {% if not loop.last -%}
            select * from {{t.database}}.{{t.schema}}.{{t.name}} union all
        {% else %}
            select * from {{t.database}}.{{t.schema}}.{{t.name}}
        {% endif -%}
    {% endfor -%}
{% endmacro -%}