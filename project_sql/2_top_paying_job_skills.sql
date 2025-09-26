/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying UK Data Analyst jobs from first query.
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping UK job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        salary_hour_avg * 2080 AS yearly_salary_from_hourly_rate, --Getting yearly salary using hourly rate, assuming full time job schedule
        name AS company_name
    FROM
        job_postings_fact AS job_postings
    LEFT JOIN company_dim AS companies
    ON job_postings.company_id = companies.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_schedule_type = 'Full-time' AND
        (job_location LIKE '%UK%' OR job_location LIKE '%United Kingdom%') AND
        (salary_year_avg IS NOT NULL OR
        salary_hour_avg IS NOT NULL)
    ORDER BY
        GREATEST(salary_year_avg, salary_hour_avg * 2080) DESC --Ordering from highest to lowest salary, including salaries calculated from hourly rate
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim AS skills_to_job
ON top_paying_jobs.job_id = skills_to_job.job_id
INNER JOIN skills_dim AS skills
ON skills_to_job.skill_id = skills.skill_id
ORDER BY
    GREATEST(salary_year_avg, yearly_salary_from_hourly_rate) DESC --Ordering from highest to lowest salary, including salaries calculated from hourly rate


/*
The skill breakdown of the top 10 highest-paying roles in the UK is as follows:

SQL – Appears in all 10 roles; essential for any high-paying data job.
Python – Appears in 9 roles; critical for analysis, automation, and modeling.
Excel – Appears in 4 roles; key for reporting and quick analysis.
Other important skills – R, Power BI, Tableau, Looker, MySQL, SQL Server, NoSQL/MongoDB, Pandas, NumPy, Jupyter, AWS, Azure, Flow; support advanced analytics, visualization, cloud, and large-scale data management.
*/

/*
[
  {
    "job_id": 1401033,
    "job_title": "Market Data Lead Analyst",
    "salary_year_avg": "180000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Deutsche Bank",
    "skills": "excel"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "DeepMind",
    "skills": "python"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "DeepMind",
    "skills": "c++"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "DeepMind",
    "skills": "pandas"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "DeepMind",
    "skills": "numpy"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "DeepMind",
    "skills": "tensorflow"
  },
  {
    "job_id": 159866,
    "job_title": "Research Engineer, Science",
    "salary_year_avg": "177283.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "DeepMind",
    "skills": "pytorch"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Darktrace",
    "skills": "sql"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Darktrace",
    "skills": "mysql"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Darktrace",
    "skills": "sql server"
  },
  {
    "job_id": 1563887,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Darktrace",
    "skills": "flow"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "sql"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "python"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "scala"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "r"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "mongodb"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "postgresql"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "elasticsearch"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "sql server"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "mongodb"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "azure"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "aws"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "redshift"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "oracle"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "aurora"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "hadoop"
  },
  {
    "job_id": 258461,
    "job_title": "Data Architect",
    "salary_year_avg": "165000.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AND Digital",
    "skills": "kafka"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "salary_year_avg": "163782.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Logispin",
    "skills": "nosql"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "salary_year_avg": "163782.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Logispin",
    "skills": "azure"
  },
  {
    "job_id": 478395,
    "job_title": "Data Architect",
    "salary_year_avg": "163782.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Logispin",
    "skills": "looker"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Shell",
    "skills": "shell"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Shell",
    "skills": "express"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Shell",
    "skills": "excel"
  },
  {
    "job_id": 1813715,
    "job_title": "Data Architect - Trading and Supply",
    "salary_year_avg": "156500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Shell",
    "skills": "flow"
  },
  {
    "job_id": 217504,
    "job_title": "Analytics Engineer - ENA London, Warsaw- (F/M)",
    "salary_year_avg": "139216.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AccorCorpo",
    "skills": "sql"
  },
  {
    "job_id": 217504,
    "job_title": "Analytics Engineer - ENA London, Warsaw- (F/M)",
    "salary_year_avg": "139216.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AccorCorpo",
    "skills": "python"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AJ Bell",
    "skills": "sql"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AJ Bell",
    "skills": "python"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AJ Bell",
    "skills": "r"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AJ Bell",
    "skills": "excel"
  },
  {
    "job_id": 307234,
    "job_title": "Finance Data Analytics Manager",
    "salary_year_avg": "132500.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "AJ Bell",
    "skills": "power bi"
  },
  {
    "job_id": 694461,
    "job_title": "Sr Data Analyst",
    "salary_year_avg": "118140.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Hasbro",
    "skills": "sql"
  },
  {
    "job_id": 694461,
    "job_title": "Sr Data Analyst",
    "salary_year_avg": "118140.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Hasbro",
    "skills": "python"
  },
  {
    "job_id": 694461,
    "job_title": "Sr Data Analyst",
    "salary_year_avg": "118140.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Hasbro",
    "skills": "jupyter"
  },
  {
    "job_id": 694461,
    "job_title": "Sr Data Analyst",
    "salary_year_avg": "118140.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Hasbro",
    "skills": "tableau"
  },
  {
    "job_id": 694461,
    "job_title": "Sr Data Analyst",
    "salary_year_avg": "118140.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Hasbro",
    "skills": "power bi"
  },
  {
    "job_id": 694461,
    "job_title": "Sr Data Analyst",
    "salary_year_avg": "118140.0",
    "yearly_salary_from_hourly_rate": null,
    "company_name": "Hasbro",
    "skills": "looker"
  }
]
*/
