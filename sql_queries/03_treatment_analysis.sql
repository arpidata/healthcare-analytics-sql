-- ============================================
-- 03. TREATMENT & SERVICE INSIGHTS
-- Goal: Identify most popular and high-revenue treatments.
-- ============================================

-- Frequency and volume of treatment types provided
SELECT
    treatment_type,
    COUNT(*) AS total_treatments,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS percentage
FROM analytics.treatments
GROUP BY treatment_type
ORDER BY total_treatments DESC; 

-- Financial analysis of treatments (Revenue Drivers)
SELECT
    t.treatment_type,
    COUNT(*) AS total_treatments,
    ROUND(AVG(t.cost), 2) AS avg_cost, 
    ROUND(SUM(t.cost), 2) AS total_revenue,
    ROUND(SUM(t.cost) * 100.0 / SUM(SUM(t.cost)) OVER (), 1) AS revenue_percentage
FROM analytics.treatments t
GROUP BY t.treatment_type
ORDER BY total_revenue DESC;