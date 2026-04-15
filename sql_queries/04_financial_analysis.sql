-- =============================================
-- SECTION 4: FINANCIAL HEALTH & REVENUE TRENDS
-- =============================================
-- Description: Analysis of revenue growth, 
-- payment efficiency, and collection status.
-- =============================================


-- 4.1 Monthly Revenue Dynamics
-- Goal: Identify seasonal trends and month-over-month growth.
SELECT 
    TO_CHAR(bill_date, 'YYYY-MM') AS month,
    ROUND(SUM(amount), 2) AS monthly_revenue,
    COUNT(*) AS total_bills
FROM analytics.billing
GROUP BY TO_CHAR(bill_date, 'YYYY-MM')
ORDER BY month DESC;

-- Result:
-- month   | monthly_revenue | total_bills
-- 2023-12 | 27569.71        | 12
-- 2023-11 | 52474.98        | 17
-- 2023-04 | 64271.54        | 25
-- 2023-01 | 58701.23        | 20


-- 4.2 Cumulative Revenue (Running Total)
-- Goal: Track total year-to-date (YTD) revenue growth using Window Functions.
SELECT
    TO_CHAR(bill_date, 'YYYY-MM') AS month,
    ROUND(SUM(amount), 2) AS monthly_revenue,
    ROUND(SUM(SUM(amount)) OVER (ORDER BY TO_CHAR(bill_date, 'YYYY-MM')), 2) AS running_total
FROM analytics.billing
GROUP BY TO_CHAR(bill_date, 'YYYY-MM')
ORDER BY month;

-- Result:
-- month   | monthly_revenue | running_total
-- 2023-01 | 58701.23        | 58701.23
-- 2023-06 | 56887.82        | 312625.62
-- 2023-12 | 27569.71        | 551249.85 (Full Year Total)


-- 4.3 Payment Status & Collection Risk
-- Goal: Assess the volume of 'Pending' or 'Failed' payments.
SELECT
    payment_status,
    COUNT(*) AS total_bills,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER (), 1) AS percentage
FROM analytics.billing
GROUP BY payment_status
ORDER BY total_amount DESC;

-- Result:
-- payment_status | total_bills | total_amount | percentage (%)
-- Failed         | 67          | 193212.94    | 35.0
-- Pending        | 69          | 184612.01    | 33.5
-- Paid           | 64          | 173424.90    | 31.5


-- 4.4 Payment Method Preferences
-- Goal: Identify preferred payment channels.
SELECT 
    payment_method,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(SUM(amount) / COUNT(*), 2) AS avg_per_transaction,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM analytics.billing
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- Result:
-- payment_method | total_transactions | total_amount | avg_per_transaction | percentage (%)
-- Credit Card    | 75                 | 201382.43    | 2685.10             | 37.5
-- Insurance      | 64                 | 182160.28    | 2846.25             | 32.0
-- Cash           | 61                 | 167707.14    | 2749.30             | 30.5