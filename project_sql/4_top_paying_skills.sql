/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, in the UK.
- Why? It reveals how different skills impact salary levels for Data Analysts and
    helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
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
    skills
ORDER BY
    avg_yearly_salary DESC
LIMIT 25

/*
Analysis

Shift Toward Data Science & Engineering:
Top earners (NumPy, Pandas, TensorFlow, PyTorch, C++) show that analysts with ML and engineering skills are most rewarded.

Databases & Big Data = Strong Value:
PostgreSQL, MongoDB, NoSQL, Redshift, Hadoop, SQL Server, Oracle pay well — demand is high for analysts who can manage and scale complex data systems.

Cloud is a Differentiator:
AWS, Azure, Aurora, Redshift stand out — cloud-first expertise sets analysts apart.

Streaming & Search Tech:
Kafka, Elasticsearch highlight a premium for real-time and advanced search capabilities.

Beyond SQL: Programming Edge:
C++, Scala, JavaScript, Shell scripting raise salaries — showing value in automation, pipelines, and integration skills.

Niche / Business Skills:
GDPR and DAX matter in compliance-heavy and BI-focused roles, especially with Power BI in enterprises.
*/

/*
[
  {
    "skills": "numpy",
    "avg_yearly_salary": "177283"
  },
  {
    "skills": "tensorflow",
    "avg_yearly_salary": "177283"
  },
  {
    "skills": "pytorch",
    "avg_yearly_salary": "177283"
  },
  {
    "skills": "c++",
    "avg_yearly_salary": "177283"
  },
  {
    "skills": "pandas",
    "avg_yearly_salary": "177283"
  },
  {
    "skills": "postgresql",
    "avg_yearly_salary": "165000"
  },
  {
    "skills": "aurora",
    "avg_yearly_salary": "165000"
  },
  {
    "skills": "kafka",
    "avg_yearly_salary": "165000"
  },
  {
    "skills": "elasticsearch",
    "avg_yearly_salary": "165000"
  },
  {
    "skills": "mongodb",
    "avg_yearly_salary": "165000"
  },
  {
    "skills": "nosql",
    "avg_yearly_salary": "163782"
  },
  {
    "skills": "shell",
    "avg_yearly_salary": "156500"
  },
  {
    "skills": "aws",
    "avg_yearly_salary": "138088"
  },
  {
    "skills": "mysql",
    "avg_yearly_salary": "131750"
  },
  {
    "skills": "oracle",
    "avg_yearly_salary": "124892"
  },
  {
    "skills": "redshift",
    "avg_yearly_salary": "122925"
  },
  {
    "skills": "sql server",
    "avg_yearly_salary": "120379"
  },
  {
    "skills": "flow",
    "avg_yearly_salary": "113662"
  },
  {
    "skills": "hadoop",
    "avg_yearly_salary": "112141"
  },
  {
    "skills": "javascript",
    "avg_yearly_salary": "111175"
  },
  {
    "skills": "azure",
    "avg_yearly_salary": "110922"
  },
  {
    "skills": "scala",
    "avg_yearly_salary": "108007"
  },
  {
    "skills": "gdpr",
    "avg_yearly_salary": "105000"
  },
  {
    "skills": "dax",
    "avg_yearly_salary": "105000"
  },
  {
    "skills": "express",
    "avg_yearly_salary": "104757"
  }
]
*/