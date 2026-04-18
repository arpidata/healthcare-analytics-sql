-- ============================================
-- DATABASE SCHEMA SETUP
-- Project: Hospital Operations Analytics
-- Author: Arpenik
-- ============================================

CREATE SCHEMA IF NOT EXISTS analytics;

-- 1. Patients Table: Stores demographic and insurance information.
CREATE TABLE analytics.patients (
    patient_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    date_of_birth DATE NOT NULL,
    contact_number VARCHAR(20),
    address TEXT,
    registration_date DATE DEFAULT CURRENT_DATE,
    insurance_provider VARCHAR(100),
    insurance_number VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

-- 2. Doctors Table: Contains medical provider profiles and specializations.
CREATE TABLE analytics.doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(20),
    years_experience INT CHECK (years_experience >= 0),
    hospital_branch VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- 3. Appointments Table: Tracks patient-doctor interactions.
CREATE TABLE analytics.appointments (
    appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10) REFERENCES analytics.patients(patient_id),
    doctor_id VARCHAR(10) REFERENCES analytics.doctors(doctor_id),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason_for_visit TEXT,
    status VARCHAR(50) CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-show'))
);

-- 4. Treatments Table: Clinical details for each appointment.
CREATE TABLE analytics.treatments (
    treatment_id VARCHAR(10) PRIMARY KEY,
    appointment_id VARCHAR(10) REFERENCES analytics.appointments(appointment_id),
    treatment_type VARCHAR(100),
    description TEXT,
    cost DECIMAL(10, 2) NOT NULL,
    treatment_date DATE NOT NULL
);

-- 5. Billing Table: Financial transactions related to patient treatments.
CREATE TABLE analytics.billing (
    bill_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10) REFERENCES analytics.patients(patient_id),
    treatment_id VARCHAR(10) REFERENCES analytics.treatments(treatment_id),
    bill_date DATE DEFAULT CURRENT_DATE,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50) CHECK (payment_method IN ('Cash', 'Credit Card', 'Insurance', 'Bank Transfer')),
    payment_status VARCHAR(50) CHECK (payment_status IN ('Paid', 'Pending', 'Failed'))
);