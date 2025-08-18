use healthcaredb;
-- (A) Healthcare Analytics Queries:
-- 1 Retrieve the number of patients grouped by gender and calculate the average age of patients.
select* from patients;
SELECT Gender,
      avg(age) as AverageAge
FROM patients
GROUP BY Gender;
SELECT Gender,
    COUNT(*) AS total_patients,
    AVG(Age) AS average_age
FROM patients
GROUP BY Gender;
use healthcaredb;
select* from admissions;
select* from hospitals;
-- 2● Hospital Utilization: Identify hospitals with the highest number of admissions
SELECT h.HospitalID,
	h.HospitalName,
    COUNT(a.AdmissionID) AS TotalAdmissions
FROM Hospitals h
JOIN Admissions a 
ON h.HospitalID = a.HospitalID
GROUP BY h.HospitalID, h.HospitalName
ORDER BY TotalAdmissions DESC;

-- 3 Treatment Costs: Calculate the total cost of treatments provided at each hospital.
select h.HospitalName,
	   h.HospitalID,
      SUM(t.Cost) AS TotalTreatmentCost
FROM hospitals h
JOIN admissions a
ON h.HospitalID = a.HospitalID
JOIN treatments t
ON t.AdmissionID = a.AdmissionID
GROUP BY HospitalID, HospitalName
ORDER BY TotalTreatmentCost DESC;

-- 5 Length of Stay Analysis: Extract the average length of stay for patients grouped by hospital.
SELECT h.HospitalID,
       h.HospitalName,
    AVG(DATEDIFF(a.DischargeDate, a.AdmissionDate)) AS AvgLengthOfStay
FROM Hospitals h
JOIN Admissions a ON h.HospitalID = a.HospitalID
WHERE a.DischargeDate IS NOT NULL
GROUP BY h.HospitalID, h.HospitalName
ORDER BY AvgLengthOfStay DESC;

-- (B) Advanced Filtering:
-- 1.List all patients who stayed longer than 7 days in any hospital.
SELECT p.FullName,
	   h.HospitalName,
       DATEDIFF(a.DischargeDate, a.AdmissionDate) AS lengthofstay
FROM patients p
JOIN admissions a
ON a.PatientID = p.PatientID
JOIN hospitals h
ON h.HospitalID = a.HospitalID
WHERE DATEDIFF(a.DischargeDate, a.AdmissionDate) >7;

-- 2.Identify treatments that have been performed more than 5 times across all hospitals.
SELECT ProcedureName,
      COUNT(*) AS ProcedureCount
from treatments 
GROUP BY ProcedureName
HAVING  COUNT(*) >5;

-- (C) Combining Data:
-- 1● Combine admission and treatment data to display complete patient histories.
SELECT * FROM admissions a
join treatments t
ON a.AdmissionID = t.AdmissionID;

-- 2● Combine lists of patients admitted for different reasons (e.g., surgery and therapy)
SELECT p.PatientID,
      p.FullName,
      a.ReasonForAdmission
FROM patients p
JOIN admissions a
ON p.PatientID= a.PatientID;

-- (C) Subqueries and Views:
-- 1● Use a subquery to find the hospital with the highest average treatment cost.


SELECT h.HospitalID,
        HospitalName,
       AVG(t.Cost) as AvgTreatmentCost
FROM hospitals h
JOIN admissions a
ON a.HospitalID = h.HospitalID
JOIN treatments t
ON a.AdmissionID = t.AdmissionID
GROUP BY HospitalID
ORDER BY AvgTreatmentCost DESC
LIMIT 1;

-- 2● Create a view named HospitalPerformance to display the total number of admissions,average length of stay, and total revenue generated for each hospital.
 CREATE VIEW HospitalPerformance as
SELECT h.HospitalID,
    h.HospitalName,
    COUNT(DISTINCT a.AdmissionID) AS TotalAdmissions,
    AVG(DATEDIFF(a.DischargeDate, a.AdmissionDate)) AS AvgLengthOfStay,
    SUM(t.Cost) AS TotalRevenue
FROM Hospitals h
JOIN Admissions a ON h.HospitalID = a.HospitalID
JOIN Treatments t ON a.AdmissionID = t.AdmissionID
WHERE a.DischargeDate IS NOT NULL
GROUP BY h.HospitalID, h.HospitalName;

-- Window Functions:
-- 1● Use the RANK function to rank hospitals based on their total revenue.
SELECT h.HospitalName,
    SUM(t.Cost) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(t.Cost) DESC) AS RevenueRank
FROM Hospitals h
JOIN Admissions a ON h.HospitalID = a.HospitalID
JOIN Treatments t ON a.AdmissionID = t.AdmissionID
GROUP BY h.HospitalName;

-- 2 Use DENSE_RANK to rank treatments based on their frequency.
SELECT ProcedureName,
    COUNT(*) AS ProcedureCount,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS FrequencyRank
FROM Treatments
GROUP BY ProcedureName;

       
       































