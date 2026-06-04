-- models/marts/core/fact_sales.sql
SELECT
    sale_id,
    sale_date,
    store_id,
    product_id,
    customer_id,
    quantity,
    unit_price,
    total_amount,
    calculated_amount,
    loaded_at
FROM {{ ref('stg_sales') }}