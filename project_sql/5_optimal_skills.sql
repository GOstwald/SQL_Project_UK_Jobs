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
    COUNT(skills_to_job.job_id) > 2  -- Ensuring there is atleast three jobs for a skill so the results are more reliable.
ORDER BY
    avg_yearly_salary DESC,
    job_count DESC
LIMIT 25;

/*
[
  {
    "skill_id": 79,
    "skills": "oracle",
    "job_count": "3",
    "avg_yearly_salary": "124892"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "job_count": "4",
    "avg_yearly_salary": "120379"
  },
  {
    "skill_id": 215,
    "skills": "flow",
    "job_count": "4",
    "avg_yearly_salary": "113662"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "job_count": "3",
    "avg_yearly_salary": "112141"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "job_count": "6",
    "avg_yearly_salary": "110922"
  },
  {
    "skill_id": 102,
    "skills": "jupyter",
    "job_count": "3",
    "avg_yearly_salary": "102580"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "job_count": "6",
    "avg_yearly_salary": "100969"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "job_count": "24",
    "avg_yearly_salary": "92402"
  },
  {
    "skill_id": 192,
    "skills": "sheets",
    "job_count": "4",
    "avg_yearly_salary": "91356"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "job_count": "7",
    "avg_yearly_salary": "90256"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "job_count": "9",
    "avg_yearly_salary": "88526"
  },
  {
    "skill_id": 0,
    "skills": "sql",
    "job_count": "33",
    "avg_yearly_salary": "87156"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "job_count": "29",
    "avg_yearly_salary": "83362"
  },
  {
    "skill_id": 22,
    "skills": "vba",
    "job_count": "4",
    "avg_yearly_salary": "83331"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "job_count": "13",
    "avg_yearly_salary": "82079"
  },
  {
    "skill_id": 196,
    "skills": "powerpoint",
    "job_count": "3",
    "avg_yearly_salary": "80558"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "job_count": "4",
    "avg_yearly_salary": "80551"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "job_count": "4",
    "avg_yearly_salary": "80551"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "job_count": "3",
    "avg_yearly_salary": "79866"
  },
  {
    "skill_id": 8,
    "skills": "go",
    "job_count": "9",
    "avg_yearly_salary": "74905"
  },
  {
    "skill_id": 188,
    "skills": "word",
    "job_count": "5",
    "avg_yearly_salary": "62003"
  },
  {
    "skill_id": 198,
    "skills": "outlook",
    "job_count": "6",
    "avg_yearly_salary": "57788"
  }
]
*/