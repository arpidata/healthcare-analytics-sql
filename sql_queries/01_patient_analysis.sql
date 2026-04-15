-- ============================================
-- 01. PATIENT DEMOGRAPHICS & RETENTION
-- Goal: Analyze patient segments and find recurring visitors.
-- ============================================

-- Patient distribution by gender
SELECT 
    gender,
    COUNT(*) AS total_patients
FROM analytics.patients
GROUP BY gender;

-- Age group analysis using conditional logic
SELECT
  CASE 
      WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) BETWEEN 0 AND 30 THEN '0-30' 
      WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) BETWEEN 31 AND 50 THEN '31-50'
      WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) BETWEEN 51 AND 70 THEN '51-70'
      ELSE '70+'
  END AS age_group, 
  COUNT(*) AS total_patients
FROM analytics.patients
GROUP BY age_group
ORDER BY age_group; 

-- Identifying "Loyal Patients" with 3 or more visits
SELECT
     p.patient_id,
     p.first_name,
     p.last_name, 
     COUNT(a.appointment_id) AS total_visits
FROM analytics.patients p
JOIN analytics.appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(a.appointment_id) >= 3
ORDER BY total_visits DESC; 

-- Market share of insurance providers (using window functions)
SELECT 
    insurance_provider,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM analytics.patients
GROUP BY insurance_provider
ORDER BY total_patients DESC;