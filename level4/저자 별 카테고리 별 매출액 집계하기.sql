SELECT A.AUTHOR_ID, A.AUTHOR_NAME, K.CATEGORY, SUM(K.PRICE*K.CT) AS TOTAL_SALES
FROM AUTHOR A,(
SELECT B.BOOK_ID, B.CATEGORY, B.AUTHOR_ID, B.PRICE, SUM(S.SALES) AS CT
FROM BOOK B, BOOK_SALES S
WHERE B.BOOK_ID=S.BOOK_ID AND TO_CHAR(S.SALES_DATE,'YYYYMM') = '202201'
GROUP BY B.BOOK_ID, B.CATEGORY, B.AUTHOR_ID, B.PRICE
) K
WHERE A.AUTHOR_ID=K.AUTHOR_ID
GROUP BY A.AUTHOR_ID, A.AUTHOR_NAME,K.CATEGORY
ORDER BY A.AUTHOR_ID ASC, K.CATEGORY DESC;
