{{ config(materialized='view') }}


with base as (

    select * 
    from {{ source('snowflake_learning_db', 'employees') }}

),

with_dob as (

    select
        *,
        -- Generate random DOB between 1970-01-01 and 2000-12-31
        dateadd(
            day,
            uniform(0, 11322, random()),  -- 11322 = days between 1970-01-01 and 2000-12-31
            to_date('1970-01-01')
        ) as dob

    from base

)

select * from with_dob
