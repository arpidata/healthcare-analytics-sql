-- =============================================
-- SECTION 1: PATIENT DEMOGRAPHICS & RETENTION
-- =============================================
-- Description: Analysis of patient base including
-- gender distribution, age groups, retention rate,
-- and insurance coverage.
-- =============================================


-- 1.1 Gender Distribution
SELECT 
    gender,
    COUNT(*) AS total_patients
FROM analytics.patients
GROUP BY gender;

-- Result:
-- gender | total_patients
-- M      | 31
-- F      | 19


-- 1.2 Age Group Distribution
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

-- Result:
-- age_group | total_patients
-- 0-30      | 10
-- 31-50     | 22
-- 51-70     | 14
-- 70+       | 4


-- 1.3 Loyal Patients (3+ visits)
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

-- Result:
-- 38 out of 50 patients (76%) have 3+ visits


-- 1.4 Insurance Coverage
SELECT 
    insurance_provider,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM analytics.patients
GROUP BY insurance_provider
ORDER BY total_patients DESC;

-- Result:
-- insurance_provider | total_patients | percentage
-- MedCare Plus       | 18             | 36.0
-- WellnessCorp       | 16             | 32.0
-- PulseSecure        | 10             | 20.0
-- HealthIndia        | 6              | 12.0