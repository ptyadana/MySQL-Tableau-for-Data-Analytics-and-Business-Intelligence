
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


