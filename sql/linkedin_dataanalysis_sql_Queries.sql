select * from dbo.linkedin_data_analyst
---1. Total Jobs
select COUNT(*) from dbo.linkedin_data_analyst; 
---2. Average Salary
SELECT ROUND(AVG((min_salary + max_salary) / 2.0),0) AS mean_avg_salary
FROM linkedin_data_analyst
WHERE min_salary IS NOT NULL AND max_salary IS NOT NULL;
---3. Highest salary
select MAX(max_salary) MAX_SALARY_
from dbo.linkedin_data_analyst
---3. Lowest salary
select MIN(min_salary) MIN_SALARY_
from dbo.linkedin_data_analyst
---4.Distinct number of companies
SELECT COUNT(DISTINCT LTRIM(RTRIM(LOWER(company))))
FROM dbo.linkedin_data_analyst WHERE company IS NOT NULL AND company <> '';
---5. Jobs per onsite and remote and hybrid
SELECT onsite_remote,COUNT(*) AS job_count
FROM dbo.linkedin_data_analyst
GROUP BY onsite_remote;
---6. Average Salary by Country
SELECT Country,ROUND(AVG((min_salary + max_salary) / 2.0), 1) AS avg_salary
FROM dbo.linkedin_data_analyst
WHERE min_salary IS NOT NULL AND max_salary IS NOT NULL
GROUP BY Country
ORDER BY avg_salary;
---7. Job Count By Country
select Country,onsite_remote,COUNT(*) as Jobs
from dbo.linkedin_data_analyst
group by onsite_remote,Country
order by Jobs 
---8. Top 7 Roles per country
WITH TotalRoleCounts AS (
  SELECT title,COUNT(*) AS total_jobs FROM dbo.linkedin_data_analyst
  GROUP BY title
),
Top7Roles AS (
  SELECT TOP 7 title FROM TotalRoleCounts
  ORDER BY total_jobs DESC
),
RoleCountryCounts AS (
  SELECT title,country,COUNT(*) AS jobs_in_country
  FROM dbo.linkedin_data_analyst
  WHERE title IN (SELECT title FROM Top7Roles)
  GROUP BY title, country
)
SELECT * FROM RoleCountryCounts
ORDER BY title, country;
---9. Average Min salary and Average Max Salary per country
SELECT Country, Round(AVG(max_salary),0) avgmax,Round(AVG(min_salary),0) avgmin
from dbo.linkedin_data_analyst
group by Country

