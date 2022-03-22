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

-- sale order item tablosundan product id, discount ve satýþ toplamýný getirelim
select product_id, discount, sum(quantity) as sale_quantity
from sale.order_item
group by product_id, discount
order by product_id


-- her bir discount için kendisinden bir sonraki discount deðerinde yapýlan satýþ sayýsýný lead ile yanýna yazdýralým
select	product_id, discount, sum(quantity) as sale_quantity,
		lead(sum(quantity)) over (partition by product_id order by discount ) as next_sale_quantity
from sale.order_item
group by product_id, discount
order by product_id

-- Bu þekilde iken her bir product id nin her bir indirim deðerinde satýþ rakamlarýna etkisini görelim
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


-- son sorgu sonucu için view alalým
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

-- view üzerinden ortalamalarý getirelim
select distinct product_id, avg(sale_quantity) as avg_sale_quantity, 
				avg(next_sale_quantity) as avg_next_sale_quantity 
from AA
group by product_id
order by product_id


-- bu sorgu sonucu için de view alalým
CREATE VIEW BB
AS
select distinct product_id, avg(sale_quantity) as avg_sale_quantity, 
				avg(next_sale_quantity) as avg_next_sale_quantity 
from AA
group by product_id


select * from BB

-- son durumu görelim
select *,
		CASE 
			WHEN avg_next_sale_quantity > avg_sale_quantity THEN 'Positive'
			WHEN avg_next_sale_quantity < avg_sale_quantity THEN 'Negative'
			WHEN avg_next_sale_quantity = avg_sale_quantity THEN 'Neutral'
			ELSE '-'
		END AS discount_effect
from BB


-- ÖDEV CEVABI QUERY YÝ ÇALIÞTIRALIM
select product_id,
		CASE 
			WHEN avg_next_sale_quantity > avg_sale_quantity THEN 'Positive'
			WHEN avg_next_sale_quantity < avg_sale_quantity THEN 'Negative'
			WHEN avg_next_sale_quantity = avg_sale_quantity THEN 'Neutral'
			ELSE '-'
		END AS discount_effect
from BB