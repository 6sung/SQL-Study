SELECT * from test_regexp;

SELECT * 
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[0-9][a-z]');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[0-9]{6}');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[0-9]{3}-[0-9]{4}$');

SELECT *
FROM test_regexp
WHERE REGEXP_LIKE(col1, '[[:digit:]]{3}-[[:digit:]]{4}$');


CREATE TABLE QA_MASTER (QA_NO VARCHAR2(10));
ALTER TABLE QA_MASTER ADD CONSTRAINT QA_NO_CHK CHECK
(REGEXP_LIKE(QA_NO, '^([[:alpha:]]{2}-[[:digit:]]{2}-[[:digit:]]{4})$'));

INSERT INTO QA_MASTER VALUES('QA-01-0001');

INSERT INTO test_regexp VALUES('@!=)(9&%$#');
INSERT INTO test_regexp VALUES('자바3');

SELECT col1,
REGEXP_INSTR(col1, '[0-9]') AS data1,
REGEXP_INSTR(col1, '%') AS daga2
FROM test_regexp;

SELECT col1, REGEXP_SUBSTR(col1, '[C-Z]+')
FROM test_regexp;

SELECT col1, REGEXP_REPLACE(col1, '[0-2]+','*')
FROM test_regexp;

SELECT first_name, phone_number
FROM employees  
WHERE REGEXP_LIKE(phone_number,
'^[0-9].[0-9]{3}.[0-9]{3}.[0-9]{4}$');

SELECT first_name,
REGEXP_REPLACE(phone_number, '[[:digit:]]{4}$', '****') AS phone,
REGEXP_SUBSTR(phone_number, '[[:digit:]]{4}$') AS phone2
FROM employees
WHERE REGEXP_LIKE (phone_number, '^[0-9].[0-9]{3}.[0-9]{3}.[0-9]{4}$');

desc dual;
SELECT * FROM dual;

SELECT ROUND(45.923,2), ROUND(45.923,0), ROUND(45.923,-1)
FROM DUAL;

SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM DUAL;

SELECT SYSDATE
FROM DUAL;

SELECT SYSTIMESTAMP
FROM DUAL;

SELECT first_name,(SYSDATE - hire_date)/7 AS "Weeks"
FROM employees
WHERE department_id=60;

SELECT first_name, SYSDATE, hire_date,
MONTHS_BETWEEN(SYSDATE,hire_date) AS workmonth
FROM employees
WHERE first_name='Diana';

SELECT first_name, hire_date, ADD_MONTHS(hire_date, 100)
FROM employees
WHERE first_name='Diana';

SELECT SYSDATE, NEXT_DAY(SYSDATE, '월')
FROM dual;

SELECT SYSDATE, LAST_DAY(SYSDATE)
FROM dual;

SELECT SYSDATE, ROUND(SYSDATE), TRUNC(SYSDATE)
FROM dual;

SELECT TRUNC(SYSDATE, 'Month')
FROM dual;

SELECT TRUNC(SYSDATE, 'Year')
FROm dual;

SELECT ROUND(TO_DATE('17/03/16'), 'Month')
FROM dual;

SELECT TRUNC(TO_DATE('17/03/16'), 'Month')
FROM dual;

SELECT first_name, TO_CHAR(hire_date, 'MM/YY') AS MONTH_Hired
FROM employees
WHERE first_name='Steven';

SELECT first_name,
TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"') HIREDATE
FROM employees;

SELECT first_name,
TO_CHAR(hire_date,'fmDdspth "of"Month YYYY fmHH:MI:SS AM','NLS_DATE_LANGUAGE=english')
AS HIREDATE
FROM employees;

SELECT first_name, last_name, TO_CHAR(salary, '$999,999') SALARY
FROM employees
WHERE first_name='David';

SELECT TO_CHAR(2000000, '$999,999') SALARY
FROM dual;

SELECT first_name, last_name,
salary*0.123456 SALARY1,
TO_CHAR(salary*0.123456, '$999,999.99') SALARY2
FROM employees
WHERE first_name='David';

SELECT '$5,500.00' - 4000 FROM dual;

SELECT to_number('$5,500.00', '$99,999.99') - 4000
FROM dual;

SELECT first_name, hire_date
FROM employees
WHERE hire_date=TO_DATE('2013/06/17', 'YYYY/MM/DD');

SELECT first_name,
salary + salary*NVL(commission_pct,0) AS ann_sal
FROM employees;

SELECT first_name,
NVL2(commission_pct, salary+(salary*commission_pct), salary) ann_sal
FROM employees;

SELECT first_name,
COALESCE(salary + (salary*commission_pct), salary) AS ann_sal
FROM employees;

SELECT first_name, COALESCE(salary*commission_pct, 0) AS bonus
FROM employees
WHERE LNNVL(salary*commission_pct >= 650);

SELECT first_name, salary + salary * NVL(commission_pct , 0) AS salary
FROM employees;

SELECT job_id, salary,
DECODE(job_id, 'IT_PROG', salary*1.10,
'FI_MGR', salary*1.15,
'FI_ACCOUNT', salary*1.20,
salary)
AS revised_salary
FROM employees;

SELECT job_id, salary,
CASE job_id WHEN 'IT_PROG' THEN salary*1.10
WHEN 'FI_MGR' THEN salary*1.15
WHEN 'FI_ACCOUNT' THEN salary*1.20
ELSE salary
END AS REVISED_SALARY
FROM employees;

SELECT job_id, salary,
CASE WHEN job_id = 'IT_PROG' THEN salary*1.10
WHEN job_id = 'FI_MGR' THEN salary*1.15
WHEN job_id = 'FI_ACCOUNT' THEN salary*1.20
ELSE salary
END AS revised_salary
FROM employees;


SELECT employee_id, first_name, department_id || ''
from employees
where department_id=10
 UNION
select employee_id, first_name, job_id
from employees
where job_id='IT_PROG';

SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
 UNION
SELECT employee_id, first_name
FROM employees
WHERE department_id=20;

SELECT employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
 UNION ALL
SELECT employee_id, first_name
FROM employees
WHERE department_id=20;

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE job_id LIKE 'SA%';

SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

SELECT MIN(first_name), MAX(last_name)
FROM employees;

SELECT MAX(salary)
FROM employees;

SELECT COUNT(*) FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

SELECT SUM(salary) AS 합계,
ROUND(AVG(salary), 2) AS 평균,
ROUND(STDDEV(salary), 2) AS 표준편차,
ROUND(VARIANCE(salary), 2) AS 분산
FROM employees;

SELECT ROUND(AVG(salary*commission_pct), 2) AS avg_bouns
FROM employees;

SELECT ROUND(SUM(salary*commission_pct), 2) AS sum_bonus,
COUNT(*) count,
ROUND(AVG(salary*commission_pct), 2) AS avg_bonus1,
ROUND(SUM(salary*Commission_pct)/count(*), 2) AS avg_bonus2
FROM employees;

SELECT AVG(NVL(salary*commission_pct,0))
FROM employees;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;


--error
SELECT department_id, COUNT(first_name)
FROM employees;
--error
SELECT department_id, AVG(salary)
FROM employees
WHERE AVG(salary) > 2000
GROUP BY department_id;

SELECT department_id, ROUND(AVG(salary), 2)
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 8000;

SELECT job_id, AVG(salary) PAYROLL
FROM employees
WHERE job_id NOT LIKE 'SA%'
GROUP BY job_id
HAVING AVG(salary) > 8000
ORDER BY AVG(salary);

SELECT TO_CHAR(department_id), ROUND(AVG(salary),2)
FROM employees
GROUP BY department_id
 UNION ALL
SELECT job_id, ROUND(AVG(salary),2)
FROM employees
GROUP BY job_id
ORDER BY 1;

SELECT department_id, job_id, ROUND(AVG(salary) , 2)
FROM employees
GROUP BY GROUPING SETS( department_id, job_id)
ORDER BY department_id, job_id;

SELECT department_id, job_id, manager_id,
ROUND (AVG(salary), 2) AS avg_sal
FROM employees
GROUP BY
GROUPING SETS((department_id, job_id),(job_id, manager_id))
ORDER BY department_id, job_id, manager_id;

SELECT department_id, job_id, ROUND(AVG(salary),2), COUNT(*)
FROM employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id, job_id;

SELECT department_id, job_id, ROUND(AVG(salary),2), COUNT(*)
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;

SELECT DECODE(GROUPING(department_id), 1, '소계', TO_CHAR(department_id)) AS 부서,
DECODE(GROUPING(job_id), 1, '소계', job_id) AS 직무,
ROUND(AVG(salary),2) AS 평균,
COUNT(*) AS 사원의수
FROM employees GROUP BY CUBE(department_id, job_id) ORDER BY 부서, 직무;

SELECT 
DECODE(GROUPING_ID(department_id, job_id), 2, '소계', 3,'합계',
TO_CHAR(department_id)) AS 부서번호,
DECODE(GROUPING_ID(department_id, job_id), 1, '소계', 3,'합계', job_id) AS 직무,
GROUPING_ID(department_id, job_id) AS GID,
ROUND(AVG(salary),2) AS 평균,
COUNT(*) AS 사원의수
FROM employees
GROUP BY CUBE(department_id, job_id)
ORDER BY 부서번호, 직무;
