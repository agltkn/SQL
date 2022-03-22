/*In the stocks table, there are not all products held on the product table and you
want to insert these products into the stock table.
You have to insert all these products for every three stores with “0” quantity.
Write a query to prepare this data.*/


SELECT product_id, quantity
FROM product.stock

SELECT b.store_id, a.product_id ,0 QUANTITY
FROM product.product a
CROSS JOIN sale.store b
WHERE a.product_id NOT IN (
    SELECT product_id
    FROM product.stock
   )
ORDER BY a.product_id , b.store_id

SELECT *
FROM product.product

SELECT product_id, COUNT(product_id) Num_Rows
FROM product.product
GROUP BY product_id
HAVING COUNT(product_id) > 1

SELECT category_id, COUNT(product_id) Num_Rows
FROM product.product
GROUP BY product_id
HAVING COUNT(product_id) > 1

/*Write a query that returns category ids
with a maximum list price above 4000 or
a minimum list price below 500.*/

SELECT category_id, list_price
FROM product.product
ORDER BY category_id, list_price

SELECT
	category_id,
	MAX(list_price) max_price,
	MIN(list_price) min_price
FROM product.product
GROUP BY category_id
HAVING MAX(list_price) > 4000 OR MIN(list_price) < 500

/*Find the average product prices of the brands.
As a result of the query, the average prices
should be displayed in descending order.
Markalara ait ortalama ürün fiyatlarýný bulunuz.
ortalama fiyatlara göre azalan sýrayla gösteriniz.*/

SELECT B.brand_name, AVG(list_price) avg_list_price
FROM product.product A, product.brand B
WHERE A.brand_id = B.brand_id
GROUP BY B.brand_name
ORDER BY avg_list_price DESC

SELECT B.brand_name, AVG(list_price) avg_list_price
FROM product.product A, product.brand B
WHERE A.brand_id = B.brand_id
GROUP BY B.brand_name, B.brand_id
HAVING AVG(list_price) > 1000
ORDER BY avg_list_price ASC

/*Write a query that returns the net price
paid by the customer for each order.
(Don't neglect discounts and quantities)

bir sipariþin toplam net tutarýný getiriniz.
(müþterinin sipariþ için ödediði tutar)
discount' ý ve quantity' yi ihmal etmeyiniz.
quantity * list_price * (1-discount) */



SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary

FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year


--- GROUPING SETS

SELECT *
FROM sale.sales_summary

--- 1. Calculate the total sales price.

SELECT SUM(total_sales_price)
FROM sale.sales_summary

--- 2. Calculate the total sales price of the brand

SELECT brand, SUM(total_sales_price) total
FROM sale.sales_summary
GROUP BY Brand

--- 3. Calculate the total sales price of the categories

SELECT *
FROM sale.sales_summary

SELECT Category, SUM(total_sales_price) total
FROM sale.sales_summary
GROUP BY Category

--- 4. Calculate the total sales price by brands and categories

SELECT Brand,Category,SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY Brand, Category



/*GROUPING SET ÝLE YUKARIDAKÝ 4 KODU BÝRLEÞTÝRME*/

SELECT Brand, Category, SUM(total_sales_price) total
FROM sale.sales_summary
GROUP BY
    GROUPING SETS (
        (),
        (Brand), 
        (Category),
        (Brand,Category)
    )
ORDER BY Brand, Category;

/*Generate different grouping variations that can be produced with the brand and category columns using 'ROLLUP'.
-- Calculate sum total_sales_price
--brand, category, model_year sütunlarý için Rollup kullanarak total sales hesaplamasý yapýn.
--üç sütun için 4 farklý gruplama varyasyonu üretiyor*/
SELECT Brand, Category, Model_Year, SUM(total_sales_price) TOTAL
FROM sale.sales_summary
GROUP BY
	ROLLUP (Brand, Category, Model_Year)
ORDER BY Model_Year, Category


/*ROLL UP*/
SELECT Brand, Category, Model_Year, SUM(total_sales_price)
FROM sale.sales_summary
GROUP BY
	CUBE (Brand, Category, Model_Year)
ORDER BY Brand, Category

/*PIVOT*/
--Write a query that returns total sales amount by categories and model years.

SELECT *
FROM
(
SELECT Category, total_sales_price
FROM sale.sales_summary
) A
PIVOT
(
	SUM(total_sales_price)
	FOR Category
	IN
	([Audio & Video Accessories]
	,[Bluetooth]
	,[Car Electronics]
	,[Computer Accessories]
	,[Earbud]
	,[gps]
	,[Hi-Fi Systems]
	,[Home Theater]
	,[mp4 player]
	,[Receivers Amplifiers]
	,[Speakers]
	,[Televisions & Accessories])
) AS PIVOT_TABLE