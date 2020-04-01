
/*************************************************/
/*        MySQL Index                            */
/*************************************************/

/*
PRIMARY KEY and FOREIGN KEY are indexes too.
*/
SHOW INDEXES FROM tbl_name FROM db_name;
SHOW INDEXES FROM employees FROM employees;

/*
CREATE INDEX index_name
ON table_name (column_1, column_2,...);
*/

#how many people have been hired after the 1st Jan of 2000?
SELECT *
FROM employees
WHERE hire_date > '2000-01-01';

#now create index on hire_date assuming that we use that field a lot in our queries
CREATE INDEX i_hire_date
ON employees (hire_date);

#run the query again and comapre the duration. AFter index, it should be a lot faster.

/* ------------------------*/

/* Composite Index - has multiple columns */
#Select all employees bearning the name "Georgi Facello"

SELECT * FROM employees
WHERE first_name = "Georgi" AND last_name = "Facello";

CREATE INDEX i_composite
ON employees(first_name,last_name);

/*************************************************************/

/*Drop the ‘i_hire_date’ index.*/
ALTER TABLE employees
DROP INDEX i_hire_date;

/*Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.*/
SELECT salary FROM salaries
WHERE salary > 89000;

CREATE INDEX i_salary
ON salaries(salary);

SELECT salary FROM salaries
WHERE salary > 89000;

