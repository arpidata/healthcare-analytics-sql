-- ============================================
-- 02. DOCTOR & BRANCH PERFORMANCE
-- Goal: Evaluate workload and "No-show" rates per provider.
-- ============================================

-- Identifying the most active doctors by appointment count
SELECT
   d.first_name || ' ' || d.last_name AS doctor_name,
   d.specialization,
   d.hospital_branch,
   COUNT(a.appointment_id) AS total_appointments
FROM analytics.doctors d
JOIN analytics.appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization, d.hospital_branch
ORDER BY total_appointments DESC; 

-- Analyzing No-show rates per doctor to identify efficiency gaps
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

-- Hospital branch comparison: Volume vs. Appointment completion efficiency
SELECT 
    d.hospital_branch,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN a.status = 'No-show' THEN 1 ELSE 0 END) AS no_shows,
    ROUND(
        SUM(CASE WHEN a.status = 'No-show' THEN 1 ELSE 0 END) * 100.0
        / COUNT(a.appointment_id), 1
    ) AS no_show_rate
FROM analytics.doctors d
JOIN analytics.appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.hospital_branch
ORDER BY total_appointments DESC;
