/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000 
- Filter for Data Analyst Jobs and order by salary
*/


SELECT 
        quarter1_job_postings.job_title_short,
        quarter1_job_postings.job_location,
        quarter1_job_postings.job_via,
        quarter1_job_postings.job_posted_date::DATE,
        quarter1_job_postings.salary_year_avg
FROM (
    SELECT *,
        EXTRACT(MONTH FROM job_posted_date) AS month
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) BETWEEN 1 AND 3
) AS quarter1_job_postings

WHERE 
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
    
ORDER BY quarter1_job_postings.salary_year_avg DESC    ;