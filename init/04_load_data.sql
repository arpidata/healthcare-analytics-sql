-- ============================================
-- 04_load_data.sql
-- Load CSV data into analytics schema tables
-- Run after 03_create_tables.sql
-- Note: CSV files must be placed in /data directory
-- ============================================


COPY analytics.patients
FROM '/data/patients.csv'
CSV HEADER;

COPY analytics.doctors
FROM '/data/doctors.csv'
CSV HEADER;

COPY analytics.appointments
FROM '/data/appointments.csv'
CSV HEADER;

COPY analytics.treatments
FROM '/data/treatments.csv'
CSV HEADER;

COPY analytics.billing
FROM '/data/billing.csv'
CSV HEADER;


-- ============================================
-- VALIDATION: Row counts after loading
-- ============================================
SELECT 'patients'     AS table_name, COUNT(*) AS row_count FROM analytics.patients
UNION ALL
SELECT 'doctors',      COUNT(*) FROM analytics.doctors
UNION ALL
SELECT 'appointments', COUNT(*) FROM analytics.appointments
UNION ALL
SELECT 'treatments',   COUNT(*) FROM analytics.treatments
UNION ALL
SELECT 'billing',      COUNT(*) FROM analytics.billing;