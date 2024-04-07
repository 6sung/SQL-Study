-- 코드를 입력하세요
SELECT CATEGORY,PRICE AS MAX_PRICE, PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE (CATEGORY,PRICE) IN (SELECT CATEGORY,MAX(PRICE) 
                FROM FOOD_PRODUCT 
                WHERE CATEGORY = '국' OR 
                      CATEGORY = '김치' OR
                      CATEGORY = '과자' OR
                      CATEGORY = '식용유'      
                GROUP BY CATEGORY)
ORDER BY PRICE DESC;

