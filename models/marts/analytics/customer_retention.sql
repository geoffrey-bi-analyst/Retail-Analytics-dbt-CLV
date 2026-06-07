-- models/marts/analytics/customer_retention.sql
WITH customer_cohorts AS (
    SELECT
        customer_id,
        DATE_TRUNC(first_purchase_date, MONTH) AS cohort_month
    FROM {{ ref('dim_customers') }}
    WHERE customer_id IS NOT NULL
),

customer_orders AS (
    SELECT
        f.customer_id,
        DATE_TRUNC(f.sale_date, MONTH) AS order_month,
        c.cohort_month
    FROM {{ ref('fact_sales') }} f
    INNER JOIN customer_cohorts c ON f.customer_id = c.customer_id
    WHERE f.customer_id IS NOT NULL
),

cohort_size AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS total_customers
    FROM customer_cohorts
    GROUP BY cohort_month
),

monthly_activity AS (
    SELECT
        o.cohort_month,
        o.order_month,
        COUNT(DISTINCT o.customer_id) AS active_customers
    FROM customer_orders o
    GROUP BY o.cohort_month, o.order_month
)

SELECT
    m.cohort_month,
    m.order_month,
    m.active_customers,
    s.total_customers,
    -- Calculate months since cohort start
    DATE_DIFF(m.order_month, m.cohort_month, MONTH) AS months_since_cohort,
    -- Calculate retention rate
    ROUND(SAFE_DIVIDE(m.active_customers, s.total_customers) * 100, 2) AS retention_rate_pct
FROM monthly_activity m
INNER JOIN cohort_size s ON m.cohort_month = s.cohort_month
WHERE DATE_DIFF(m.order_month, m.cohort_month, MONTH) BETWEEN 0 AND 12
ORDER BY m.cohort_month, m.order_month