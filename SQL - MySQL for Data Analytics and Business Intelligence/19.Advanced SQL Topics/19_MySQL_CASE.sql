
/*************************************************/
/*        MySQL CASE                             */
/*************************************************/

/*Technique 1*/
SELECT emp_no, first_name, last_name,
	CASE
		WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM employees;

/*Technique 2*/
SELECT emp_no, first_name, last_name,
	CASE gender
		WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM employees;

/*-------------------------------------*/

/*************************************************/
/*        IF()                                    */
/*************************************************/

SELECT emp_no, first_name, last_name,
	IF (gender = 'M', 'Male', 'Female') AS gender
FROM employees;


/******************************************************/

/*Similar to the exercises done in the lecture, obtain a result set containing the employee number, first name, 
and last name of all employees with a number higher than 109990. 
Create a fourth column in the query, indicating whether this employee is also a manager, 
according to the data provided in the dept_manager table, or a regular employee. */
SELECT e.emp_no, e.first_name, e.last_name,
	CASE
		WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Regular Employee'
    END AS manager_or_employee
FROM employees e
LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;


/*Extract a dataset containing the following information about the managers: 
employee number, first name, and last name. Add two columns at the end – 
one showing the difference between the maximum and minimum salary of that employee, and another one saying 
whether this salary raise was higher than $30,000 or NOT.

If possible, provide more than one solution.*/
SELECT e.emp_no, e.first_name,e.last_name, MIN(salary) AS min_salary, MAX(salary) AS max_salary,
	MAX(salary) - MIN(salary) AS salary_difference,
	CASE 
		WHEN(MAX(salary) - MIN(salary)) > 30000 THEN 'YES'
        ELSE 'NO'
    END AS salary_raised_higher_than_30000
FROM employees e
JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY 1
ORDER BY 1;


/*Using IF*/
SELECT e.emp_no, e.first_name,e.last_name, MIN(salary) AS min_salary, MAX(salary) AS max_salary,
	MAX(salary) - MIN(salary) AS salary_difference,
	IF (MAX(salary) - MIN(salary) > 30000, 'YES', 'NO') AS salary_raised_higher_than_30000
FROM employees e
JOIN salaries s ON s.emp_no = e.emp_no
GROUP BY 1
ORDER BY 1;

/*Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column,
 called “current_employee” saying “Is still employed” if the employee is still working in the company, or 
 “Not an employee anymore” if they aren’t.
Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise. */
SELECT e.emp_no, e.first_name,e.last_name,
	CASE
		WHEN MAX(de.to_date) > curdate() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS employee_status
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
GROUP BY 1
ORDER BY 1;