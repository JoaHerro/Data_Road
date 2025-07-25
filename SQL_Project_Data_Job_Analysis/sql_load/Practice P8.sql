SELECT
    Q1_job_postings.job_title_short,
    Q1_job_postings.job_location,
    Q1_job_postings.job_via,
    Q1_job_postings.job_posted_date::DATE,
    Q1_job_postings.salary_year_avg
FROM (

    SELECT*
    FROM january_jobs

    UNION ALL

    SELECT*
    FROM february_jobs

    UNION ALL

    SELECT*
    FROM march_jobs
) AS Q1_job_postings 

WHERE 
    Q1_job_postings.salary_year_avg > 70000 AND job_title_short = 'Data Analyst'
ORDER BY
    Q1_job_postings.salary_year_avg DESC