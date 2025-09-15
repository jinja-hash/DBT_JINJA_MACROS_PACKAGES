{% macro grant_select(schema = traget.schema, role = target.role) %}

    {% set sql %} {# EN ESTE CASO USAMOS SET ASI PARA PODER ASIGNAR TEXTO CON SALTO DE LINEAS Y DEMAS #}
        grant usage on schema {{ schema }} to {{role}}; 
        grant select on all tables in schema {{ schema }} to {{ role }}
        grant select on all views in schema {{ schema }} to {{ role }}
    {% endset %}

    {% do run_query(sql) %}

{% endmacro %}