-- Database Creation
CREATE DATABASE hospital_management_db;
USE hospital_management_db;
-- 1. Patients Table
CREATE TABLE patients(
	patient_id INT PRIMARY KEY AUTO_INCREMENT, 
    patient_name VARCHAR(100) NOT NULL,
    patient_age INT,
    patient_gender VARCHAR(10),
    patient_phone VARCHAR(15),
    disease_description VARCHAR(100),
    admission_date DATE 
);
-- 2. Doctors Table
CREATE TABLE doctors(
	doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    doctor_phone VARCHAR(15)
);
-- 3. Appointments Table
CREATE TABLE appointments(
	appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
-- 4. Billing Table
CREATE TABLE billing(
	bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    consultation_fee DECIMAL(10,2),
    medicine_fee DECIMAL(10,2),
    room_charges DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    bill_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- Insert Sample Data
-- Patients
INSERT INTO patients(patient_name, patient_age, patient_gender, patient_phone, disease_description, admission_date) VALUES('Ramesh', 45, 'Male', '9876543210','Fever','2025-01-01'),('Sita', 30, 'Female', '9123456780', 'Cold', '2025-01-02');
-- Doctors
INSERT INTO doctors(doctor_name, specialization, doctor_phone) VALUES('Dr. Kumar', 'General Physician', '9000011111'),('Dr. Priya', 'ENT Specialist', '9000022222');
-- Appointments
INSERT INTO appointments(patient_id, doctor_id, appointment_date, appointment_status) VALUES(1, 1, '2025-01-03', 'Completed'),(2, 2, '2025-01-04', 'Scheduled');
-- Billing
INSERT INTO billing(patient_id, consultation_fee, medicine_fee, room_charges, total_amount, bill_date) VALUES(1, 500, 300, 0, 800, '2025-01-03'),(2, 600, 400, 0, 1000, '2025-01-04');

-- View all patients
SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;
SELECT * FROM billing;

-- Patient with doctor name
SELECT 
p.patient_name, 
d.doctor_name, 
a.appointment_date 
FROM appointments a 
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

-- Total bill per patient
SELECT 
p.patient_name,
SUM(b.total_amount) AS total_bill_amount
FROM billing b
JOIN patients p ON b.patient_id = p.patient_id
GROUP BY p. patient_name;

-- Doctors with more appointments
SELECT 
d.doctor_name,
COUNT(a.appointment_id) AS appointment_count
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_name;

-- Patients admitted after Jan 2025
SELECT patient_name, admission_date
FROM patients
WHERE admission_date >= '2025-01-01';
-- 
