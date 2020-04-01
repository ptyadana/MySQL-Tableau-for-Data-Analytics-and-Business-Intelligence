/* Schema: employees_mod.sql */

/*Create a visualization that provides a breakdown between the male and female employees working in the company
each year, starting from 1990*/

/*CSV Output:01_employees_joined_by_gender.csv*/
SELECT 
    DATE_FORMAT(d.from_date,"%Y") AS calender_year,
    CASE
		WHEN e.gender = "M" THEN "Male"
        ELSE "Female"
    END AS gender,
    COUNT(e.gender) AS number_of_employees
FROM t_employees e
JOIN t_dept_emp d ON e.emp_no = d.emp_no
GROUP BY 1,2
HAVING calender_year >= 1990
ORDER BY 1,2;


/*Compare the number of male managers to the number of female managers 
from different departments for each year, starting from 1990*/

/*CSV Output: 02_male_vs_female_manager_across_years.csv*/
SELECT dept_emp.dept_name, dept_emp.gender,dept_emp.emp_no,dept_emp.from_date,dept_emp.to_date,e.calendar_year,
	CASE
		WHEN YEAR(dept_emp.from_date) <= e.calendar_year AND YEAR(dept_emp.to_date) >= e.calendar_year THEN 1
        ELSE 0
    END AS active_as_manager
FROM 
	(SELECT YEAR(e.hire_date) AS calendar_year
	FROM t_employees e
	GROUP BY calendar_year
	ORDER BY 1) e
CROSS JOIN
	(SELECT d.dept_name, ee.gender,dm.emp_no,dm.from_date,dm.to_date
FROM t_dept_emp de 
JOIN t_departments d ON de.dept_no = d.dept_no
JOIN t_employees ee ON ee.emp_no = de.emp_no
JOIN t_dept_manager dm ON dm.emp_no = ee.emp_no) dept_emp
ORDER BY dept_emp.emp_no, e.calendar_year;


/*Compare the average salary of female versus male employees in the entire company until year 2002.
and add a filter following you to see that per each department.*/

/*CSV Output: 03_male_vs_female_average_salary_across_years.csv*/
SELECT e.gender, d.dept_name, ROUND(AVG(s.salary),2) AS salary, YEAR(s.from_date) AS calendar_year
FROM t_employees e
JOIN t_dept_emp de ON de.emp_no = e.emp_no
JOIN t_departments d ON d.dept_no = de.dept_no
JOIN t_salaries s ON s.emp_no = e.emp_no
GROUP BY d.dept_no, e.gender, calendar_year
HAVING calendar_year <=2002
ORDER BY d.dept_no;

/*Create an SQL stored procedure that will allow you to obtain the average male and female salary per department 
within a certain salary range. Let this range be defined by two values the user can insert when calling the procedure.
Finally, visualize the obtained result-set in Tableau as a double bar chart.*/

/*CSV Output: 04_male_vs_female_average_salary_within_specific_range.csv*/
DROP PROCEDURE IF EXISTS getAverageSalrayMaleVsFemale;

DELIMITER $$
CREATE PROCEDURE getAverageSalrayMaleVsFemale(IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
	SELECT e.gender, d.dept_name, ROUND(AVG(s.salary),2) AS avg_salary
	FROM t_employees e
	JOIN t_dept_emp de ON de.emp_no = e.emp_no
	JOIN t_departments d ON d.dept_no = de.dept_no
	JOIN t_salaries s ON s.emp_no = e.emp_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
	GROUP BY d.dept_no, e.gender;
END $$
DELIMITER ;

CALL getAverageSalrayMaleVsFemale(50000, 90000);

