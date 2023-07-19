/* PROJECT OVERVIEW
I assumed as a Data Analyst at Education for All, a charity organization, I have been assigned by the head
of fundraising to present insights from donation data to inform our fundraising strategy. The objective is 
to analyze the data and identify opportunities to increase the number of donors in our database,increase 
the donation frequency of existing donors, and increase the value of donation in our database. */

-- showing all rows and columns in the dataset
SELECT *
FROM donation_data;
SELECT * 
FROM donor_data2;

-- I created a visualization representing the analysis results in Tableau

-- 1. Who made the highest donation and what are their details
SELECT CONCAT(first_name,' ',last_name) AS full_name,
		gender,
		job_field,
		state,
		donation
FROM donation_data
WHERE donation = (SELECT MAX(donation) highest_donation
       			 FROM donation_data);
				 
-- 2. What are the top 5 states with the highest total donation amounts
SELECT state, COUNT(donation) AS num_donation, SUM(donation) AS total_donation
FROM donation_data
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5;
-- and What are the bottom 5 states with the lowest total donation amounts
SELECT state, COUNT(donation) AS num_donation, SUM(donation) AS total_donation
FROM donation_data
GROUP BY 1
ORDER BY 3 
LIMIT 5;

-- 3. What are the car,university,second language and faviorite color of the top 10 highest donors
		d1.last_name, 
		d2.car,
		d2.university,
		d2.second_language, 
		d2.favourite_colour,
		d1.donation
FROM donation_data d1
JOIN donor_data2 d2
ON d1.id = d2.id
ORDER BY d1.donation DESC
LIMIT 10;

-- 4. What is the number of donors that attended a university and the number of those that didn't attend

SELECT SUM(CASE WHEN university IS NULL THEN 1 ELSE 0 END) AS uneducated,
       SUM(CASE WHEN university IS NOT NULL THEN 1 ELSE 0  END) AS educated
FROM donation_data d1
LEFT JOIN donor_data2 d2
ON d1.id = d2.id;
-- 5.What is the number of donation and total donation for each gender
SELECT gender, COUNT(donation) AS num_donation, SUM(donation) AS total_donation
FROM donation_data
GROUP BY 1;
-- 6. What is the total donation amount for each donation frequency
SELECT d2.donation_frequency, SUM(d1.donation) total_donation
FROM donation_data d1
JOIN donor_data2 d2
ON d1.id = d2.id
GROUP BY 1
ORDER BY 2 DESC;

-- 7. What is the distribution of donation amounts in different donation groups 
SELECT CASE WHEN donation = 500 THEN '500'
			WHEN donation >= 400 AND donation < 500 THEN '400-499'
                        WHEN donation >= 300 AND donation < 400 THEN '300-399'
			WHEN donation >= 200 AND donation < 300 THEN '200-399'
			WHEN donation >= 100 AND donation < 200 THEN '100-199'
			ELse 'under 100' END AS donation_group, COUNT(*) count_donation
FROM donation_data
GROUP BY 1;

-- 8. what are the top 5 job fields by total donation
SELECT job_field,SUM(donation) AS total_donation
FROM donation_data
GROUP BY 1
ORDER BY 2 DESC;
			
