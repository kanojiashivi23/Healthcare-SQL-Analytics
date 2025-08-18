This project contains SQL queries for analyzing a healthcare database. The queries explore patient demographics, hospital performance, treatment costs, and overall healthcare utilization to generate actionable insights.

🔑 Key Features

Patient Demographics: Gender distribution & average age of patients

Hospital Utilization: Identify hospitals with the highest admissions

Treatment Costs: Calculate and compare costs across hospitals

Length of Stay Analysis: Average stay duration per hospital

Advanced Filtering: Find patients with stays longer than 7 days, frequent treatments

Data Combination: Merge admissions & treatments for complete patient histories

Subqueries & Views: Create a HospitalPerformance view with admissions, revenue, and stay duration

Window Functions: Rank hospitals by revenue and treatments by frequency

🛠️ Tech Stack

SQL (MySQL / SQL Server)

Healthcare database with tables: Patients, Admissions, Hospitals, Treatments

📊 Example Insights

Hospitals with the highest revenue vs. longest stays

Gender-based patient distribution and health service usage

Most common treatments across all hospitals

Performance benchmarking of hospitals via custom SQL views

▶️ How to Run

Clone the repository:

git clone https://github.com/your-username/Healthcare-SQL-Analytics.git


Import the provided SQL file into your database:

source SQL\ Assignment.sql;


Run queries in your preferred SQL client (MySQL Workbench, SSMS, etc.).
