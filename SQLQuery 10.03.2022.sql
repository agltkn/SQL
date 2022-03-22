SELECT *
FROM sale.staff
WHERE store_id =(
				SELECT store_id
				FROM sale.staff
				WHERE first_name = 'Davis' and last_name = 'Thomas'
				)

SELECT *
FROM sale.staff
WHERE manager_id =(
				SELECT staff_id
				FROM sale.staff
				WHERE first_name = 'Charles' and last_name = 'Cussona'
				)

SELECT *
FROM sale.staff
WHERE manager_id =(
				SELECT staff_id
				FROM sale.staff
				WHERE first_name = 'Charles' and last_name = 'Cussona'
				)




select	*
from	sale.customer
where	city = (
			select	city
			from	sale.store
			where	store_name = 'The BFLO Store'
		)


SELECT *
FROM product.product
WHERE list_price > (
					SELECT list_price
					FROM product.product
					WHERE product_name = 
					'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'
					) and
					category_id = (
					SELECT category_id
					FROM product.category
					WHERE category_name = 'Televisions & Accessories'
					)

select	b.first_name, b.last_name, a.order_date
from	sale.orders a, sale.customer b
where	a.customer_id = b.customer_id and
		a.order_date IN (
			select	a.order_date
			from	sale.orders a, sale.customer b
			where	a.customer_id = b.customer_id and
					b.first_name = 'Laurel' and
					b.last_name = 'Goldammer'
		)

select	*
from	product.product
where	model_year = 2021 and
		category_id NOT IN (
			select	category_id
			from	product.category
			where	category_name IN ('Game', 'gps', 'Home Theater')
		)

select	product_name, model_year, list_price
from	product.product
where	model_year = 2020 and
		list_price >ALL (
			select	b.list_price
			from	product.category a, product.product b
			where	a.category_name = 'Receivers Amplifiers' and
					a.category_id = b.category_id
		)
order by list_price DESC

select	product_name, model_year, list_price
from	product.product
where	model_year = 2020 and
		list_price >ANY (
			select	b.list_price
			from	product.category a, product.product b
			where	a.category_name = 'Receivers Amplifiers' and
					a.category_id = b.category_id
		)
order by list_price DESC



-- WITH - Jerald Berray
WITH table_name AS (
		SELECT	MAX(B.order_date) last_order_date
		FROM	sale.customer A, sale.orders B
		WHERE	A.first_name = 'Jerald' AND
					A.last_name = 'Berray' AND
					A.customer_id = B.customer_id
	)
SELECT	*
FROM	table_name
