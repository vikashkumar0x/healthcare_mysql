# Healthcare Data Analytics Queries
use healthcare_db;
Show tables;

#1 Total Patients
select count(`Patient ID`) as Total_Patients
from `patient new`;

#2 Total Doctors
select Count(`Doctor ID`) as Total_doctors
from doctor;

#3 Total Revenue
select concat(
       round((
       sum(`Treatment cost`)+sum(Cost)) /1000000, 2), 'M') as Total_Revenue
from treatment;

#4 Year-Wise Total Patients
select year(`Visit Date`) as Year,
       count(`Patient ID`) as Total_Patients
       from visit
       group by Year;
#5 Average Age of Patients
select round(avg(Age), 2) as Average_Age
from `patient new`;

#6 Top 5 Diagnosed Conditions
select Diagnosis, count(*) As Total_Cases
from visit
group by Diagnosis
order by Total_Cases desc
Limit 5;

#7 Month-wise follow up Patients
select
      monthname(`Visit Date`) as Month,
      concat( round( 
	          count(case when `Follow Up Required`= 'Yes' then 1 end)
              *100 /count(*), 2), '%') as Follow_Up_Rate
from visit 
group by month(`Visit Date`), month
order by month(`Visit Date`);

#8 Average Treatment Cost
select 
      Round(avg(`treatment Cost`), 2) as AVG_Treatment
from treatment;

#9 Average Treatment Cost by Treatment Type
select `Treatment Type`,
round(avg(`Treatment Cost`), 2) as AVG_Treatment_Cost
from treatment
group by `Treatment Type`
order by AVG_Treatment_Cost desc;

#10 Total lab tests conducted
select count(`Lab Result ID`) as Total_Lab_result
from `lab test`;

#11 Total Lab Tests by Month
select monthname(`Test Date`) as Month,
       count(`Lab Result ID`) as Total_count
       from `lab test`
       group by month(`Test Date`), month 
       order by month(`Test Date`);

#12 Percentage of Abnormal Lab Results
select 
      concat( round( 
      count(case when `Test Result`= 'Abnormal' then 1 end)
      *100 / count(*), 2), '%') as Percentage_of_Abnormal_result
      from `lab test`;
      
#13 Total Lab Tests by Month
select monthname(`Test Date`) as Month,
       count(`Lab Result ID`) as Total_count
       from `lab test`
       group by month(`Test Date`), month 
       order by month(`Test Date`);
       
#14 Avg Patients per Doctor
select 
      round(count(`Visit ID`) / count(distinct `Doctor ID`), 2) Avg_Patients_Per_Doctor
      from visit;


