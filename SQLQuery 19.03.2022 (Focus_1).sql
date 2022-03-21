SELECT TOP 5 *
FROM sale.customer

SELECT TOP 5 *
FROM sale.orders

SELECT a.first_name, a.last_name
FROM sale.customer a
WHERE customer_id = 259

SELECT *
FROM sale.order_item

SELECT product_id
FROM sale.order_item
WHERE order_id = 9

SELECT A.product_id,B.product_name
FROM sale.order_item A, product.product B
WHERE a.product_id = b.product_id AND A.order_id = 10

SELECT *
FROM product.product

SELECT *
FROM sale.order_item

SELECT DISTINCT TOP 10 P.product_name, O.order_id, P.list_price
FROM product.product P, sale.order_item O
WHERE P.product_id = O.order_id
ORDER BY list_price DESC






SELECT count(DISTINCT order_id)
FROM sale.order_item

SELECT order_id, MAX(item_id) Maks
FROM sale.order_item
GROUP BY order_id

SELECT order_id, COUNT(item_id) Maks
FROM sale.order_item
GROUP BY order_id

SELECT order_id, MAX(list_price) Maks
FROM sale.order_item
GROUP BY order_id

SELECT *
FROM sale.order_item
WHERE order_id = 1

SELECT order_id, MAX(quantity) Maks
FROM sale.order_item
GROUP BY order_id

----Her bir sipariþte, en çok sipariþ edilen ürünü adý:
SELECT A.order_id, MAX(A.quantity)  maksimum_quantity
FROM sale.order_item A
GROUP BY A.order_id


WITH table_1 as
			(
			SELECT order_id, MAX(A.quantity) max_quantity
			FROM sale.order_item A
			GROUP BY A.order_id
			)
SELECT B.order_id, table_1.max_quantity, B.product_id
FROM  table_1, sale.order_item B
WHERE table_1.order_id = B.order_id
AND table_1.max_quantity = B.quantity


SELECT S.store_id,O.order_id,C.first_name,C.last_name
FROM sale.store S, sale.orders O,sale.customer C
WHERE	S.store_id = O.store_id AND
		C.customer_id = O.customer_id AND
		S.store_id = 1

SELECT MONTH(order_date) order_month,COUNT(order_id) order_quan
FROM sale.orders
WHERE YEAR(order_date) = 2018
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date)


select month(order_date) Ay, count(order_id) Satýs
from [sale].[orders]
where year(order_date) = 2018
group by month(order_date)