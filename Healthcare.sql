# Healthcare Data Analytics Queries
use healthcare_db;
Show tables;

# KPI List 

#1 Total Patients
SELECT COUNT(`Patient ID`) AS Total_Patients
FROM `patient new`;

#2 Total Doctor
SELECT COUNT(DISTINCT `Doctor ID`) AS Total_Doctors
FROM visit;

 #3 Total Revenue 
SELECT 
    CONCAT(ROUND((SUM(`Treatment Cost`) + SUM(`cost`)) / 1000000, 2), 'M') AS Total_Revenue_in_Million
FROM Treatment;

#4 Total Visits
SELECT COUNT(`Visit ID`) AS Total_Visits
FROM Visit;

#5 Year-wise Total Patients
SELECT YEAR(`Visit Date`) AS Year, COUNT(*) AS Total_Visits
FROM Visit
GROUP BY YEAR(`Visit Date`);

#6 Average Age Of Patients
SELECT ROUND(AVG(Age), 2) AS Average_Age
FROM `patient new`;

#7 Top 5 Diagnosed Conditions
SELECT diagnosis,
COUNT(*) AS total_cases
FROM visit
GROUP BY diagnosis
ORDER BY total_cases DESC
LIMIT 5; 

#8 Month-wise follow up Patients
SELECT 
    DATE_FORMAT(`Visit Date`, '%b') AS Month_Name,
    CONCAT(ROUND(
        COUNT(CASE WHEN `Follow Up Required`='Yes' THEN `Visit ID` END) * 100.0 
        / COUNT(`Visit ID`), 2
    ), '%') AS Follow_Up_Rate
FROM visit
GROUP BY MONTH(`Visit Date`), DATE_FORMAT(`Visit Date`, '%b')
ORDER BY MONTH(`Visit Date`);

#9 Average Treatment Cost
SELECT round(AVG(`Treatment Cost`),2) AS Avg_Treatment_Cost
FROM Treatment;

#10 Average Treatment Cost by Treatment Type
SELECT `Treatment Type`,
   round( AVG(`Treatment Cost`),2) AS Avg_Treatment_Cost
FROM Treatment
GROUP BY `Treatment Type`
ORDER BY Avg_Treatment_Cost DESC;

#11 Total lab tests conducted
SELECT COUNT(`Lab Result ID`) AS Total_Lab_Tests
FROM `lab test`;

#12 Total Lab Tests by Month
SELECT DATE_FORMAT(`Test Date`, '%b') AS Month_Name,
       COUNT(`Lab Result ID`) AS Total_Lab_Tests
FROM `lab test`
GROUP BY MONTH(`Test Date`), DATE_FORMAT(`Test Date`, '%b')
ORDER BY MONTH(`Test Date`);
 
 #13 Percentage of Abnormal Lab Results
SELECT 
    ROUND(
        COUNT(CASE WHEN `Test Result` = 'Abnormal' THEN `Lab Result ID` END) * 100.0
        / COUNT(`Lab Result ID`), 2
    ) AS Abnormal_Result_Percentage
FROM `lab test`;

#14 Avg Patients per Doctor
SELECT
FORMAT(COUNT(`Visit ID`) / COUNT(DISTINCT `Doctor ID`), 2) AS Avg_Patients_Per_Doctor
FROM visit;
 


