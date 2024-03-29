SELECT *
FROM employees
WHERE LOWER(email) LIKE ('%lee%');

SELECT first_name, salary, job_id
FROM employees
WHERE manager_id = 103;

SELECT *
FROM employees
WHERE (department_id = 80 AND job_id LIKE('%SA_MAN')) OR
(department_id = 20 AND manager_id = 100);

SELECT REPLACE(phone_number,'.','-') AS 전화번호
FROM  employees;

SELECT
RPAD(first_name || ' ' || last_name,20,'*') AS full_name,
TO_CHAR(COALESCE(salary+salary*commission_pct, salary),'$099,999.00') AS salary,
TO_CHAR(hire_date, 'yyyy-mm-dd') AS hire_date,
ROUND(SYSDATE - hire_date) AS work_day
FROM employees
WHERE lower(job_id) = 'it_prog' AND salary > 5000
ORDER BY full_name;

SELECT
RPAD(first_name || ' ' || last_name,20,'*') AS full_name,
TO_CHAR(COALESCE(salary+salary*commission_pct, salary), '$099,999.00') AS salary,
TO_CHAR(hire_date, 'yyyy"년" mm"월" dd"일"') AS hire_date,
TRUNC(months_between(sysdate,hire_date)) AS month
FROM employees
WHERE department_id=30
ORDER BY salary DESC;

SELECT
RPAD(first_name || ' ' || last_name,20,'*') AS 이름,
TO_CHAR(COALESCE(salary+salary*commission_pct,salary),'$09,999.00') AS 급여
FROM employees
WHERE department_id=80 AND salary>10000
ORDER BY 급여 DESC;

SELECT first_name AS 이름,
DECODE(TRUNC(TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)/5),
    1, '5년차',
    2, '10년차',
    3, '15년차',
    '기타') AS 근무년수
 FROM employees
 WHERE department_id = 60;

SELECT hire_date+1000
FROM employees
WHERE first_name = 'Lex';

SELECT first_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date , 'MM') = '05';

SELECT first_name, salary,
    TO_CHAR(hire_date, 'YYYY"년 입사"') AS year,
    TO_CHAR(hire_date, 'day') AS day,
    CASE WHEN TO_NUMBER(TO_CHAR(hire_date,'YY'))>=10
            THEN TO_CHAR(salary*1.1, '$999,999')
         WHEN TO_NUMBER(TO_CHAR(hire_date,'YY'))>=5
            THEN TO_CHAR(salary*1.05, '$999,999')
         ELSE TO_CHAR(salary, '$999,999')
    END AS INCREASING_SALARY
FROM employees;

SELECT first_name, salary,
    TO_CHAR(hire_date, 'YYYY"년 입사"') AS YEAR,
    DECODE(TO_CHAR(hire_date, 'RR') , '10',salary*1.10,
                                      '05',salary*1.05, salary) AS INCREASING_SALARY2
FROM employees;

SELECT country_id, NVL(state_province, country_id) AS state
FROM locations;
