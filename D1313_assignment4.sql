/*
Discount Effects

Generate a report including product IDs and discount effects on whether the increase in the discount rate positively impacts the number of orders for the products.

In this assignment, you are expected to generate a solution using SQL with a logical approach. 

Sample Result:
Product_id	Discount Effect
1			Positive
2			Negative
3			Negative
4			Neutral
*/

select *
from product.product

from sale.order_item
where product_id = 1

select * from sale.order_item

-- sale order item tablosundan product id, discount ve sat�� toplam�n� getirelim
select product_id, discount, sum(quantity) as sale_quantity
from sale.order_item
group by product_id, discount
order by product_id


-- her bir discount i�in kendisinden bir sonraki discount de�erinde yap�lan sat�� say�s�n� lead ile yan�na yazd�ral�m
select	product_id, discount, sum(quantity) as sale_quantity,
		lead(sum(quantity)) over (partition by product_id order by discount ) as next_sale_quantity
from sale.order_item
group by product_id, discount
order by product_id

-- Bu �ekilde iken her bir product id nin her bir indirim de�erinde sat�� rakamlar�na etkisini g�relim
select	product_id, discount, sum(quantity) as sale_quantity,
		lead(sum(quantity)) over (partition by product_id order by discount) as next_sale_quantity,
		CASE 
			WHEN (lead(sum(quantity)) over (partition by product_id order by discount) - sum(quantity)) > 0 THEN 'Positive'
			WHEN (lead(sum(quantity)) over (partition by product_id order by discount) - sum(quantity)) < 0 THEN 'Negative'
			WHEN (lead(sum(quantity)) over (partition by product_id order by discount) - sum(quantity)) = 0 THEN 'Neutral'
			ELSE '-'
		END AS Discount_Effect
from sale.order_item
group by product_id, discount
order by product_id


-- son sorgu sonucu i�in view alal�m
CREATE VIEW AA
AS
select	product_id, discount, sum(quantity) as sale_quantity,
		lead(sum(quantity)) over (partition by product_id order by discount) as next_sale_quantity,
		CASE 
			WHEN (lead(sum(quantity)) over (partition by product_id order by discount) - sum(quantity)) > 0 THEN 'Positive'
			WHEN (lead(sum(quantity)) over (partition by product_id order by discount) - sum(quantity)) < 0 THEN 'Negative'
			WHEN (lead(sum(quantity)) over (partition by product_id order by discount) - sum(quantity)) = 0 THEN 'Neutral'
			ELSE '-'
		END AS Discount_Effect
from sale.order_item
group by product_id, discount

select * from aa

-- view �zerinden ortalamalar� getirelim
select distinct product_id, avg(sale_quantity) as avg_sale_quantity, 
				avg(next_sale_quantity) as avg_next_sale_quantity 
from AA
group by product_id
order by product_id


-- bu sorgu sonucu i�in de view alal�m
CREATE VIEW BB
AS
select distinct product_id, avg(sale_quantity) as avg_sale_quantity, 
				avg(next_sale_quantity) as avg_next_sale_quantity 
from AA
group by product_id


select * from BB

-- son durumu g�relim
select *,
		CASE 
			WHEN avg_next_sale_quantity > avg_sale_quantity THEN 'Positive'
			WHEN avg_next_sale_quantity < avg_sale_quantity THEN 'Negative'
			WHEN avg_next_sale_quantity = avg_sale_quantity THEN 'Neutral'
			ELSE '-'
		END AS discount_effect
from BB


-- �DEV CEVABI QUERY Y� �ALI�TIRALIM
select product_id,
		CASE 
			WHEN avg_next_sale_quantity > avg_sale_quantity THEN 'Positive'
			WHEN avg_next_sale_quantity < avg_sale_quantity THEN 'Negative'
			WHEN avg_next_sale_quantity = avg_sale_quantity THEN 'Neutral'
			ELSE '-'
		END AS discount_effect
from BB