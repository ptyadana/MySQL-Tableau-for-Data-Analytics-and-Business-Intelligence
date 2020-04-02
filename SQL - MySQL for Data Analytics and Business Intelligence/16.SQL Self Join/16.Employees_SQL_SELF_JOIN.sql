/*From emp_manager table, extract the record only for those employees who are manager as well*/
SELECT em1.*
FROM emp_manager em1
JOIN emp_manager em2
WHERE em1.emp_no = em2.manager_no
GROUP BY em1.emp_no;