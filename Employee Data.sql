-- Creating the employee_data table
CREATE TABLE employee_data (
    id  INT,
    first_name   VARCHAR(50),
    last_name    VARCHAR(50),
    age          INT,
    job_level    VARCHAR(20),
    job_title    VARCHAR(50),
    date_of_hire DATE
);
-- Inserting data into employee data table
INSERT INTO employee_data (id,first_name, last_name, age, job_level, job_title, date_of_hire)
VALUES
    (1, 'Alex', 'Adekunle', 28, 'Entry Level', 'Product Manager', '2022-01-15'),
    (2,  'Chloe', 'Okoro',  35, 'Mid Level', 'Data Analyst', '2021-09-10'),
    (3,  'Caleb', 'Ogbonna', 24, 'Entry Level', 'UX/UI Designer', '2023-03-05'),
    (4, 'Emily', 'Adebayo', 29, 'Mid Level', 'Project Manager', '2020-11-20'),
    (5, 'Ethan', 'Onuoha', 22, 'Entry Level', 'Marketing Coordinator', '2023-06-01'),
    (6,  'Grace', 'Okafor', 31, 'Senior Level', 'Data Scientist', '2019-07-12'),
    (7,  'David', 'Adeyemi', 26, 'Mid Level', 'Data Analyst', '2022-09-30'),
    (8,  'Lily', 'Nwosu', 33, 'Senior Level', 'Software Engineer', '2018-05-15'),
    (9,  'Joshua', 'Mohammed', 27, 'Entry Level', 'Graphic Designer', '2023-02-25'),
    (10,  'Olivia', 'Ibe', 30, 'Mid Level', 'HR Specialist', '2021-04-05'),
    (11,  'Daniel', 'Onwuka', 25, 'Entry Level', 'Software Engineer', '2023-07-01'),
    (12,  'Ava', 'Ogunleye', 32, 'Senior Level', 'IT Manager', '2017-10-18'),
    (13,  'Isaac', 'Aliyu', 23, 'Entry Level', 'UI/UX Designer', '2023-06-10'),
    (14,  'Mia', 'Okeke', 28, 'Mid Level', 'Data Analyst', '2020-08-29'),
    (15,  'Nathan', 'Adeleke', 29, 'Mid Level', 'HR specialist', '2021-02-12'),
    (16,  'Sophia', 'Igbinedion', 34, 'Senior Level', 'IT Manager', '2019-01-08'),
    (17,  'Samuel', 'Okaikoi', 26, 'Mid Level', 'UX/UI Designer', '2022-04-20'),
    (18,  'Amelia', 'Eze', 31, 'Senior Level', 'Product Manager', '2018-07-25'),
    (19,  'Elijah',	'Oladipo', 27, 'Mid Level', 'Marketing Assistant', '2022-03-03'),
    (20, 'Harper', 'Akinwale', 24, 'Entry Level', 'Software Engineer', '2023-01-05');
	
-- Creating employee_salary table
CREATE TABLE employee_salary (
         emp_id INT,
         employment_status VARCHAR(20),
         salary INT
);
-- Inserting data into employee salary table
INSERT INTO employee_salary (emp_id, employment_status, salary)
VALUES
    (1, 'Full-Time', 60000),
    (2, 'Full-Time', 70000),
    (3, 'Contractor', 50000),
    (4, 'Full-Time', 75000),
    (5, 'Intern', 40000),
    (6, 'Full-Time', 90000),
    (7, 'Part-Time', 60000),
    (8, 'Full-Time', 110000),
    (9, 'Contractor', 48000),
    (10, 'Full-Time', 65000),
    (11, 'Full-Time', 55000),
    (12, 'Full-Time', 95000),
    (13, 'Intern', 38000),
    (14, 'Full-Time', 72000),
    (15, 'Full-Time', 68000),
    (16, 'Full-Time', 100000),
    (17, 'Full-Time', 80000),
    (18, 'Part-Time', 75000),
    (19, 'Full-Time', 62000),
    (20, 'Full-Time', 56000);

-- Showing the table 
SELECT *
FROM employee_data;

SELECT *
FROM employee_salary;

-- What is the total number of employees in the organization
SELECT COUNT(*)
FROM employee_data;
-- Find the number of employees  in each job_title
SELECT job_title, COUNT(*) AS num_employees
FROM employee_data
GROUP BY 1;
-- Which job_level has the highest average salary 
WITH avg_salary_per_joblevel AS(SELECT job_level, ROUND(AVG(salary),0) avg_salary
								FROM employee_data ed
								JOIN employee_salary eS
								ON ed.id = es.emp_id
								GROUP BY 1)
SELECT job_level, avg_salary
FROM avg_salary_per_joblevel
WHERE avg_salary = (SELECT MAX(avg_salary)
				   FROM avg_salary_per_joblevel);
-- Find the top 5 highest paid employees along with their job title, job level, and salary.				   
SELECT ed.id, CONCAT(first_name,' ',last_name) AS full_name, ed.job_title,ed.job_level, es.salary
FROM employee_data ed
JOIN employee_salary es
ON ed.id = es.emp_id
order by es.salary DESC
LIMIT 5;
-- What is the total count of employees for each age group
SELECT CASE WHEN age >= 20 AND age <= 25 THEN '20-25'
            WHEN age > 25 AND age <=30 THEN '26-30'
            ELSE 'above 30'  END AS age_group,
	    COUNT(*) AS employee_count
FROM employee_data
GROUP BY 1;
-- How many employees were hired in each year
SELECT DATE_PART('year',date_of_hire) AS year, COUNT(*) AS employee_count
FROM employee_data
GROUP BY 1
ORDER BY 1;
-- What is the number of employees who are in full-time, part-time,contractor and intern employment status in each job_level 
SELECT job_level,
           COUNT(CASE WHEN employment_status = 'Full-Time' THEN 1 END) AS full_time,
	   COUNT(CASE WHEN employment_status = 'Part_Time' THEN 1 END) AS part_time,
	   COUNT(CASE WHEN employment_status = 'Contractor' THEN 1 END) AS contractor,
	   COUNT(CASE WHEN employment_status = 'Intern' THEN 1 END) AS Intern
FROM employee_data ed
JOIN employee_salary es
ON  ed.id = es.emp_id
GROUP BY 1;
	   















	
	
	
	
	
