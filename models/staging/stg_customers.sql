-- models/staging/stg_customers.sql
SELECT DISTINCT
    `Customer ID` AS customer_id,
    `Customer ID` AS customer_name,
    CONCAT(`Customer ID`, '@example.com') AS customer_email,
    CURRENT_TIMESTAMP() AS loaded_at
FROM {{ source('retail_raw', 'fact_sales') }}
WHERE `Customer ID` IS NOT NULL