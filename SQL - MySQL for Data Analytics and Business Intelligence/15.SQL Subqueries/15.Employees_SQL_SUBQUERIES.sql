/*Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995.*/
SELECT *
FROM dept_manager
WHERE emp_no IN (
	SELECT emp_no FROM employees
    WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01'
);

/*Select the entire information for all employees whose job title is “Assistant Engineer”. 
Hint: To solve this exercise, use the 'employees' table.*/
SELECT *
FROM employees e
WHERE EXISTS(
	SELECT emp_no FROM titles t
    WHERE title LIKE 'Assistant Engineer'
    AND e.emp_no = t.emp_no
);

/*Starting your code with “DROP TABLE”, create a table called “emp_manager” 
(emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null). */
DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager(
	emp_no INT NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT NOT NULL
);


/*Fill emp_manager with data about employees, the number of the department they are working in, and their managers.
Your output must contain 42 rows.*/
INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;

