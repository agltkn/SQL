SELECT *
FROM product.stock

SELECT COUNT(DISTINCT product_id)
FROM product.stock

SELECT store_id, SUM(quantity) quantity_in_stores
FROM product.stock
GROUP BY store_id

SELECT COUNT(DISTINCT product_id)
FROM product.product

SELECT DISTINCT S.product_id
FROM product.product P, product.stock S
WHERE P.product_id = S.product_id

SELECT P.product_id
FROM product.product P
JOIN product.stock S ON S.product_id = P.product_id

SELECT product_id
FROM product.product
INTERSECT
SELECT product_id
FROM product.stock





--- 2018'in Mart ayı müşterileri ile 2019 Mart ayı müşterilerinin kesişimi---

SELECT customer_id
FROM sale.customer

SELECT customer_id
FROM sale.orders
WHERE DATEPART(year,order_date) = 2018
INTERSECT
SELECT customer_id
FROM sale.orders
WHERE DATEPART(MONTH,order_date) = 4 AND DATEPART(year,order_date) = 2019

---PRODUCT TABLOSUNDA OLAN STOCK TABLOSUNDA OLMAYAN product_id'LER


SELECT product_id,product_name
FROM product.product

WHERE product_id IN
(
SELECT product_id
FROM product.product
EXCEPT
SELECT product_id
FROM product.stock)

SELECT S.quantity
FROM product.product P 
LEFT JOIN product.stock S
ON S.product_id = P.product_id
WHERE S.product_id IS NULL


SELECT ISNULL('NULL','stokta yok')


SELECT ISNULL(S.product_id,null)
FROM product.product P 
LEFT JOIN product.stock S
ON S.product_id = P.product_id
WHERE S.product_id IS NULL


SELECT COALESCE (null, 'samet', null)

SELECT CASE WHEN 'AHMET' IS NULL THEN 'SAMET' ELSE 'ahmet is not null' END


SELECT a.product_id, b.store_id, ISNULL(str(b.store_id, 30), 'stok bilgisi mevcut degil') stok_durumu
FROM product.product a LEFT JOIN product.stock b
on a.product_id = b.product_id
where b.product_id is null

SELECT a.product_id, b.store_id, ISNULL(cast(b.store_id as varchar (30)), 'stok bilgisi mevcut degil') stok_durumu
FROM product.product a LEFT JOIN product.stock b
on a.product_id = b.product_id

--bunlarda isnull, coalase ve case when kullanimlari

SELECT ISNULL('ahmet', 'samet')
SELECT coalesce(null, 'samet', null)
SELECT case when 'ahmet' IS NULL then 'samet' else 'ahmet null degil' END

--A tablosundaki product_id ile B tabloundaki product_id leri ayrı ayrı sayalım.

select count(distinct A.product_id), count(distinct B.product_id)
from [product].[product] A
left join [product].[stock] B on A.product_id=B.product_id


select DISTINCT count(A.product_id) OVER(), count(B.product_id) OVER()
from [product].[product] A
left join [product].[stock] B on A.product_id=B.product_id

SELECT distinct COUNT(a1) over(), count(b1) over()
FROM  (
select DISTINCT A.product_id a1, B.product_id b1
from [product].[product] A
LEFT join [product].[stock] B on A.product_id=B.product_id
) PRODUCT_a

select *
from sale.customer


-- çözüm2 window function ile yapalım
select distinct count(A.product_id) over() A_table, count(B.product_id) over() B_table
from product.product A 
left join product.stock B
on A.product_id = b.product_id -- uniqe olmaz içteki değerler. bu nedenle ana tablo uniqe leştirilmeli.
​
select distinct count(table_a) over() , count(table_b) over() 
from (
select distinct A.product_id table_a, B.product_id table_b
from product.product A 
left join product.stock B
on A.product_id = b.product_id)
product_a
​
-- customer tablosundaki müşterileri statelere göre sayınız.
select [state], count(customer_id) number_of_customers from sale.customer
group by [state] order by [state] 
​
-- çözüm2 windows function ile yapalım
select distinct [state] , count(customer_id) over(partition by [state]) -- partition by ile grupladık
from sale.customer
​
​
-- customer tablosundaki müşterileri city'lere göre sayınız.
select distinct [state], city, count(customer_id) num_of_customers 
from sale.customer group by [state], city order by city
​
--çözüm2 windows function ile yapalım
select distinct [state], city , count(customer_id) over(partition by [state], [city])  num_of_customers
from sale.customer
​
-- eyaletleri de gösteren sütun ilave edelim.
SELECT DISTINCT state, city, count(customer_id) OVER(PARTITION BY state, city) as number_of_customer_2,
				count(customer_id) OVER(PARTITION BY state) as number_of_customer_3				
FROM sale.customer
