# Introduction

This project analyzes top-paying and most in-demand skills for remote Data Analyst roles, based on real-world job postings. Using a cleaned dataset containing 
* job titles
* average salaries
* company names
* associated skills

we extracted insights into which tools and technologies employers value most. 

The analysis reveals that skills like SQL, Python, and Tableau are the most frequently requested, while tools like Excel, Pandas, and R are linked to the highest average salaries. 

This repository includes the data, visualizations, and SQL code used to generate these insights.

SQL Queries here:

[sql_project folder](/SQL_Project_Data_Job_Analysis/)


# Tools Used

* **PostgreSQL**: Used to run complex SQL queries and extract insights on the most in-demand and highest-paying skills for Data Analyst roles.

* **SQLite**: Leveraged for lightweight local storage and quick testing of queries during development.

* **Git**: Employed for version control to maintain a clean and organized history of project changes.

* **GitHub**: Used for hosting the project, enabling collaboration, documentation, and sharing of results with the data community.

# Analysis

 ### Top-Paying Remote Data Analyst Jobs
This analysis focuses on identifying the top 10 highest-paying remote Data Analyst job postings. By filtering out job listings without specified salaries, we ensure the accuracy of the results. 

The goal is to highlight high-value opportunities in the job market, helping professionals and job seekers understand which companies offer the most competitive compensation for Data Analyst roles that can be performed remotely.

### Most In-Demand & Highest-Paying Skills for Remote Data Analysts
This section explores which technical skills are most in demand and which ones command the highest salaries for remote Data Analyst positions. By analyzing job postings with defined salaries and listed skills, we uncover patterns that can help guide professional development and career focus.

Key findings include:

* **SQL and Python** stand out as the most balanced skills, combining high demand with strong average salaries, making them essential foundations for any Data Analyst.

* **Excel and Tableau** remain consistently in demand across job postings, highlighting their continued relevance in business-focused analytics roles.

* **Pandas, PySpark, and Databricks** are associated with very high salaries but appear in fewer job postings — indicating that they are niche, high-leverage tools valued in specialized roles.

* **Snowflake and Go** fall into a mid-tier category, offering solid compensation with moderate demand.

``` sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
),

average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_location = 'Anywhere'
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM 
    skills_demand
INNER JOIN average_salary 
    ON skills_demand.skill_id = average_salary.skill_id
ORDER BY 
    skills_demand.demand_count DESC
LIMIT 25;

```


# What I learned

Through this project, I gained valuable experience in data cleaning, exploratory analysis, and SQL-based data extraction. I learned how to work with real-world job data to derive actionable insights, particularly in identifying high-paying roles and skill trends for remote Data Analyst positions.

### Key takeaways include:

* The importance of filtering and transforming unstructured text fields (like skills) to enable meaningful aggregation and analysis.

* How combining frequency analysis with salary metrics helps uncover both demand and value of technical skills.

* Practical use of tools like PostgreSQL and SQLite to handle datasets and run analytical queries.

* How to interpret data beyond the numbers — understanding the balance between skill popularity and salary potential to make informed career recommendations.

* Improved version control practices using Git and GitHub, especially when managing large files and collaborating in a professional project setting.

* This project sharpened both my technical and analytical thinking, and reinforced the value of storytelling with data.
