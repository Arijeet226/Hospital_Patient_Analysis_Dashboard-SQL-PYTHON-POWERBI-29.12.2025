# Hospital_Patient_Analysis_Dashboard-SQL-PYTHON-POWERBI-29.12.2025
This is a complete end to end analytical project on hospital patient analysis.
Hey Everyone I am presenting my project on Hospital Patient Analytical Dashboard. So, let’s me
walk you through this ppt here I have jot down each and everything I did in this project. I will
explain mostly everything from this as opening multiple files at once may cause crashing the
system. Now, if this is clear to you all. Let’s begin

Firstly, The
## Situation is
A hospital group needed a single view of patient information: who is being admitted, what
treatment they receive, how much they are billed, and how well they recover.
The available data was in two raw Excel files with 1,000 rows each, containing issues like missing
values and no clear structure for analysis. There was no integrated dashboard to help
management monitor KPIs such as total revenue, average cost per day, or recovery rating by
hospital, doctor, or treatment type.

🛠️ Technologies Used
Python: Pandas (cleaning, EDA)
MySQL: Relational modeling, SQL queries
Power BI: Dashboard with relationships/slicers

## Task we pulled off are
Cleaning and standardizing the data. Storing it properly in a relational database with
primary/foreign keys. Answering key business questions with SQL. Presents the results in a
user‑friendly Power BI dashboard.

## Action taken on the way
1) Data cleaning and preparation in Python & Excel
Converted the original Excel files to CSV and kept a duplicate to ensure the raw data remained
untouched. Then after that Loaded both datasets into Python (Pandas) and performed data
profiling to understand columns, data types, and missing values. Dropped the long “Full
Prescription Details” text column as it did not add value to the KPIs.
Replaced missing patient names with “unknown” and missing hospital names with “n/a” to
avoid blanks in key fields.
Imputed missing TotalBill values using the mean bill per treatment type. Imputed missing
RecoveryRating values with the rounded average recovery rating. Checked for duplicates and
confirmed there were no duplicate patient records.
2) Exploratory data analysis (EDA)
Used visualizations (countplots, histograms, bar charts, pie charts) to understand:
Gender distribution and diagnosis by gender. Age distribution, confirming there were no
extreme outliers. Average bill by diagnosis and by treatment type. Average recovery rating by
treatment type and average daily cost by hospital.
3) Data modeling and SQL analysis (MySQL)
Imported the cleaned CSVs into MySQL as two tables: hospital1 (patient‑level data) and
hospital2 (hospital/doctor‑level data).
Defined PatientID as primary key in hospital1 and as a foreign key in hospital2 to create a proper
relational model.
Wrote SQL queries to answer business questions, for example:
4) Dashboard design (Power BI)
Loaded the cleaned tables into Power BI and recreated the relationships using PatientID.
Built a 4‑page interactive dashboard with slicers for Year and Month:

**Screenshot of dashboard:**  
![Preview of Homepage](https://github.com/Arijeet226/Hospital_Patient_Analysis_Dashboard-SQL-PYTHON-POWERBI-29.12.2025/blob/ec1d6659e08f2b09a8c38f7301a36910546e76c7/snippets/Screenshot%202025-12-27%20102833.png)
**Screenshot of dashboard:**  
![Preview of Homepage](https://github.com/Arijeet226/Hospital_Patient_Analysis_Dashboard-SQL-PYTHON-POWERBI-29.12.2025/blob/ec1d6659e08f2b09a8c38f7301a36910546e76c7/snippets/Screenshot%202025-12-27%20102848.png)
**Screenshot of dashboard:**  
![Preview of Homepage](https://github.com/Arijeet226/Hospital_Patient_Analysis_Dashboard-SQL-PYTHON-POWERBI-29.12.2025/blob/ec1d6659e08f2b09a8c38f7301a36910546e76c7/snippets/Screenshot%202025-12-27%20102911.png)
**Screenshot of dashboard:**  
![Preview of Homepage](https://github.com/Arijeet226/Hospital_Patient_Analysis_Dashboard-SQL-PYTHON-POWERBI-29.12.2025/blob/ec1d6659e08f2b09a8c38f7301a36910546e76c7/snippets/Screenshot%202025-12-27%20102926.png)


📈 Key Visuals in Dashboard
Revenue vs Target (trend line)
Cost & Recovery trends (multi-line chart)
Hospital/Doctor comparisons (bar charts)
Treatment-type breakdowns (pie charts)

## Result obtained from the action
Created a single, interactive dashboard that gives hospital management a clear view of clinical,
operational, and financial performance in one place “The final dashboard shows total revenue
vs target, cost and recovery trends, and variation across hospitals and doctors, and it supports
specific recommendations to reduce cost, improve recovery ratings, and standardize best
practices across the network.”
I hope everything has been explained and you all got some zest what the project is all about.
That’s all. Thank you for your time.
