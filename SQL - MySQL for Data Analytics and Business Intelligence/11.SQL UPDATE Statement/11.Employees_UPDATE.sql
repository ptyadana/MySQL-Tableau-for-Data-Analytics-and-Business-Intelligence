/*COMMIT AND ROLL BACK */

-- for testing purpose, disable autocommit
SET autocommit = 0;
 
SELECT *
FROM employees
WHERE emp_no = '999901';

UPDATE employees
SET first_name = 'Stella', gender = 'M'
WHERE emp_no = '999901';

ROLLBACK;

SELECT *
FROM employees
WHERE emp_no = '999901';

-- using commit 

UPDATE employees
SET first_name = 'Sally'
WHERE emp_no = '999901';

COMMIT;

SELECT *
FROM employees
WHERE emp_no = '999901';

ROLLBACK;

-- now the changes are aready commmited, it cannot be rollback
SELECT *
FROM employees
WHERE emp_no = '999901';

-- change back to auto commit
SET autocommit = 1;

/*------------------------------------------------------------------*/

/*Change the “Business Analysis” department name to “Data Analysis”.
Hint: To solve this exercise, use the “departments” table.*/
INSERT INTO departments(dept_no,dept_name)
VALUES('d010','Business Analysis');

SELECT *
FROM departments;

COMMIT;

UPDATE departments
SET dept_name = 'Data Analysis'
WHERE dept_no = 'd010';




