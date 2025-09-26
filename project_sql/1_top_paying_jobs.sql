/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in the UK.
- Focuses on job postings with specified salaries (remove NULLs).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment skill requirements and the value of skills.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    salary_hour_avg * 2080 AS yearly_salary_from_hourly_rate, --Getting yearly salary using hourly rate, assuming full time job schedule
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies
ON job_postings.company_id = companies.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_schedule_type = 'Full-time' AND
    (job_location LIKE '%UK%' OR
    job_location LIKE '%United Kingdom%') AND
    (salary_year_avg IS NOT NULL OR
    salary_hour_avg IS NOT NULL)
ORDER BY
    GREATEST(salary_year_avg, salary_hour_avg * 2080) DESC --Ordering from highest to lowest salary, including salaries calculated from hourly rate
LIMIT 10
