/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2.
- Identify the top 5 in-demand skills for a data analyst.
- Focus on job postings in the UK.
- Why? Retrieves the top 5 skills with the highest demand in the UK job market,
    providing insights into the most valuable skills for UK job seekers.
*/

SELECT
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
    (job_location LIKE '%UK%' OR job_location LIKE '%United Kingdom%')
GROUP BY
    skills
ORDER BY
    job_count DESC
LIMIT 5

/*
As can be seen by the results, the top 5 most in-demand skills for data analysts in the UK are:

SQL – most in-demand, featured in 4,011 job postings.
Excel – essential, appearing in 3,909 postings.
Power BI – key for visualization, 2,604 postings.
Python – growing importance for analytics, 1,877 postings.
Tableau – data visualization skill, 1,463 postings.
*/

/*
[
  {
    "skills": "sql",
    "job_count": "4011"
  },
  {
    "skills": "excel",
    "job_count": "3909"
  },
  {
    "skills": "power bi",
    "job_count": "2604"
  },
  {
    "skills": "python",
    "job_count": "1877"
  },
  {
    "skills": "tableau",
    "job_count": "1463"
  }
]
*/