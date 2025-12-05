WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
FROM january_jobs;


-- ************************************* --

SELECT
    company_id,
    job_no_degree_mention
FROM job_postings_fact

WHERE job_no_degree_mention = true;


-- ************************************* --


/*
Look at companies that don’t require a degree 
- Degree requirements are in the job_posting_fact table
- Use subquery to filter this in the company_dim table for company_names
- Order by the company name alphabetically
*/

SELECT
    company_id,
    name  AS company_name
FROM company_dim

WHERE company_id IN(
    SELECT company_id

    FROM job_postings_fact

    WHERE job_no_degree_mention = true

    ORDER BY company_id
);

-- ************************************** --


/*
Find the companies that have the most job openings. 
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/


WITH Company_Job_Count AS(
    SELECT
        company_id,
        COUNT(*) AS Total_Jobs

    FROM
        job_postings_fact
    
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS Company_Name,
    Company_Job_Count.Total_Jobs
FROM
    company_dim
LEFT JOIN Company_Job_Count ON Company_Job_Count.company_id = company_dim.company_id
ORDER BY
    Total_Jobs DESC