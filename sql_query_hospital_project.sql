CREATE DATABASE hospital;
USE hospital;
SELECT * FROM hospital1;
ALTER TABLE hospital1
DROP COLUMN MyUnknownColumn;
SELECT * FROM hospital2;
ALTER TABLE hospital2
DROP COLUMN MyUnknownColumn;
ALTER TABLE hospital1 ADD PRIMARY KEY (PatientId);
ALTER TABLE hospital2
ADD CONSTRAINT fk_hospital2_patientid 
FOREIGN KEY (PatientId) REFERENCES hospital1 (PatientId);

-- QUERIES
-- 1. List all patient names, age, gender, diagnosis, and total bill from hospital1
SELECT PatientName, Age, Gender, Diagnosis, TotalBill 
FROM hospital1;
-- 2. Display patient name, blood type, treatment, and admission date for patients whose total bill > 5000
SELECT PatientName, BloodType, Treatment, AdmissionDate 
FROM hospital1 
WHERE TotalBill > 5000;
-- INSIGHTS:- 761 PATIENT TOTAL BILL WENT MORE THAN 5000
-- 3. Show patient name, age, and gender for patients diagnosed with 'Covid-19'
SELECT PatientName, Age, Gender 
FROM hospital1 
WHERE Diagnosis = 'Covid-19';
-- INSIGHTS :- 202 PATIENT HAS BEEN ADMITTED DUE TO BEING AFFECTED BY COVID-19
-- 4. Display patient name, hospital name, doctor name, and room number for every patient
SELECT h1.PatientName, h2.Hospital, h2.DoctorName, h2.RoomNumber
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID;
-- 5. List patient name, diagnosis, treatment type, and recovery rating
SELECT h1.PatientName, h1.Diagnosis, h2.TreatmentType, h2.RecoveryRating
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID;
-- 6. Show patient name, doctor name, treatment, and daily cost
SELECT h1.PatientName, h2.DoctorName, h1.Treatment, h2.DailyCost
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID;
-- 7. Display patient name, room number, admission date, discharge date, and total bill
SELECT h1.PatientName, h2.RoomNumber, h1.AdmissionDate, h1.DischargeDate, h1.TotalBill
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID;
-- 8. Patients treated in 'Riverside Hospital' hospital with doctor name and diagnosis
SELECT h1.PatientName, h2.DoctorName, h1.Diagnosis
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
WHERE h2.Hospital = 'Riverside Hospital';
-- INSIGHTS:- 168 PATIENTS ARE ADMITTED IN RIVERSIDE HOSPITAL
-- 9. Patient name, doctor name, recovery rating > 8
SELECT h1.PatientName, h2.DoctorName, h2.RecoveryRating
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
WHERE h2.RecoveryRating > 8;
-- INSIGHTS:- 190 PATIENT GOT RECOVERY RATING MORE THAN 8
-- 10. Patient name, hospital, total bill where DailyCost > 1500
SELECT h1.PatientName, h2.Hospital, h2.DailyCost
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
WHERE h2.DailyCost > 1500;
-- INSIGHTS:- 227 PATIENT HAS MORE THAN 1500 DAILYCOST
-- 11. Female patients: name, gender, diagnosis, doctor name
SELECT h1.PatientName, h1.Gender, h1.Diagnosis, h2.DoctorName
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
WHERE h1.Gender = 'Female';
-- 12. Total bill per hospital (in descending order)
SELECT h2.Hospital, ROUND(SUM(h1.TotalBill),2) AS TotalBillSum
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
GROUP BY h2.Hospital
ORDER BY TotalBillSum DESC;
-- INSIGHTS:- GREEN VALLEY MEDICAL CENTER GENERATES THE MOST MONEY FOLLOWED BY 
-- CEDAR SINAI CLINIC AND MAPLE GROVE HEALTH FACILITY
-- 13. Rank doctors by number of patients treated (most patients = rank 1)
SELECT h2.DoctorName, 
       COUNT(*) AS PatientCount,
       DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS DoctorRank
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
GROUP BY h2.DoctorName;
-- INSIGHTS:- DR.DAVID MOORE GOT THE MOST PATIENT COUNT FOLLOWED BY MICHAEL THOMAS
-- JENNIFER JOHNSON AND PATRICIA WILSON 
-- 14. Average daily cost per hospital (in descending order)
SELECT h2.Hospital, ROUND(AVG(h2.DailyCost),2) AS AvgDailyCost
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
GROUP BY h2.Hospital
ORDER BY AvgDailyCost DESC;
-- INSIGHTS:- SILVER OAK MEDICAL PLAZA GENERATED THE HIGHEST AVERAGE DAILYCOST
-- 15. Max, min, avg recovery rating per treatment type
SELECT h2.TreatmentType, MAX(h2.RecoveryRating) AS MaxRating,MIN(h2.RecoveryRating) AS MinRating,
ROUND(AVG(h2.RecoveryRating),1) AS AvgRating
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
GROUP BY h2.TreatmentType;
-- 16. Top 5 highest total bills with hospital
SELECT h1.PatientName, h2.Hospital, h1.TotalBill
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
ORDER BY h1.TotalBill DESC
LIMIT 5;
-- INSIGHTS:- MAPLE GROVE HEALTH FACILITY TOPS THE LIST
-- 17. Top 3 patients by total bill within each hospital
SELECT PatientName, Hospital, TotalBill, BillRank
FROM (
    SELECT h1.PatientName, h2.Hospital, h1.TotalBill,
           RANK() OVER (PARTITION BY h2.Hospital ORDER BY h1.TotalBill DESC) AS BillRank
    FROM hospital1 h1
    INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID
) ranked_patients
WHERE BillRank <= 3
ORDER BY Hospital, BillRank;
-- 18. Categorize patients by age group
SELECT PatientName, Age, Gender,
       CASE 
           WHEN Age < 18 THEN 'Minor'
           WHEN Age BETWEEN 18 AND 60 THEN 'Adult'
           ELSE 'Senior'
       END AS AgeGroup
FROM hospital1;
-- 19. Categorize total bill amounts
SELECT PatientName, TotalBill,
       CASE 
           WHEN TotalBill < 5000 THEN 'Low Cost'
           WHEN TotalBill BETWEEN 5000 AND 15000 THEN 'Medium Cost'
           ELSE 'High Cost'
       END AS BillCategory
FROM hospital1;
-- 20. Recovery rating performance labels per doctor
SELECT h1.PatientName, h2.DoctorName, h2.RecoveryRating,
       CASE 
           WHEN h2.RecoveryRating >= 9 THEN 'Excellent'
           WHEN h2.RecoveryRating >= 7 THEN 'Good'
           WHEN h2.RecoveryRating >= 5 THEN 'Average'
           ELSE 'Poor'
       END AS RecoveryLabel
FROM hospital1 h1
INNER JOIN hospital2 h2 ON h1.PatientID = h2.PatientID;








