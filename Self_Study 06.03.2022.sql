 SELECT
	A.product_id,
	A.product_name,
	B.category_id,
	B.category_name
FROM product.product A
INNER JOIN product.category B
ON A.category_id = B.category_id;

SELECT A.first_name,A.last_name,B.store_name
FROM sale.staff A
INNER JOIN sale.store B
ON A.store_id = B.store_id

SELECT
	A.[state],
	YEAR(B.order_date) YEAR,
	MONTH(B.order_date) MONTH,
	COUNT (DISTINCT order_id) NUM_COUNT
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id
GROUP BY 	A.[state],
	YEAR(B.order_date),
	MONTH(B.order_date)

SELECT A.product_id, A.product_name, B.order_id
FROM product.product A
LEFT JOIN sale.order_item B
ON A.product_id = B.product_id
WHERE order_id IS NULL

SELECT A.product_id, A.product_name, B.store_id, B.product_id, B.quantity
FROM product.product A
LEFT JOIN product.stock B
ON A.product_id = B.product_id
WHERE A.product_id > 310

SELECT A.product_id, A.product_name, B.store_id, B.product_id, B.quantity
FROM product.stock B
RIGHT JOIN product.product A
ON A.product_id = B.product_id
WHERE B.product_id > 310

SELECT
	A.staff_id,
	A.first_name,
	A.last_name,
	B.*
FROM sale.staff A
LEFT JOIN sale.orders B
ON A.staff_id = B.staff_id


SELECT TOP 20 A.product_id, B.store_id, B.quantity, C.order_id, C.list_price
FROM product.product A
FULL OUTER JOIN product.stock B
	ON A.product_id = B.product_id
FULL OUTER JOIN sale.order_item C
	ON A.product_id = C.product_id

SELECT TOP 20 A.product_id, B.store_id, B.quantity, C.order_id, C.list_price
FROM product.product A
FULL OUTER JOIN product.stock B
	ON A.product_id = B.product_id
FULL OUTER JOIN sale.order_item C
	ON A.product_id = C.product_id
ORDER BY B.store_id

SELECT *
FROM sale.staff

SELECT A.first_name, A.last_name, B.first_name [Man_Name]
FROM sale.staff A
JOIN sale.staff B
ON A.manager_id = B.staff_id


SELECT A.first_name STAFF_NAME, B.first_name MNG_1, C.first_name MNG_2
FROM sale.staff A
JOIN sale.staff B
	ON A.manager_id = B.staff_id
JOIN sale.staff C
	ON B.manager_id = C.staff_id
ORDER BY C.first_name, B.first_name


CREATE VIEW CUSTOMER_PRODUCT AS
SELECT	DISTINCT D.customer_id, D.first_name, D.last_name
FROM	product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE	A.product_id=B.product_id
AND		B.order_id = C.order_id
AND		C.customer_id = D.customer_id
AND		A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'

SELECT * FROM CUSTOMER_PRODUCT



