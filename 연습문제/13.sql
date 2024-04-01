--13장 연습문제
CREATE SEQUENCE bbs_seq
    START WITH 1
    INCREMENT BY 1
    CACHE 20
    NOCYCLE;

CREATE INDEX idx_emp_realsal
ON emp(COALESCE(salary+salary*commission_pct,salary));
