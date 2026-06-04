-- models/marts/core/dim_products.sql
SELECT
    product_id,
    product_name,
    category,
    unit_price,
    unit_cost,
    gross_margin_pct,
    loaded_at
FROM {{ ref('stg_products') }}