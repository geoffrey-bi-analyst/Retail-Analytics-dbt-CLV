-- models/marts/core/dim_customers.sql
WITH customer_metrics AS (
    SELECT
        customer_id,
        MIN(sale_date) AS first_purchase_date,
        MAX(sale_date) AS last_purchase_date,
        COUNT(DISTINCT sale_id) AS total_transactions,
        SUM(total_amount) AS lifetime_value,
        AVG(total_amount) AS avg_order_value,
        DATE_DIFF(MAX(sale_date), MIN(sale_date), DAY) AS customer_lifetime_days
    FROM {{ ref('stg_sales') }}
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)

SELECT
    customer_id,
    first_purchase_date,
    last_purchase_date,
    total_transactions,
    lifetime_value,
    avg_order_value,
    customer_lifetime_days,
    CASE 
        WHEN lifetime_value > 10000 THEN 'Premium'
        WHEN lifetime_value > 5000 THEN 'Gold'
        WHEN lifetime_value > 1000 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_segment,
    CURRENT_TIMESTAMP() AS updated_at
FROM customer_metrics