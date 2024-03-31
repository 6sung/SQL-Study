--1번
SELECT employee_id, first_name, hire_date
FROM employees
WHERE employee_id = 103;
--2번
SELECT COUNT(*)
FROM employees
WHERE department_id = 60;
--3번
SELECT COUNT(*)
FROM employees;
--4번
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL;
--5번
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;
--6번
SELECT first_name, department_id, job_id
FROM employees
WHERE department_id=60;
--7번
SELECT COUNT(*)
FROM employees
WHERE department_id=80;
--8번
SELECT ROUND(AVG(salary),2)
FROM employees;
--9번
SELECT salary+salary*NVL(commission_pct,0)
FROM employees
WHERE employee_id=103;
--10번
SELECT first_name, salary+salary*0.1
FROM EMPLOYEES
WHERE department_id = 60;
--11번
SELECT COUNT(*)
FROM employees
WHERE hire_date LIKE ('03/%');
--12번
SELECT COUNT(*)
FROM employees
WHERE job_id IN ('IT_PROG') OR job_id IN ('SA_MAN');
--13번
SELECT COUNT(*)
FROM employees
WHERE job_id LIKE ('%MGR') OR job_id LIKE('%MAN');
--14번
SELECT COUNT(*)
FROM employees
WHERE department_id = 80 AND(job_id IN ('SA_MAN') OR manager_id = 100);
--15번
SELECT hire_date+1000
FROM employees
WHERE first_name IN ('Lex');
--16번
SELECT COUNT(*)
FROM employees
WHERE hire_date LIKE ('%/06/%');
--17번
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;
--18번
SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 4;
--19번
SELECT job_id, COUNT(*)
FROM employees
WHERE department_id = 50
GROUP BY job_id;
--20번
SELECT MIN(salary)
FROM employees;
--21번
SELECT COUNT(DISTINCT MANAGER_ID)
FROM employees;
--22번
SELECT COUNT(*) FROM employees WHERE manager_id IS NULL;
--23번
SELECT COUNT(*)
FROM employees WHERE first_name LIKE ('%John%');
--24번
SELECT first_name, hire_date
FROM employees
WHERE department_id=30
ORDER BY hire_date DESC;
--25번
SELECT COUNT(*) FROM employees WHERE salary >= 10000;
--26번
SELECT SYSDATE FROM DUAL;
--27번
SELECT TO_CHAR(salary, '$09,999')
FROM employees
WHERE employee_id=103;
--28번
SELECT ROUND(AVG(salary*commission_pct),2)
FROM employees;
--29번
SELECT first_name, hire_date, job_id
FROM employees
WHERE hire_date LIKE ('%/05/%') AND job_id LIKE('%_MAN');
--30번
SELECT SUBSTR(first_name,0,3) FROM employees WHERE job_id = 'IT_PROG' ORDER BY SUBSTR(first_name,0,3) ASC;
--31번
SELECT COUNT(*)
FROM employees
WHERE salary>=5000 AND salary<=10000;
--32번
SELECT DISTINCT job_id
FROM employees
WHERE manager_id = 108;
--33번
SELECT first_name, job_id, salary
FROM employees
WHERE department_id = 10;
--34번
SELECT COUNT(DISTINCT department_id)
FROM employees
WHERE manager_id IS NOT NULL;
--35번
SELECT COUNT(DISTINCT department_id)
FROM employees
WHERE employee_id IS NOT NULL;
--36번
SELECT first_name, hire_date
FROM employees
WHERE job_id LIKE ('%SH_CLERK%') AND salary<3000;
--37번
SELECT COUNT(*)
FROM employees
WHERE REGEXP_LIKE (phone_number, '([0-9]{3})\.([0-9]{3})\.([0-9]{4})');
--38번
SELECT DISTINCT department_id
FROM employees
WHERE job_id LIKE ('%SA%') AND department_id IS NOT NULL;
--39번
SELECT email
FROM employees
WHERE first_name LIKE('%Steven%') AND last_name LIKE ('%King%');
--40번
SELECT COUNT(*)
FROM employees
WHERE hire_date BETWEEN '2005/01/01' AND '2006/12/31';
--41번
SELECT employee_id, first_name, hire_date
FROM employees
WHERE department_id IS NULL;
--42번
SELECT first_name, hire_date
FROM employees
WHERE hire_date = (SELECT MAX(hire_date) FROM employees);
--43번
SELECT first_name, hire_date
FROM employees
WHERE hire_date = (SELECT MIN(hire_date) FROM employees);
--44번
SELECT  COUNT(*)
FROM employees
WHERE manager_id = (SELECT employee_id from employees WHERE manager_id IS NULL);
--45번
SELECT COUNT(*)
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees WHERE job_id LIKE('%IT_PROG%'));
--46번
SELECT city
FROM locations a
INNER JOIN departments b
    ON a.location_id = b.location_id
WHERE b.department_name IN('IT');
--47번
SELECT e.first_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id IN (
    SELECT manager_id
    FROM employees
    WHERE department_id = d.department_id
) AND d.department_name = 'IT';
--48번
SELECT first_name
FROM employees
WHERE employee_id = (SELECT manager_id FROM employees WHERE employee_id =104); 
--49번
SELECT first_name
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
--50번
SELECT a.employee_id, a.first_name, a.department_id
FROM employees a
JOIN departments b
ON a.department_id = b.department_id
WHERE job_id LIKE ('IT%');
