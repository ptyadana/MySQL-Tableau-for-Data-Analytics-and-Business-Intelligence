
/*************************************************/
/*                STORED ROUTINES                */
/*************************************************/

/* -----------------------------------------------------*/
/*           select all employees limit 100             */
/* -----------------------------------------------------*/
USE employees;
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT * FROM employees
    LIMIT 100;
END $$
DELIMITER ;

/* -----------------------------------------------------*/
/*           Avarage salary of all employees            */
/* -----------------------------------------------------*/
USE employees;
DROP PROCEDURE IF EXISTS select_avg_sal_all_employees;

DELIMITER $$
CREATE PROCEDURE select_avg_sal_all_employees()
BEGIN
	SELECT AVG(salary)
    FROM salaries;
END $$
DELIMITER ;


/* -----------------------------------------------------*/
/*         Store Procedure with INPUT parameter         */
/* Select employee salary by specific employee number   */
/* -----------------------------------------------------*/
USE employees;
DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date, s.to_date
    FROM employees e
    JOIN salaries s ON s.emp_no = e.emp_no
    WHERE e.emp_no = p_emp_no;
END $$
DELIMITER ;

/* -----------------------------------------------------*/
/*         Store Procedure with INPUT parameter         */
/*         Average Salary of employee by emp_no         */
/* -----------------------------------------------------*/
USE employees;
DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
	SELECT e.emp_no, e.first_name, e.last_name, AVG(s.salary)
    FROM employees e
    JOIN salaries s ON s.emp_no = e.emp_no
    WHERE e.emp_no = p_emp_no
    GROUP BY e.emp_no;
END $$
DELIMITER ;

/* -----------------------------------------------------*/
/*   Store Procedure with INPUT and OUTPUT parameter    */
/*         Average Salary of employee by emp_no         */
/* -----------------------------------------------------*/
USE employees;
DROP PROCEDURE IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(IN p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
BEGIN
	SELECT AVG(s.salary)
		INTO p_avg_salary
    FROM employees e
    JOIN salaries s ON s.emp_no = e.emp_no
    WHERE e.emp_no = p_emp_no
    GROUP BY e.emp_no;
END $$
DELIMITER ;

/* ----------------------------------------------------------------------------------*/
/*  Create a procedure called ‘emp_info’ that uses as parameters                     */
/* the first and the last name of an individual, and returns their employee number.  */
/* ----------------------------------------------------------------------------------*/
USE employees;
DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255), p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN
	SELECT e.emp_no
		INTO p_emp_no
    FROM employees e
    WHERE e.first_name = p_first_name AND e.last_name = p_last_name
    LIMIT 1;
END $$
DELIMITER ;

/******************************************************/
/* Testing */
CALL employees.select_employees();

DROP PROCEDURE employees.select_salaries;

CALL employees.select_avg_sal_all_employees();

CALL employees.emp_salary(10001);

CALL employees.emp_avg_salary(10001);

/* -------------------------------------------------------------*/
/*   Calling Store Procedure with INPUT and OUTPUT parameter    */
/*                And setting into variables                    */
/* -------------------------------------------------------------*/
set @v_avg_salary = 0;
call employees.emp_avg_salary_out(10001, @v_avg_salary);
select @v_avg_salary;


/* get emp no by given first name and last name */
SET @v_emp_no = 0;
CALL employees.emp_info('Georgi','Facello',@v_emp_no);
SELECT @v_emp_no;


/* -------------------------------------------------------------*/
/*                   User Defined Functions                     */
/* -------------------------------------------------------------*/

/*
DELIMITER $$
CREATE FUNCTION function_name(parameter data_type) RETURNS data_type
BEGIN
	DECLARE variable_name data_type;
		SELECT ......
	RETURN variable_name;
END $$
DELIMITER ;
*/

/* -------------------------------------------------------------*/
/*    Average salary of an employee by emp_no                   */
/* -------------------------------------------------------------*/
DROP FUNCTION IF EXISTS f_emp_avg_sal;

DELIMITER $$
CREATE FUNCTION f_emp_avg_sal(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_avg_salary DECIMAL(10,2);
		SELECT AVG(s.salary)
			INTO v_avg_salary
		FROM employees e
		JOIN salaries s ON s.emp_no = e.emp_no
		WHERE e.emp_no = p_emp_no
		GROUP BY e.emp_no;
	RETURN v_avg_salary;
END $$
DELIMITER ;

/* -------------------------------------------------------------*/
/*    Call the function Average salary of an employee by emp_no */
/* -------------------------------------------------------------*/
SELECT f_emp_avg_sal(10001);


/* ----------------------------------------------------------------------------------------------------------*/
/*    Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee,  */
/*and returns the salary from the newest contract of that employee.                                          */
/*Hint: In the BEGIN-END block of this program, you need to declare and use two variables –                  */   
/*v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.      */
/*Finally, select this function.                                                                             */
/* ----------------------------------------------------------------------------------------------------------*/
DROP FUNCTION IF EXISTS f_emp_info;

DELIMITER $$
CREATE FUNCTION f_emp_info(p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_newest_salary DECIMAL(10,2);
		SELECT s.salary
			INTO v_newest_salary
		FROM employees e
		JOIN salaries s ON s.emp_no = e.emp_no
		WHERE e.first_name = p_first_name AND e.last_name = p_last_name
        ORDER BY from_date DESC
        LIMIT 1;
	RETURN v_newest_salary;
END $$
DELIMITER ;

/* select values from the function*/
SELECT f_emp_info('Bezalel', 'Simmel');
