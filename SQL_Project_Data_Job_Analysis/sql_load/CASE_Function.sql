SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

-----------------------------------------------------

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

------------------------------------------------------

SELECT 
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE 
        job_no_degree_mention = true AND
        job_title_short = 'Data Analyst'
)

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM   
        job_postings_fact
    GROUP BY
        company_id  
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM
    company_dim
LEFT JOIN
    company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC