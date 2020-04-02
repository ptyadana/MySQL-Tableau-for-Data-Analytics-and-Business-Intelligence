/*If you currently have the ‘departments_dup’ table set up, use DROP COLUMN to remove the ‘dept_manager’ column 
from the ‘departments_dup’ table.
Then, use CHANGE COLUMN to change the ‘dept_no’ and ‘dept_name’ columns to NULL.

(If you don’t currently have the ‘departments_dup’ table set up, create it. Let it contain two columns: dept_no and dept_name.
 Let the data type of dept_no be CHAR of 4, and the data type of dept_name be VARCHAR of 40. Both columns are allowed to have null values. 
 Finally, insert the information contained in ‘departments’ into ‘departments_dup’.)

Then, insert a record whose department name is “Public Relations”.
Delete the record(s) related to department number two.

Insert two new records in the “departments_dup” table. Let their values in the “dept_no” column be “d010” and “d011”.*/

DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup
(dept_no CHAR(4),
dept_name CHAR(40),
PRIMARY KEY (dept_no),
UNIQUE  KEY (dept_name));

INSERT INTO `departments_dup` VALUES 
('d001','Marketing'),
('d002','Finance'),
('d003','Human Resources'),
('d004','Production'),
('d005','Development'),
('d006','Quality Management'),
('d007','Sales'),
('d008','Research'),
('d009','Customer Service');

ALTER TABLE departments_dup
DROP PRIMARY KEY; 

ALTER TABLE departments_dup
DROP INDEX dept_name; 

ALTER TABLE departments_dup
MODIFY dept_no CHAR(4) NULL;

INSERT INTO departments_dup(dept_name) VALUES 
('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd011';

INSERT INTO departments_dup(dept_no) VALUES 
('d010'),
('d011');

/***************************************************/

/*Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. */
SELECT e.emp_no, e.first_name, e.last_name, de.dept_no, e.hire_date
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no;


/*Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
See if the output contains a manager with that name.  
‘emp_no’, ‘first_name’, ‘last_name’, ‘dept_no’, ‘from_date’. Order by 'dept_no' descending, and then by 'emp_no'.*/
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
LEFT JOIN dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC, e.emp_no;

/*Extract a list containing information about all managers’ employee number, first and last name, 
department number, and hire date. Use the old type of join syntax to obtain the result.*/
/*Old style*/
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e, dept_manager dm
WHERE  dm.emp_no = e.emp_no
ORDER BY dm.dept_no DESC, e.emp_no;

/*New Style*/
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM employees e
JOIN dept_manager dm ON dm.emp_no = e.emp_no
ORDER BY dm.dept_no DESC, e.emp_no;

/*Select the first and last name, the hire date, 
and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.*/
SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
JOIN titles t ON t.emp_no = e.emp_no
WHERE e.first_name = 'Margareta' AND e.last_name = 'Markovitch'
ORDER BY 1;

/*cross join with Department Manager and Departments to see possible combination*/
SELECT dm.emp_no, d.dept_name
FROM dept_manager dm
CROSS JOIN departments d
ORDER BY dm.emp_no, d.dept_no;

/*cross join with Department Manager and Departments to see possible combination
but except for the department he/she already in*/
SELECT dm.emp_no, d.dept_name
FROM dept_manager dm
CROSS JOIN departments d
WHERE dm.dept_no <> d.dept_no
ORDER BY dm.emp_no, d.dept_no;

/*Use a CROSS JOIN to return a list with all possible combinations between managers 
from the dept_manager table and department number 9.*/
SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no = 'd009'
ORDER BY dm.emp_no;

/*Return a list with the first 10 employees with all the departments they can be assigned to.
Hint: Don’t use LIMIT; use a WHERE clause.*/
SELECT e.*, d.*
FROM employees e
CROSS JOIN departments d
WHERE emp_no <= '10010'
ORDER BY e.emp_no, d.dept_name;

/*Select all managers’ first and last name, hire date, job title, start date, and department name.*/
SELECT e.first_name,e.last_name,e.hire_date,t.title,de.from_date, d.dept_name
FROM employees e
JOIN titles t ON t.emp_no = e.emp_no
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

/*How many male and how many female managers do we have in the ‘employees’ database?*/
SELECT e.gender, COUNT(e.gender) AS total_managers
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY e.gender;

/*Average salary of employees by each department */
SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON s.emp_no = de.emp_no
GROUP BY d.dept_no
ORDER BY 2 DESC;

/*Click 'Continue' and execute the query. What do you think is the meaning of 
the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)?
- operator : tell mysql to left this out. so basically, same as without using ORDER BY*/
SELECT *
FROM
    (SELECT e.emp_no, e.first_name, e.last_name, NULL AS dept_no, NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' 
		UNION 
	SELECT NULL AS emp_no, NULL AS first_name, NULL AS last_name, dm.dept_no, dm.from_date
    FROM dept_manager dm) AS a
ORDER BY -a.emp_no DESC;