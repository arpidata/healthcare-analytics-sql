# Data Dictionary
## Hospital Management Analytics

**Source:** [Hospital Management Dataset](https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset) by Kanak Baghel  
**Schema:** `analytics`  
**Last updated:** 2024

---

## Table of Contents

- [patients](#patients)
- [doctors](#doctors)
- [appointments](#appointments)
- [treatments](#treatments)
- [billing](#billing)

---

## `analytics.patients`

Stores demographic and insurance information for registered patients.

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| `patient_id` | VARCHAR(10) | PRIMARY KEY | Unique patient identifier (e.g. P001) |
| `first_name` | VARCHAR(50) | NOT NULL | Patient's first name |
| `last_name` | VARCHAR(50) | NOT NULL | Patient's last name |
| `gender` | CHAR(1) | CHECK (M, F) | Patient's gender: M = Male, F = Female |
| `date_of_birth` | DATE | — | Patient's date of birth |
| `contact_number` | VARCHAR(20) | — | Patient's phone number |
| `address` | VARCHAR(100) | — | Patient's residential address |
| `registration_date` | DATE | — | Date the patient was registered in the system |
| `insurance_provider` | VARCHAR(50) | — | Name of the patient's insurance company |
| `insurance_number` | VARCHAR(20) | — | Patient's insurance policy number |
| `email` | VARCHAR(100) | — | Patient's email address |

**Row count:** 50  

---

## `analytics.doctors`

Stores professional information about doctors and their hospital assignments.

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| `doctor_id` | VARCHAR(10) | PRIMARY KEY | Unique doctor identifier (e.g. D001) |
| `first_name` | VARCHAR(50) | NOT NULL | Doctor's first name |
| `last_name` | VARCHAR(50) | NOT NULL | Doctor's last name |
| `specialization` | VARCHAR(50) | — | Medical specialty (e.g. Dermatology, Oncology, Pediatrics) |
| `phone_number` | VARCHAR(20) | — | Doctor's contact number |
| `years_experience` | INT | CHECK (>= 0) | Number of years of clinical experience |
| `hospital_branch` | VARCHAR(50) | — | Branch where the doctor is assigned (Westside Clinic, Eastside Clinic, Central Hospital) |
| `email` | VARCHAR(100) | — | Doctor's professional email address |

**Row count:** 10  

---

## `analytics.appointments`

Records all patient appointments, including scheduling status and visit reason.

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| `appointment_id` | VARCHAR(10) | PRIMARY KEY | Unique appointment identifier (e.g. A001) |
| `patient_id` | VARCHAR(10) | FOREIGN KEY → patients | Reference to the patient |
| `doctor_id` | VARCHAR(10) | FOREIGN KEY → doctors | Reference to the assigned doctor |
| `appointment_date` | DATE | — | Date of the appointment |
| `appointment_time` | TIME | — | Scheduled time of the appointment |
| `reason_for_visit` | VARCHAR(100) | — | Reason stated by the patient (e.g. Consultation, Checkup, Emergency) |
| `status` | VARCHAR(20) | CHECK | Appointment outcome: Completed, Scheduled, Cancelled, No-show |

**Row count:** 200  

---

## `analytics.treatments`

Records medical treatments performed during appointments.

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| `treatment_id` | VARCHAR(10) | PRIMARY KEY | Unique treatment identifier (e.g. T001) |
| `appointment_id` | VARCHAR(10) | FOREIGN KEY → appointments | Reference to the related appointment |
| `treatment_type` | VARCHAR(50) | — | Type of treatment performed (e.g. MRI, ECG, Chemotherapy, Physiotherapy) |
| `description` | VARCHAR(200) | — | Short description of the procedure (e.g. Basic screening, Advanced protocol) |
| `cost` | NUMERIC(10,2) | CHECK (>= 0) | Cost of the treatment in USD |
| `treatment_date` | DATE | — | Date the treatment was performed |

**Row count:** 200  

---

## `analytics.billing`

Stores financial transactions linked to patients and their treatments.

| Column | Data Type | Constraints | Description |
|--------|-----------|-------------|-------------|
| `bill_id` | VARCHAR(10) | PRIMARY KEY | Unique billing record identifier (e.g. B001) |
| `patient_id` | VARCHAR(10) | FOREIGN KEY → patients | Reference to the billed patient |
| `treatment_id` | VARCHAR(10) | FOREIGN KEY → treatments | Reference to the associated treatment |
| `bill_date` | DATE | — | Date the bill was issued |
| `amount` | NUMERIC(10,2) | CHECK (>= 0) | Billed amount in USD |
| `payment_method` | VARCHAR(30) | — | Payment method used: Insurance, Cash, Credit Card |
| `payment_status` | VARCHAR(20) | CHECK | Payment outcome: Paid, Pending, Failed |

**Row count:** 200  

---

## Relationships

```
patients ──< appointments >── doctors
appointments ──< treatments
patients ──< billing >── treatments
```

---

## Notes

- All tables are created under the `analytics` schema.
- Dataset is synthetic and intended for educational and portfolio purposes.
- Monetary values are expressed in USD.
- Date range covers the fiscal year 2023.