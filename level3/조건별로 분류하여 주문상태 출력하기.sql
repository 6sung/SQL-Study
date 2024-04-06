-- 코드를 입력하세요
SELECT  ORDER_ID, PRODUCT_ID, TO_CHAR(OUT_DATE,'YYYY-MM-DD') AS OUT_DATE, CASE
                                        WHEN TO_CHAR(OUT_DATE,'MMDD') > '0501' THEN '출고대기'
                                        WHEN OUT_DATE IS NULL THEN '출고미정'
                                        ELSE '출고완료' END AS 출고여부
FROM FOOD_ORDER
ORDER BY ORDER_ID ASC;
