-- models/staging/stg_products.sql
SELECT
    CAST(`Product ID` AS INT64) AS product_id,
    `Product Name` AS product_name,
    `Category` AS category,
    CAST(`Unit Price` AS NUMERIC) AS unit_price,
    CAST(`Unit Cost` AS NUMERIC) AS unit_cost,
    ROUND((`Unit Price` - `Unit Cost`) / NULLIF(`Unit Price`, 0), 4) AS gross_margin_pct,
    CURRENT_TIMESTAMP() AS loaded_at
FROM {{ source('retail_raw', 'dim_product') }}