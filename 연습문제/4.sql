SELECT job_id, AVG(salary) AS AVERAGE
FROM employees
GROUP BY job_id;

SELECT department_id, count(*)
FROM employees
GROUP BY department_id;

SELECT department_id, job_id, count(*)
FROM employees
GROUP BY department_id,job_id;

SELECT department_id, ROUND(STDDEV(salary),2)
FROM employees
GROUP BY department_id;

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 4;

SELECT job_id, COUNT(*)
FROM employees
WHERE department_id = 50
GROUP BY job_id;

SELECT job_id, COUNT(*)
FROM employees
WHERE department_id=50
GROUP BY job_id
HAVING COUNT(*)<=10;

SELECT
    TO_CHAR(hire_date,'YYYY') AS 입사년도,
    ROUND(AVG(salary)) AS 급여평균,
    COUNT(*) AS COUNT
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
ORDER BY TO_CHAR(hire_date,'YYYY') ASC;

SELECT
    TO_CHAR(hire_date,'YYYY') AS 입사년도,
    TO_CHAR(hire_date,'MM') AS 입사월,
    ROUND(AVG(salary)) AS 급여평균,
    COUNT(*) AS COUNT
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY'), TO_CHAR(hire_date,'MM')
ORDER BY TO_CHAR(hire_date,'YYYY'), TO_CHAR(hire_date,'MM')ASC;

SELECT
    DECODE(GROUPING(TO_CHAR(hire_date, 'YYYY')),
            1,'소계', TO_CHAR(hire_date,'YYYY')) AS 입사년도,
    DECODE(GROUPING_ID(TO_CHAR(hire_date, 'YYYY'), TO_CHAR(hire_date,'MM')),
            1,'소계',
            3,'합계', TO_CHAR(hire_date, 'MM')) AS 입사월,
    ROUND(AVG(salary)) AS 급여평균,
    COUNT(*) AS 사원수
FROM employees
GROUP BY CUBE(TO_CHAR(hire_date, 'YYYY'), TO_CHAR(hire_date,'MM'))
ORDER BY 입사년도, 입사월;
