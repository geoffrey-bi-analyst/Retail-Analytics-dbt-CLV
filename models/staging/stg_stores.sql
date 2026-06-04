-- models/staging/stg_stores.sql
SELECT
    CAST(`Store ID` AS INT64) AS store_id,
    `Store Name` AS store_name,
    `Region` AS region,
    `Manager Email` AS manager_email,
    CURRENT_TIMESTAMP() AS loaded_at
FROM {{ source('retail_raw', 'dim_store') }}