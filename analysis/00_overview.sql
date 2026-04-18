-- =============================================
-- HOSPITAL DATABASE: OVERVIEW & EDA
-- =============================================
-- Description: Initial exploratory data analysis.
-- Entity counts, date range, appointment statuses.
-- =============================================


-- 0.1 Total Entity Counts
SELECT 'Patients'     AS entity, COUNT(*) AS total FROM analytics.patients
UNION ALL
SELECT 'Doctors'      AS entity, COUNT(*) AS total FROM analytics.doctors
UNION ALL
SELECT 'Appointments' AS entity, COUNT(*) AS total FROM analytics.appointments
UNION ALL
SELECT 'Treatments'   AS entity, COUNT(*) AS total FROM analytics.treatments
UNION ALL
SELECT 'Billing'      AS entity, COUNT(*) AS total FROM analytics.billing;

-- Result:
-- entity       | total
-- Patients     | 50
-- Doctors      | 10
-- Appointments | 200
-- Treatments   | 200
-- Billing      | 200


-- 0.2 Data Date Range
SELECT 
    MIN(appointment_date) AS first_appointment,
    MAX(appointment_date) AS last_appointment
FROM analytics.appointments;

-- Result:
-- first_appointment | last_appointment
-- 2023-01-01        | 2023-12-31


-- 0.3 Appointment Status Breakdown
SELECT 
    status,
    COUNT(*) AS total
FROM analytics.appointments
GROUP BY status
ORDER BY total DESC;

-- Result:
-- status    | total
-- No-show   | 52
-- Scheduled | 51
-- Cancelled | 51
-- Completed | 46