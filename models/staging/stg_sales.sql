-- models/staging/stg_sales.sql
SELECT
    CAST(`Sale ID` AS INT64) AS sale_id,
    DATE(`Date`) AS sale_date,
    CAST(`Store ID` AS INT64) AS store_id,
    CAST(`Product ID` AS INT64) AS product_id,
    `Customer ID` AS customer_id,
    CAST(`Quantity` AS INT64) AS quantity,
    CAST(`Unit Price` AS NUMERIC) AS unit_price,
    CAST(`Total Amount` AS NUMERIC) AS total_amount,
    CAST(`Quantity` AS INT64) * CAST(`Unit Price` AS NUMERIC) AS calculated_amount,
    CURRENT_TIMESTAMP() AS loaded_at
FROM {{ source('retail_raw', 'fact_sales') }}