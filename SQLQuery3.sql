SELECT first_name, last_name
FROM customer_table as A
WHERE NOT EXISTS (SELECT 1
FROM order_table as B
WHERE ord_date>='02.01.2022'
AND B.cust_id=A.id)

SELECT first_name,last_name
FROM dbo.customer_table
WHERE id IN
(
SELECT id
FROM dbo.customer_table
EXCEPT
SELECT O.cust_id
FROM dbo.order_table O,dbo.customer_table C
WHERE C.id = O.cust_id
)

SELECT *
FROM color

SELECT
FROM
WHERE EXISTS ('Yellow')

SELECT *
FROM dbo.customer_table

SELECT *
FROM dbo.order_table

SELECT id FROM customer_table C ,order_table OWHERE C.customer_table.id=order_table.cust_idEXCEPT SELECT ord_id FROM order_table, customer_table WHERE customer_table.id=order_table.cust_id 		AND ord_date>='02.01.2022'


SELECT * FROM color where CONCAT(C1, C2, C3) LIKE '%Yellow%'


SELECT *  FROM  color WHERE 'Yellow' IN (C1,C2,C3)


SELECT ABC
FROM color
WHERE
CASE WHEN C1='Yellow' THEN 1 
WHEN C2='Yellow' THEN 1 
WHEN C3='Yellow' THEN 1
ELSE 0 END ABC


