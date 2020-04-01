/* There can be multiple entries for an employee who has changed to different departments*/
SELECT emp_no, from_date, to_date, COUNT(emp_no) AS total_number
FROM dept_emp
GROUP BY emp_no
HAVING total_number > 1;

/*get the latest department info of the employee using VIEW*/
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
	SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM dept_emp
    GROUP BY emp_no;
    
SELECT * FROM v_dept_emp_latest_date;


/*Create a view that will extract the average salary of all managers registered in the database. 
Round this value to the nearest cent.
you should obtain the value of 67047.29.*/

CREATE OR REPLACE VIEW v_avg_salary_manager AS
	SELECT ROUND(AVG(salary),2) AS avg_salary
	FROM salaries s
	JOIN dept_manager dm
	ON s.emp_no = dm.emp_no;
    
SELECT * FROM v_avg_salary_manager;