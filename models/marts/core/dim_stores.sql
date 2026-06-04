-- models/marts/core/dim_stores.sql
SELECT
    store_id,
    store_name,
    region,
    manager_email,
    loaded_at
FROM {{ ref('stg_stores') }}