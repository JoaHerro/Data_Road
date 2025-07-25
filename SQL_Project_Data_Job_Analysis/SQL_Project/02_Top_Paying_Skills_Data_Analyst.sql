/*
    Question: What skills are requiered for top-payings data analyst jobs?
    - Using the top 10 paying jobs for Data Analyst.
    - Add the specific skills requiered for those roles.
    - Why? It provides a detailed look at which skills to develop that align with tp salaries.
*/


WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON  job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 
        10
) 

SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON  
    top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
    skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC


/*
    - Core data tools like sql, python, r, pandas, and excel are highly sought after.

    - Skills linked to cloud services and BI tools, such as aws and power bi, are associated with top-tier salaries.

    - While frequency shows demand, high-salary skills might indicate premium niche skills or high-value roles.
*/