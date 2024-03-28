SELECT employee_id, last_name, hire_date, salary
FROM employees;

SELECT first_name || last_name AS name
FROM employees;

SELECT *
FROM employees
WHERE department_id IN (50);

SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN(50);

SELECT last_name, salary, salary+300
FROM employees;

SELECT last_name, salary
FROM employees
WHERE salary >= 10000;

SELECT last_name, job_id, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

SELECT last_name, hire_date, salary
FROM employees
WHERE hire_date BETWEEN '13/01/01' AND '13/12/31';

SELECT last_name, hire_date, salary
FROM employees
WHERE hire_date LIKE '13/0%';

SELECT last_name, salary
FROM employees
ORDER BY salary DESC;

SELECT last_name, salary
FROM employees
WHERE department_id IN (60)
ORDER BY salary DESC;

SELECT last_name, job_id
FROM employees
WHERE job_id IN('IT_PROG') OR job_id IN ('SA_MAN');

SELECT '"' || first_name || last_name || ' '  || '사원의 급여는 ' || salary || '달러입니다."'
FROM employees
WHERE last_name IN('King') AND first_name IN('Steven');

SELECT last_name, job_id
FROM employees
WHERE job_id LIKE('%MAN%');

select last_name, job_id
FROM employees
WHERE job_id LIKE('%MAN%')
ORDER BY job_id;
