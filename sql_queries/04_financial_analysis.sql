-- ============================================
-- 04. FINANCIAL HEALTH & TRENDS
-- Goal: Track revenue growth and payment efficiency.
-- ============================================

-- Monthly revenue dynamics to identify seasonal trends
SELECT 
    TO_CHAR(bill_date, 'YYYY-MM') AS month,
    ROUND(SUM(amount), 2) AS monthly_revenue,
    COUNT(*) AS total_bills
FROM analytics.billing
GROUP BY TO_CHAR(bill_date, 'YYYY-MM')
ORDER BY month DESC; 

-- Cumulative revenue growth (Running Total) using Window Functions
SELECT
    TO_CHAR(bill_date, 'YYYY-MM') AS month,
    ROUND(SUM(amount), 2) AS monthly_revenue,
    ROUND(SUM(SUM(amount)) OVER (ORDER BY TO_CHAR(bill_date, 'YYYY-MM')), 2) AS running_total
FROM analytics.billing
GROUP BY TO_CHAR(bill_date, 'YYYY-MM')
ORDER BY month; 

-- Payment status analysis (Cash flow validation: Paid vs Pending)
SELECT
    payment_status,
    COUNT(*) AS total_bills,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER (), 1) AS percentage
FROM analytics.billing
GROUP BY payment_status
ORDER BY total_amount DESC; 

-- Transaction volume and revenue distribution by payment method
SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(SUM(amount) / COUNT(*), 2) AS avg_per_transaction,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM analytics.billing
GROUP BY payment_method
ORDER BY total_transactions DESC;