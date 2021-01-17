SELECT * FROM --PIVOT DENEMESI AMA YENISI VAR ASAGIDA
(
SELECT ACCOUNT_NO, PRODUCT_NAME, SUM(BILLED_TAX) + SUM(BILLED_AMT) TOPLAM3, MONTH_DATE FROM DATA_ACCOUNT_PRODUCT
GROUP BY MONTH_DATE, ACCOUNT_NO, PRODUCT_NAME, MONTH_DATE
ORDER BY ACCOUNT_NO
)
PIVOT
(
MAX(PRODUCT_NAME) FOR (PRODUCT_NAME) IN ('product_1' , 'product_2', 'product_3', 'product_5', 'product_7', 'product_9', 'product_10')
)ORDER BY ACCOUNT_NO
FETCH FIRST 15 ROWS ONLY;

 SELECT *FROM DATA_ACCOUNT_PRODUCT;
 
 
 SELECT * FROM(
 SELECT ACCOUNT_NO,PRODUCT_NAME, YEAR_DATE, TOPLAM
 FROM DATA_ACCOUNT_PRODUCT)
 PIVOT
 ( 
    MIN(PRODUCT_NAME) FOR PRODUCT_NAME IN ('product_1', 'product_2', 'product_3', 'product_4')
 )
ORDER BY ACCOUNT_NO
FETCH FIRST 20 ROWS ONLY;



 
 
 --------------------------------------------
 CREATE TABLE UNPIVOT_TEST (
  ID              NUMBER,
  CUSTOMER_ID     NUMBER,
  PRODUCT_CODE_A  NUMBER,
  PRODUCT_CODE_B  NUMBER,
  PRODUCT_CODE_C  NUMBER,
  PRODUCT_CODE_D  NUMBER
);

INSERT INTO UNPIVOT_TEST VALUES (1, 101, 10, 20, 30, NULL);
INSERT INTO UNPIVOT_TEST VALUES (2, 102, 40, NULL, 50, NULL);
INSERT INTO UNPIVOT_TEST VALUES (3, 103, 60, 70, 80, 90);
INSERT INTO UNPIVOT_TEST VALUES (4, 104, 100, NULL, NULL, NULL);
COMMIT;

SELECT *FROM UNPIVOT_TEST;

SELECT *
FROM  UNPIVOT_TEST
UNPIVOT 
(
QUANTITY FOR PRODUCT_CODE IN (PRODUCT_CODE_A AS 'A', PRODUCT_CODE_B AS 'B', PRODUCT_CODE_C AS 'C', PRODUCT_CODE_D AS 'D')
);

SELECT *
FROM   UNPIVOT_TEST
UNPIVOT (QUANTITY FOR PRODUCT_CODE IN (PRODUCT_CODE_A AS 'A', PRODUCT_CODE_B AS 'B', PRODUCT_CODE_C AS 'C', PRODUCT_CODE_D AS 'D'));
---------------------------------------------------------
CREATE TABLE DATA_ACCOUNT_PRODUCT_COPY AS( --COLUMN SAYISI AZALTMAK ICIN
    SELECT ACCOUNT_NO, PRODUCT_NAME, YEAR_DATE , TOPLAM FROM DATA_ACCOUNT_PRODUCT
    );

 SELECT * FROM(--pivot denemessi
 SELECT ACCOUNT_NO, TOPLAM, PRODUCT_NAME, YEAR_DATE
 FROM DATA_ACCOUNT_PRODUCT)
 PIVOT
 ( 
    MIN(PRODUCT_NAME) FOR PRODUCT_NAME IN ('product_1', 'product_2', 'product_3', 'product_4')
 )
ORDER BY ACCOUNT_NO
FETCH FIRST 20 ROWS ONLY;







SELECT * FROM(--unpivot denemesi
 SELECT TO_CHAR(ACCOUNT_NO) ACCOUNT_N, TO_CHAR(TOPLAM) TOPLA, PRODUCT_NAME, TO_CHAR(YEAR_DATE) YEAR_DAT
 FROM DATA_ACCOUNT_PRODUCT)
 UNPIVOT 
 (COLUMN_NAME FOR PRODUCT_INFOR IN (ACCOUNT_N, TOPLA, PRODUCT_NAME, YEAR_DAT)
 );
 
 --NOT! BU CALIMIYOR, ASAGIDAKI OLANI CALISIYOR 
 -- IN () ICINDEKI OLANLAR HEPSI AYNI TYPE'DEN MI OLMALI
 SELECT * FROM(--unpivot denemesi
 SELECT ACCOUNT_NO , TOPLAM, PRODUCT_NAME, YEAR_DATE
 FROM DATA_ACCOUNT_PRODUCT)
 UNPIVOT 
 (COLUMN_NAM FOR PRODUCT_INFOR IN (ACCOUNT_NO, TOPLAM, PRODUCT_NAME, YEAR_DATE)
 );
 
 
 SELECT * FROM(--unpivot denemesi
 SELECT ACCOUNT_NO , TOPLAM, PRODUCT_NAME, YEAR_DATE
 FROM DATA_ACCOUNT_PRODUCT)
 UNPIVOT 
 (COLUMN_NAM FOR PRODUCT_INFOR IN (ACCOUNT_NO, TOPLAM, YEAR_DATE)
 );
 
 
 SELECT  ACCOUNT_NO, TOPLAM, YEAR_DATE, --TAMAM
 CASE 
 WHEN PRODUCT_NAME = 'PRODUCT_1' THEN  'PRODUCT_1'
 WHEN PRODUCT_NAME = 'PRODUCT_2' THEN  'PRODUCT_2'
 WHEN PRODUCT_NAME = 'PRODUCT_3' THEN  'PRODUCT_3'
 WHEN PRODUCT_NAME = 'PRODUCT_4' THEN  'PRODUCT_4'
 END AS PRODUCT_NAME_TEST
 FROM DATA_ACCOUNT_PRODUCT_COPY;