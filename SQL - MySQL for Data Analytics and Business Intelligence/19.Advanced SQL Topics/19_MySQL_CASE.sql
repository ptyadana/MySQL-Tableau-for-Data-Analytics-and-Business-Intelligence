
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