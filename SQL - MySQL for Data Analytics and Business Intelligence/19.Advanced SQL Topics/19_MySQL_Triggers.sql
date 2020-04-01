
/*************************************************/
/*        MySQL Triggers                          */
/*************************************************/

/* to avoid data get messed up */
SET autocommit = 0;

COMMIT;

/*check salary < 0 or not when inserted , if < 0, insert as 0 instead of negative number*/
DELIMITER $$
CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SET NEW.salary = 0;
	END IF;
END $$
DELIMITER ;


SELECT * FROM salaries
WHERE emp_no = '10001';

#testing
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');

/*check salary < 0 or not when updated, if < 0,  keep the old salary instead of updating to negative number*/
DELIMITER $$
CREATE TRIGGER trig_update_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN
	IF NEW.salary < 0 THEN
		SET NEW.salary = OLD.salary;
	END IF;
END $$
DELIMITER ;

#testing
UPDATE salaries 
SET salary = 98765
WHERE emp_no = '10001' AND from_date = '2010-06-22';


/* Increase $20000 for employee when he/she got promoted to Manager */

DELIMITER $$
CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;
	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries SET to_date = SYSDATE()
		WHERE emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$
DELIMITER ;

#testing
SELECT * FROM dept_manager
WHERE emp_no = 111534;

INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%Y-%m-%d'), '9999-01-01');

SELECT *
FROM salaries
WHERE emp_no = 111534;


#testing for triggers finish
ROLLBACK;
SET autocommit = 1;

/******************************************************************/

/*Create a trigger that checks if the hire date of an employee is higher than the current date.
 If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).*/
 DELIMITER $$
 CREATE TRIGGER trig_ins_hire_date
 BEFORE INSERT ON employees
 FOR EACH ROW
 BEGIN
	IF NEW.hire_date > curdate() THEN
		SET NEW.hire_date = curdate();
	END IF;
 END $$
 DELIMITER ;
 
 #testing
 INSERT INTO employees(emp_no, birth_date,first_name,last_name,gender,hire_date)
 VALUES('999904','1980-01-01','Johnny','English','M','2030-01-30');
 
 SELECT * FROM employees
 ORDER BY emp_no DESC
 LIMIT 10;
 
 