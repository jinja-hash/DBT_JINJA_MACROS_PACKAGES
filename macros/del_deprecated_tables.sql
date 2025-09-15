{%- macro del_deprecate_table(date, db = target.database, schema = target.schema) -%}

    {%- set query -%}

        SELECT
            table_name,
            FORMAT_TIMESTAMP('%Y-%m-%d', creation_time) AS creation_time,
            table_type
        FROM
            `{{ db }}.{{ schema }}`.INFORMATION_SCHEMA.TABLES

    {% endset -%}

    {%- if execute -%}
        
        {%- set information_table = run_query(query) -%} 
        {% set information_rows = information_table.rows -%}

        {%- for row in information_rows -%}
        
            {%- if row['creation_time'] < date -%}
            
                {%- if row['table_type'] == 'VIEW' -%}

                    {%- set drop_query -%}
                        DROP VIEW `{{ db }}.{{ schema }}`.{{row['table_name']}}
                    {% endset -%}

                {%- else -%}
                    
                    {%- set drop_query -%}
                        DROP TABLE `{{ db }}.{{ schema }}`.{{row['table_name']}}
                    {% endset -%}

                {%- endif -%}

                {% do run_query(drop_query) %}

                {{ log("Se eliminará: " ~ drop_query, info=true) }}
            
            {%- endif -%}
        
        {%- endfor -%}
    
    {%- endif -%}

{%- endmacro -%}
