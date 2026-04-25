-- ============================================
-- 03_create_tables.sql
-- DDL: Create all tables under analytics schema
-- Based on: Hospital Management Dataset (Kaggle)
-- ============================================


-- PATIENTS
CREATE TABLE analytics.patients (
    patient_id          VARCHAR(10)  PRIMARY KEY,
    first_name          VARCHAR(50)  NOT NULL,
    last_name           VARCHAR(50)  NOT NULL,
    gender              CHAR(1)      CHECK (gender IN ('M', 'F')),
    date_of_birth       DATE,
    contact_number      VARCHAR(20),
    address             VARCHAR(100),
    registration_date   DATE,
    insurance_provider  VARCHAR(50),
    insurance_number    VARCHAR(20),
    email               VARCHAR(100)
);


-- DOCTORS
CREATE TABLE analytics.doctors (
    doctor_id           VARCHAR(10)  PRIMARY KEY,
    first_name          VARCHAR(50)  NOT NULL,
    last_name           VARCHAR(50)  NOT NULL,
    specialization      VARCHAR(50),
    phone_number        VARCHAR(20),
    years_experience    INT          CHECK (years_experience >= 0),
    hospital_branch     VARCHAR(50),
    email               VARCHAR(100)
);


-- APPOINTMENTS
CREATE TABLE analytics.appointments (
    appointment_id      VARCHAR(10)  PRIMARY KEY,
    patient_id          VARCHAR(10)  REFERENCES analytics.patients(patient_id),
    doctor_id           VARCHAR(10)  REFERENCES analytics.doctors(doctor_id),
    appointment_date    DATE,
    appointment_time    TIME,
    reason_for_visit    VARCHAR(100),
    status              VARCHAR(20)  CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-show'))
);


-- TREATMENTS
CREATE TABLE analytics.treatments (
    treatment_id        VARCHAR(10)  PRIMARY KEY,
    appointment_id      VARCHAR(10)  REFERENCES analytics.appointments(appointment_id),
    treatment_type      VARCHAR(50),
    description         VARCHAR(200),
    cost                NUMERIC(10,2) CHECK (cost >= 0),
    treatment_date      DATE
);


-- BILLING
CREATE TABLE analytics.billing (
    bill_id             VARCHAR(10)  PRIMARY KEY,
    patient_id          VARCHAR(10)  REFERENCES analytics.patients(patient_id),
    treatment_id        VARCHAR(10)  REFERENCES analytics.treatments(treatment_id),
    bill_date           DATE,
    amount              NUMERIC(10,2) CHECK (amount >= 0),
    payment_method      VARCHAR(30),
    payment_status      VARCHAR(20)  CHECK (payment_status IN ('Paid', 'Pending', 'Failed'))
);