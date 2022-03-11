---- C-10 WEEKLY AGENDA-8 RD&SQL STUDENT

---- 1. List all the cities in the Texas and the numbers of customers in each city.----

SELECT city, COUNT(customer_id) as num_of_cust
FROM sale.customer
WHERE state = 'TX'
GROUP BY city
ORDER BY num_of_cust


---- 2. List all the cities in the California which has more than 5 customer, by showing the cities which have more customers first.---

select city, count(customer_id) as customer_count 
from sale.customer
where state= 'CA'
group by city
having count(customer_id) > 5
order by city 


SELECT city, COUNT(customer_id)
FROM sale.customer
WHERE state = 'CA'
GROUP BY city
HAVING COUNT(customer_id) > 5 
ORDER BY COUNT(customer_id) desc


---- 3. List the top 10 most expensive products----

select top 10 p.product_name, p.list_price
from product.product p
order by p.list_price desc


SELECT Top 10 product_name, list_price 
FROM product.product
ORDER BY list_price desc


---- 4. List store_id, product name and list price and the quantity of the products 
----    which are located in the store id 2 and the quantity is greater than 25 -----

select A.store_id, B.product_name, B.list_price, A.quantity
from product.stock A
join product.product B on A.product_id = B.product_id
where A.store_id = 2 and A.quantity > 25


select s.store_id, p.product_name, p.list_price, s.quantity
from product.stock as s
join product.product p on s.product_id = p.product_id
where s.store_id = 2 and s.quantity > 5

select B.store_id,C.product_name,C.list_price,B.quantityfrom sale.store A join product.stock B 	on A.store_id=B.store_idJOIN product.product C 	on C.product_id=B.product_id WHERE B.quantity>25 and B.store_id=2

SELECT B.store_id, A.product_name, A.list_price, B.quantityFROM product.product AS A, product.stock AS BWHERE A.product_id = B.product_id AND B.store_id = 2 AND B.quantity > 25ORDER BY product_name



---- 5. Find the sales order of the customers who lives in Boulder order by order date----

select A.customer_id, A.first_name, A.last_name, A.city, B.order_id, B.order_date
from sale.customer A
join sale.orders B on A.customer_id = B.customer_id 
where A.city = 'Boulder'
order by B.order_date desc 

SELECT order_id, order_date, customer_idFROM sale.ordersWHERE customer_id IN (	SELECT customer_id	FROM sale.customer	WHERE city = 'Boulder'	)ORDER BY order_date



---- 6. Get the sales by staffs and years using the AVG() aggregate function.

SELECT A.staff_id, A.first_name, A.last_name, YEAR(B.order_date) as YEARS, AVG (C.quantity) as SALES
FROM sale.staff A
JOIN sale.orders B ON A.staff_id = B.staff_id
JOIN sale.order_item C ON B.order_id = C.order_id
GROUP BY A.staff_id, A.first_name, A.last_name, YEAR(B.order_date)
ORDER BY YEARS

/*
SELECT		  A.first_name, A.last_name, YEAR(B.order_date) as year , AVG((C.list_price-C.discount)*C.quantity) as avg_amount	
FROM		  sale.staff A
INNER JOIN    sale.orders B
ON            A.staff_id =B.staff_id
INNER JOIN    sale.order_item C
ON            B.order_id =C.order_id		 
GROUP BY  A.first_name, A.last_name, YEAR(B.order_date)
ORDER BY  A.first_name, A.last_name, YEAR(B.order_date)
*/

SELECT  B.staff_id,B.first_name,B.last_name,YEAR(A.order_date) as date_year,
		AVG(C.list_price*(1-C.discount)*C.quantity) AS SALES_AVG
FROM sale.orders A 
	JOIN sale.staff B
		ON A.staff_id=B.staff_id
	JOIN SALE.order_item C
		ON  A.order_id=C.order_id
GROUP BY  B.staff_id,B.first_name,B.last_name,YEAR(A.order_date)
ORDER BY staff_id


---- 7. What is the sales quantity of product according to the brands and sort them highest-lowest----

select A.brand_id, C.brand_name, A.product_name, sum(B.quantity) as sales_quantity
from product.product A
join sale.order_item B on A.product_id = B.product_id
join product.brand C on A.brand_id = C.brand_id
group by A.brand_id, C.brand_name, A.product_name
order by sum(B.quantity) desc





---- 8. What are the categories that each brand has?----

SELECT b.brand_name, c.category_name

FROM product.product p, product.brand b, product.category c

WHERE p.brand_id = b.brand_id and p.category_id = c.category_id

GROUP BY b.brand_name, c.category_name

ORDER BY b.brand_name



SELECT B.brand_name,C.category_nameFROM product.product A INNER JOIN product.brand B on A.brand_id= B.brand_idINNER JOIN product.category C on A.category_id=C.category_idGROUP BY B.brand_name,C.category_name



---- 9. Select the avg prices according to brands and categories----

SELECT b.brand_name, c.category_name, AVG(list_price) avg_list_price

FROM product.product p, product.brand b, product.category c

WHERE p.brand_id = b.brand_id and p.category_id = c.category_id

GROUP BY b.brand_name, c.category_name

ORDER BY avg_list_price


SELECT B.brand_id, B.brand_name, C.category_name, AVG(A.list_price) AS price_avgFROM product.product A	JOIN product.brand B		ON A.brand_id=b.brand_id	JOIN product.category C		ON A.category_id=C.category_idGROUP BY B.brand_id, B.brand_name,C.category_nameORDER BY B.brand_id, price_avg DESC



---- 10. Select the annual amount of product produced according to brands----

SELECT b.brand_name, p.model_year, sum(s.quantity) as product_amount

FROM product.product p, product.brand b, product.stock s

WHERE p.brand_id = b.brand_id and p.product_id = s.product_id

GROUP BY b.brand_name, p.model_year

ORDER BY b.brand_name, p.model_year, product_amount



---- 11. Select the store which has the most sales quantity in 2016.----

SELECT A.store_name,	YEAR(B.order_date) AS date_year,	SUM(c.quantity) AS sum_quantityFROM sale.store A	JOIN sale.orders B		ON A.store_id=B.store_id	JOIN sale.order_item C		ON B.order_id=C.order_id--where YEAR(B.order_date)=2016GROUP BY A.store_name, YEAR(B.order_date)
ORDER BY A.store_name, date_year


---- 12 Select the store which has the most sales amount in 2018.----

SELECT TOP 1 A.store_name,	YEAR(B.order_date) AS date_year,	SUM(c.quantity) AS sum_quantityFROM sale.store A	JOIN sale.orders B		ON A.store_id=B.store_id	JOIN sale.order_item C		ON B.order_id=C.order_idWHERE YEAR(B.order_date)=2018GROUP BY A.store_name, YEAR(B.order_date)
ORDER BY sum_quantity DESC


SELECT TOP 1 A.store_name, SUM(C.list_price*(1-C.discount)*C.quantity) as most_sales_amountFROM sale.store A, sale.orders B, sale.order_item CWHERE A.store_id=B.store_id and B.order_id= C.order_idAND order_date BETWEEN '2018-01-01' and '2018-12-31'GROUP BY A.store_nameORDER BY most_sales_amount DESC



---- 13. Select the personnel which has the most sales amount in 2019.----

SELECT TOP 1 A.staff_id, A.first_name, A.last_name,
	YEAR(B.order_date),
	COUNT(C.quantity)
FROM sale.staff A
	JOIN sale.orders B
		ON A.staff_id=B.staff_id
	JOIN sale.order_item C
		ON B.order_id=C.order_id
WHERE  YEAR(B.order_date)=2019
GROUP BY A.staff_id,A.first_name,A.last_name,YEAR(B.order_date)
ORDER BY COUNT(C.quantity) DESC


SELECT TOP 1 A.first_name, A.last_name, SUM(C.list_price*(1-C.discount)*C.quantity) as most_sales_amountFROM sale.staff A, sale.orders B, sale.order_item CWHERE A.store_id=B.store_id and B.order_id= C.order_idAND order_date BETWEEN '2019-01-01' and '2019-12-31'GROUP BY A.first_name, A.last_nameORDER BY most_sales_amount DESC


SELECT  TOP 1  A.first_name, A.last_name, SUM(B.list_price*(1-B.discount)*B.quantity) AS sales_2019
from           sale.staff A

INNER JOIN     sale.orders C
	ON         A.staff_id = C.staff_id

INNER JOIN     sale.order_item B
	ON         C.order_id = B.order_id

WHERE          DATEPART(YEAR, C.order_date) = '2019'

GROUP BY       A.first_name, A.last_name 

ORDER BY       SUM(B.list_price) DESC;



