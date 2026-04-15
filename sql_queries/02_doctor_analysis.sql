-- =============================================
-- SECTION 2: CLINICAL OPERATIONS & EFFICIENCY
-- =============================================
-- Description: Analysis of doctor workload, 
-- department performance, and No-show rates.
-- =============================================


-- 2.1 Doctor Workload
-- Goal: Identify the busiest doctors and their branch distribution.
SELECT
    d.first_name || ' ' || d.last_name AS doctor_name,
    d.specialization,
    d.hospital_branch,
    COUNT(a.appointment_id) AS total_appointments
FROM analytics.doctors d
JOIN analytics.appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization, d.hospital_branch
ORDER BY total_appointments DESC;

-- Result:
-- doctor_name  | specialization | hospital_branch  | total_appointments
-- Sarah Taylor | Dermatology    | Central Hospital | 29
-- David Taylor | Dermatology    | Westside Clinic  | 25
-- Alex Davis   | Pediatrics     | Central Hospital | 24


-- 2.2 No-Show Rates per Doctor
-- Goal: Analyze efficiency gaps and missed capacity.
SELECT
    TRIM(d.first_name) || ' ' || TRIM(d.last_name) AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        SUM(CASE WHEN a.status = 'No-show' THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.appointment_id), 1
    ) AS no_show_rate
FROM analytics.doctors d
JOIN analytics.appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization
ORDER BY no_show_rate DESC;

-- Result:
-- doctor_name  | specialization | total_appointments | no_shows | no_show_rate (%)
-- David Jones  | Pediatrics     | 14                 | 5        | 35.7
-- Sarah Smith  | Pediatrics     | 17                 | 6        | 35.3
-- Jane Smith   | Pediatrics     | 22                 | 7        | 31.8


-- 2.3 Department/Branch Performance
-- Goal: Compare workload and status distribution across hospital branches.
SELECT 
    d.hospital_branch,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN a.status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    SUM(CASE WHEN a.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled,
    ROUND(
        SUM(CASE WHEN a.status = 'No-show' THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.appointment_id), 1
    ) AS no_show_rate
FROM analytics.doctors d
JOIN analytics.appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.hospital_branch
ORDER BY total_appointments DESC;

-- Result:
-- hospital_branch  | total_appointments | completed | no_shows | cancelled | no_show_rate (%)
-- Central Hospital | 84                 | 15        | 26       | 19        | 31.0
-- Eastside Clinic  | 62                 | 16        | 13       | 15        | 21.0
-- Westside Clinic  | 54                 | 15        | 13       | 17        | 24.1