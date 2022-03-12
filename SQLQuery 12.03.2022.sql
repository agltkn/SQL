

/* WINDOW FUNCTIONS */

SELECT *
FROM product.stock

select	product_id, sum(quantity) total_stock
from	product.stock
group by product_id
order by product_id

SELECT *, sum(quantity) OVER (PARTITION BY product_id) total_stock
FROM product.stock
ORDER BY product_id

SELECT product_name,brand_id, AVG(list_price) OVER (PARTITION BY brand_id) avg_price_by_brand
FROM product.product
ORDER BY brand_id

SELECT	category_id, product_id,
		COUNT(*) OVER() NOTHING,
		COUNT(*) OVER(PARTITION BY category_id) countofprod_by_cat,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) whole_rows,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id) countofprod_by_cat_2,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) specified_columns_1,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) specified_columns_2
FROM	product.product
ORDER BY category_id, product_id

/* What is the cheapest product price? */

SELECT TOP 1 list_price
FROM product.product
ORDER BY list_price

SELECT DISTINCT category_id, MIN(list_price) OVER(PARTITION BY category_id) Cheapest_by_cat
FROM product.product

SELECT COUNT(product_id)
FROM product.product

select	distinct count(*) over()
from	product.product

select	count(distinct product_id)
from	sale.order_item
;
select	count(distinct product_id) over ()
from	sale.order_item

-- write a query that returns how many products are in each order?
select	distinct order_id, count(item_id) over(partition by order_id) cnt_product
from	sale.order_item

select	distinct category_id, brand_id, count(*) over(partition by brand_id, category_id) num_of_prod
from	product.product
order by brand_id, category_id

SELECT	A.customer_id, A.first_name, B.order_date,
		FIRST_VALUE(B.order_date) OVER (ORDER BY B.order_date) min_order_date
FROM sale.customer A, sale.orders B
WHERE A.customer_id = B.customer_id

select	a.customer_id, a.first_name, b.order_date,
		LAST_VALUE(b.order_date) over(order by b.order_date)
from	sale.customer a, sale.orders b
where	a.customer_id = b.customer_id
;

select	distinct
		first_value(product_name) over (order by list_price, model_year DESC) cheapest_product_name,
		first_value(list_price) over (order by list_price, model_year DESC) cheapest_product_price
from	product.product

select	b.order_id, a.staff_id, a.first_name, a.last_name, b.order_date,
		lag(b.order_date, 2) over(partition by a.staff_id order by b.order_id) previous_order_date
from	sale.staff a, sale.orders b
where	a.staff_id = b.staff_id
order by a.staff_id, b.order_date

select	b.order_id, a.staff_id, a.first_name, a.last_name, b.order_date
from	sale.staff a, sale.orders b
where	a.staff_id = b.staff_id
order by a.staff_id, b.order_date


select	b.order_id, a.staff_id, a.first_name, a.last_name, b.order_date,
		lead(b.order_date) over(partition by a.staff_id order by b.order_id) next_order_date
from	sale.staff a, sale.orders b
where	a.staff_id = b.staff_id
order by a.staff_id, b.order_date
;


