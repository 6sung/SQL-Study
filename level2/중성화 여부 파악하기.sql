-- 코드를 입력하세요
SELECT ANIMAL_ID, NAME, 
CASE WHEN REGEXP_LIKE(SEX_UPON_INTAKE,'Neutered MALE')
     THEN 'O'
     WHEN REGEXP_LIKE(SEX_UPON_INTAKE,'Spayed Female')
     THEN 'O'
     ELSE 'X' END AS 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;
