SELECT city,cust_num
FROM 
(
SELECT city,COUNT(DISTINCT customer_id) cust_num
FROM sale.customer
WHERE [state] ='CA'
GROUP BY city
) A
WHERE cust_num <= 40


/* YANLIÞ OLAN
SELECT tbl.city,A.first_name,A.last_name
FROM
(
SELECT city,customer_id,COUNT(DISTINCT customer_id) cust_num
FROM sale.customer
WHERE [state] ='CA'
GROUP BY city,customer_id
HAVING COUNT(DISTINCT customer_id) <= 40
) tbl, sale.customer A
WHERE A.customer_id=tbl.customer_id
ORDER BY tbl.city,A.first_name,A.last_name*/

SELECT city,cust_num
FROM 
(
SELECT city,COUNT(DISTINCT customer_id) cust_num
FROM sale.customer
WHERE [state] ='CA'
GROUP BY city
) A
WHERE cust_num <= 40


/*SELECT first_name,last_name,city
FROM sale.customer
WHERE city IN
(
SELECT city, COUNT(DISTINCT customer_id) cust_num
FROM sale.customer
WHERE [state] ='CA'
GROUP BY city
HAVING COUNT(DISTINCT customer_id)<40
)*/

SELECT C.city,C.first_name,C.last_name
FROM sale.customer C
JOIN
(
SELECT city,COUNT(DISTINCT customer_id) cust_num
FROM sale.customer
WHERE [state] ='CA'
GROUP BY city
HAVING COUNT(DISTINCT customer_id) <= 40
) A
ON C.city = A.city


SELECT DISTINCT first_name,last_name,city,COUNT(customer_id) OVER(PARTITION BY city) cnt_customer
FROM sale.customer
WHERE [state] = 'CA'


SELECT customer_id,row_id
FROM
(
SELECT *, ROW_NUMBER() OVER(ORDER BY cst_quan DESC) row_id
FROM
(
SELECT DISTINCT A.customer_id, SUM(B.quantity) OVER(PARTITION BY A.customer_id) cst_quan
FROM sale.orders A,sale.order_item B
WHERE A.order_id = B.order_id
) A
) B
WHERE row_id = 40 or row_id = 50


SELECT *, ROW_NUMBER() OVER(ORDER BY cst_quan DESC) row_id
FROM
(
SELECT DISTINCT A.customer_id, SUM(B.quantity) OVER(PARTITION BY A.customer_id) cst_quan
FROM sale.orders A,sale.order_item B
WHERE A.order_id = B.order_id
) A

SELECT	A.order_id,
		A.customer_id,
		B.first_name,
		B.last_name,
		A.order_date,
		LEAD(A.order_date) OVER (PARTITION BY A.customer_id ORDER BY A.order_date) next_ord,
		DATEDIFF(DAY,A.order_date,LEAD(A.order_date) OVER (PARTITION BY A.customer_id ORDER BY A.order_date))
		FROM sale.orders A,sale.customer B
WHERE A.customer_id = B.customer_id



