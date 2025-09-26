/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on positions in the UK with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis.
*/

WITH skills_demand AS (
    SELECT
        skills.skill_id,
        skills,
        COUNT(job_postings.job_id) AS job_count
    FROM
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id
    WHERE
        job_postings.job_title_short = 'Data Analyst' AND
        (job_location LIKE '%UK%' OR job_location LIKE '%United Kingdom%') AND
        job_postings.salary_year_avg IS NOT NULL
    GROUP BY
        skills.skill_id
),

average_salary AS (
    SELECT
        skills.skill_id,
        skills,
        ROUND(AVG(job_postings.salary_year_avg), 0) AS avg_yearly_salary
    FROM
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS skills_to_job
    ON job_postings.job_id = skills_to_job.job_id
    INNER JOIN skills_dim AS skills
    ON skills_to_job.skill_id = skills.skill_id
    WHERE
        job_postings.salary_year_avg IS NOT NULL AND
        job_postings.job_title_short = 'Data Analyst' AND
        (job_location LIKE '%UK%' OR job_location LIKE '%United Kingdom%')
    GROUP BY
        skills.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    job_count,
    avg_yearly_salary
FROM
    skills_demand
INNER JOIN average_salary
ON skills_demand.skill_id = average_salary.skill_id
WHERE
    job_count > 1
ORDER BY
    avg_yearly_salary DESC,
    job_count DESC
LIMIT 25

-- rewriting the query above more concisely

SELECT
    skills.skill_id,
    skills.skills,
    COUNT(skills_to_job.job_id) AS job_count,
    ROUND(AVG(job_postings.salary_year_avg), 0) AS avg_yearly_salary
FROM
    job_postings_fact AS job_postings
INNER JOIN skills_job_dim AS skills_to_job
ON job_postings.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
ON skills_to_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    (job_location LIKE '%UK%' OR job_location LIKE '%United Kingdom%')
GROUP BY
    skills.skill_id
HAVING
    COUNT(skills_to_job.job_id) > 1  -- Ensuring there is more than one job for a skill so the results are more reliable.
ORDER BY
    avg_yearly_salary DESC,
    job_count DESC
LIMIT 25;