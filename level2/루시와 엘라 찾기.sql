-- 코드를 입력하세요
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy') OR 
      NAME IN('Ella') OR 
      NAME IN ('Pickle') OR
      NAME IN ('Rogan') OR
      NAME IN ('Sabrina') OR
      NAME IN ('Mitty')
ORDER BY ANIMAL_ID;
