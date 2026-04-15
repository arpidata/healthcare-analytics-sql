-- =============================================
-- SECTION 3: TREATMENT & SERVICE INSIGHTS
-- =============================================
-- Description: Analysis of treatment distribution,
-- service popularity, and revenue contribution.
-- =============================================


-- 3.1 Treatment Type Volume & Market Share
-- Goal: Identify the most frequently performed services.
SELECT
    treatment_type,
    COUNT(*) AS total_treatments,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS percentage
FROM analytics.treatments
GROUP BY treatment_type
ORDER BY total_treatments DESC;

-- Result:
-- treatment_type | total_treatments | percentage (%)
-- Chemotherapy   | 49               | 24.5
-- X-Ray          | 41               | 20.5
-- ECG            | 38               | 19.0
-- MRI            | 36               | 18.0
-- Physiotherapy  | 36               | 18.0


-- 3.2 Revenue Drivers by Treatment Category
-- Goal: Calculate total revenue and average cost per treatment type.
SELECT
    t.treatment_type,
    COUNT(*) AS total_treatments,
    ROUND(AVG(t.cost), 2) AS avg_cost, 
    ROUND(SUM(t.cost), 2) AS total_revenue,
    ROUND(SUM(t.cost) * 100.0 / SUM(SUM(t.cost)) OVER (), 1) AS revenue_percentage
FROM analytics.treatments t
GROUP BY t.treatment_type
ORDER BY total_revenue DESC;

-- Result:
-- treatment_type | avg_cost | total_revenue | revenue_percentage (%)
-- Chemotherapy   | 2629.71  | 128855.68     | 23.4
-- MRI            | 3224.95  | 116098.16     | 21.1
-- X-Ray          | 2698.87  | 110653.67     | 20.1
-- Physiotherapy  | 2761.61  | 99418.10      | 18.0
-- ECG            | 2532.22  | 96224.24      | 17.5