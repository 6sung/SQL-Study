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




CREATE TABLE dept(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
CREATE TABLE emp(
    empno NUMBER(4,0),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4,0),
    hiredate DATE,
    sal NUMBER(7,2),
    comm NUMBER(7,2),
    DEPTNO NUMBER(2,0)
);

CREATE TABLE emp2 AS SELECT * FROM employees;

SELECT COUNT(*) FROM emp2;

DESC dept;
DESC emp;

CREATE TABLE emp_dept50
AS
    SELECT employee_id, first_name, salary*12 AS ann_sal, hire_date
    FROM employees
    WHERE department_id=50;

ALTER TABLE emp_dept50
    ADD(job VARCHAR(10));

SELECT * FROM emp_dept50;

ALTER TABLE emp_dept50
    MODIFY(first_name VARCHAR2(30));

ALTER TABLE emp_dept50
    MODIFY(first_name VARCHAR2(10));

ALTER TABLE emp_dept50
ADD(job_id VARCHAR2(10));

ALTER TABLE emp_dept50
DROP COLUMN job_id;

DESC emp_dept50;

ALTER TABLE emp_dept50
RENAME COLUMN job TO job_id;

DESC emp_dept50;

ALTER TABLE emp_dept50 SET UNUSED(first_name);
DESC emp_dept50;
ALTER TABLE emp_dept50 DROP UNUSED COLUMNS;

DROP TABLE employees_dept50;
DESC employees_dept50;

TRUNCATE TABLE emp2;
SELECT * FROM emp2;


SELECT * FROM emp;
--1번
DROP TABLE emp;
DESC emp;
--2번
CREATE TABLE emp AS SELECT * FROM employees;
SELECT * FROM emp;
--3번
SELECT * FROM emp WHERE department_id=60;
--4번
DELETE FROM emp WHERE department_id=60;
--5번
SAVEPOINT A;
--6번
UPDATE emp SET salary=salary*1.1 WHERE job_id='SA_MAN';
--7번
ROLLBACK TO SAVEPOINT A;
--8번
ROLLBACK;
--9번
SELECT COUNT(*) FROM emp;
--10번
UPDATE emp SET salary=salary*1.2 WHERE job_id='IT_PROG';
--11번
SELECT first_name, job_id, hire_date, salary
FROM emp
WHERE salary>=15000;
--12번
COMMIT;

--1번
CREATE TABLE customer(
    cust_id VARCHAR2(20),
    cust_name VARCHAR(20),
    age NUMBER(3),
    email VARCHAR2(20));
--2번
INSERT INTO customer
VALUES (user,'홍길동',20,'hong@hong.com');
--3번
ALTER TABLE customer ADD address VARCHAR2(100);
--4번
ALTER TABLE customer MODIFY email VARCHAR2(50);

CREATE TABLE emp4(
    empno NUMBER(4) CONSTRAINT emp4_empno_pk PRIMARY KEY,
    ename VARCHAR2(10) NOT NULL,
    sal number(7,2) CONSTRAINT emp4_sal_ck CHECK(sal<=10000),
    deptno number(2) CONSTRAINT emp4_deptno_dept_deptid_fk REFERENCES departments(department_id)
);

CREATE TABLE emp5(
    empno number(4),
    ename varchar2(10) NOT NULL,
    sal number(7,2),
    deptno number(2),
    CONSTRAINT emp5_empno_pk PRIMARY KEY(empno),
    CONSTRAINT emp5_sal_ck CHECK(sal<=10000),
    CONSTRAINT emp5_deptno_dept_deptid_fk
        FOREIGN KEY (deptno) REFERENCES departments(department_id)
);
ALTER TABLE emp4 ADD(nickname  varchar2(20));
ALTER TABLE emp4 ADD CONSTRAINT emp4_nickname_uk UNIQUE(nickname);
ALTER TABLE emp4 DISABLE CONSTRAINT emp4_sal_ck;
INSERT INTO emp4 VALUES(9999, 'KING', 20000,10,'king');

ALTER TABLE emp4 ENABLE VALIDATE CONSTRAINT emp4_sal_ck;
ALTER TABLE emp4 ENABLE NOVALIDATE CONSTRAINT emp4_sal_ck;

-- 게시글을 저장할 수 있는 테이블을 작성하세요
-- 작성자, 제목, 날짜/시간, 내용, 조회수, 비밀번호, 메인글번호, 글번호
-- 글번호, 작성자, 제목, 내용, 비밀번호, 날씨/시간, 조회수, 메인글번호
-- 숫자,   문자,   문자, 문자, 문자,    날짜/시간,  숫자,   숫자
--number, 50     1000  5000  30     timestamp   number6  number
--제약조건 PK 글번호, FK 메인글번호->글번호
--NN 글번호 작성자 제목 비밀번호 날짜시간
CREATE TABLE board(
    bid number PRIMARY KEY,
    writer VARCHAR2(50) NOT NULL,
    title VARCHAR2(1000) NOT NULL,
    contents VARCHAR2(4000),
    password VARCHAR2(30),
    writedate TIMESTAMP,
    readcount number(6) default 0,
    master_bid number,
    CONSTRAINTS bid_master_bid_fk FOREIGN KEY (master_bid)REFERENCES board(bid)
);
DESC board;                        

--게시글 입력 화면은 작성자, 제목, 내용, 비밀번호를 입력하는 양식이 있습니다.
--게시글을 데이터베이스에 저장하는 insert 구문을 작성하세요
INSERT INTO board
    (bid, writer, title, contents, password, writedate, readcount, master_bid)
VALUES
    ((SELECT NVL(MAX(bid),0)+1 FROM board) ,'홍길동','글제목','글내용','12234',systimestamp,0,null);
    
INSERT INTO board
    (bid, writer, title, contents, password, writedate, readcount, master_bid)
VALUES
    ((SELECT NVL(MAX(bid),0)+1 FROM board) ,'홍길동1','글제목1','글내용1','12234',systimestamp,0,null);    
SELECT * FROM board;

--게시글을 조회하는 SQL 구문 작성.
--목록에서 선택한 글을 조회
SELECT bid, writer, title, contents, writedate, readcount
FROM board
WHERE bid=2;
UPDATE board set readcount = readcount+1 WHERE bid=1;
--게시글 삭제하는 SQL 구문
DELETE FROM board WHERE bid=1 AND password=12234;
--게시글의 제목과 내용을 수정하는 구문
UPDATE board SET title = '글제목3', contents = '내용'
WHERE bid=2 AND password=12234;
commit;

CREATE TABLE bd(
    bdid number PRIMARY KEY,
    bwriter VARCHAR2(50) NOT NULL,
    btitle VARCHAR2(1000) NOT NULL,
    bcontents VARCHAR2(4000),
    bpassword VARCHAR2(30),
    bwritedate TIMESTAMP,
    breadcount number(6) default(0),
    master_bdid number,
    CONSTRAINT bdid_master_bdid_fk FOREIGN KEY (master_bdid) REFERENCES bd(bdid)
);
DESC bd;

INSERT INTO bd
    (bdid, bwriter, btitle, bcontents, bpassword, bwritedate, breadcount, master_bdid)
VALUES(
    (SELECT NVL(MAX(bdid),0)+1 FROM bd), '작성자','제목1','내용내용', 12345, systimestamp, 0,null
);
INSERT INTO bd
    (bdid, bwriter, btitle, bcontents, bpassword, bwritedate, breadcount, master_bdid)
VALUES(
    (SELECT NVL(MAX(bdid),0)+1 FROM bd), '글쓴이','가나다','abcabc', 23456, systimestamp, 0,null
);
SELECT * FROM bd;
SELECT bdid, bwriter, btitle, bcontents, bwritedate, breadcount
FROM bd
WHERE bdid=1;
UPDATE bd SET breadcount = breadcount+1  WHERE bdid=1;
commit;

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
SELECT COUNT(*)
FROM employees
WHERE manager_id IS NOT NULL GROUP BY department_id;

--36번
SELECT first_name, hire_date
FROM employees
WHERE job_id LIKE ('%SH_CLERK%') AND salary<3000;
--38번
SELECT DISTINCT department_id
FROM employees
WHERE job_id LIKE ('%SA%') AND department_id IS NOT NULL;
--39번
SELECT email
FROM employees
WHERE first_name LIKE('%Steven%') AND last_name LIKE ('%King%');

--48번
SELECT first_name
FROM employees
WHERE employee_id = (SELECT manager_id FROM employees WHERE employee_id =104); 
--49번
SELECT first_name
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
