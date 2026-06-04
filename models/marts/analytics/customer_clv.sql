-- models/marts/analytics/customer_clv.sql
WITH customer_rfm AS (
    SELECT
        customer_id,
        -- Recency: Days since last purchase
        DATE_DIFF(CURRENT_DATE(), MAX(sale_date), DAY) AS recency_days,
        
        -- Frequency: Total number of purchases
        COUNT(DISTINCT sale_id) AS frequency,
        
        -- Monetary: Total spending
        SUM(total_amount) AS monetary,
        
        -- Additional metrics
        MIN(sale_date) AS first_purchase_date,
        MAX(sale_date) AS last_purchase_date,
        AVG(total_amount) AS avg_transaction_value,
        STDDEV(total_amount) AS transaction_volatility
    FROM {{ ref('fact_sales') }}
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
),

clv_calculation AS (
    SELECT
        customer_id,
        recency_days,
        frequency,
        monetary,
        first_purchase_date,
        last_purchase_date,
        avg_transaction_value,
        transaction_volatility,
        
        -- Predicted 12-month CLV (simplified model)
        -- Formula: (avg_transaction_value * frequency * 12) / 4 (assuming quarterly cycles)
        ROUND(
            (avg_transaction_value * frequency * 12) / NULLIF(4, 0), 
            2
        ) AS predicted_12m_clv,
        
        -- Customer segmentation based on RFM scores
        CASE 
            WHEN recency_days <= 30 AND frequency >= 10 AND monetary >= 5000 
                THEN 'Champion'
            WHEN recency_days <= 60 AND frequency >= 5 AND monetary >= 2000 
                THEN 'Loyal'
            WHEN recency_days <= 90 AND frequency >= 2 AND monetary >= 500 
                THEN 'Potential'
            WHEN recency_days <= 120 AND frequency >= 1 
                THEN 'At Risk'
            WHEN recency_days > 120 
                THEN 'Churned'
            ELSE 'New'
        END AS rfm_segment,
        
        -- Customer health score (0-100)
        GREATEST(0, LEAST(100,
            CASE 
                WHEN recency_days <= 30 THEN 40
                WHEN recency_days <= 90 THEN 25
                WHEN recency_days <= 180 THEN 10
                ELSE 0
            END +
            CASE 
                WHEN frequency >= 10 THEN 35
                WHEN frequency >= 5 THEN 25
                WHEN frequency >= 2 THEN 15
                ELSE 5
            END +
            CASE 
                WHEN monetary >= 10000 THEN 25
                WHEN monetary >= 5000 THEN 20
                WHEN monetary >= 1000 THEN 15
                ELSE 5
            END
        )) AS health_score
    FROM customer_rfm
)

SELECT 
    customer_id,
    recency_days,
    frequency,
    monetary,
    first_purchase_date,
    last_purchase_date,
    avg_transaction_value,
    predicted_12m_clv,
    rfm_segment,
    health_score,
    CASE 
        WHEN health_score >= 70 THEN 'Green - Healthy'
        WHEN health_score >= 40 THEN 'Yellow - Monitor'
        ELSE 'Red - Attention'
    END AS health_status,
    CURRENT_TIMESTAMP() AS calculated_at
FROM clv_calculation
WHERE customer_id IS NOT NULL