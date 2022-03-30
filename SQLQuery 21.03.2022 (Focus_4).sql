-- ürün kategorilerindeki toplam sipariþ deðeri


SELECT	C.category_id,
		C.category_name,
		SUM(O.quantity*(1-O.discount)*O.list_price) Order_Value

FROM	product.category	C,
		product.product		P,
		sale.order_item		O

WHERE	C.category_id = P.category_id
	AND P.product_id = O.product_id

GROUP BY C.category_id,C.category_name
ORDER BY Order_Value DESC







SELECT DISTINCT	C.category_name,
				SUM(O.quantity*(1-O.discount)*O.list_price)
				OVER(PARTITION BY C.category_name) Cat_Value,
				B.brand_name,
				SUM(O.quantity*(1-O.discount)*O.list_price)
				OVER(PARTITION BY B.Brand_name) Brand_Value
FROM			product.category	C,
				product.product		P,
				sale.order_item		O,
				product.brand		B
WHERE	C.category_id = P.category_id 
	AND P.product_id = O.product_id
	AND P.brand_id = B.brand_id




--Her bir kategoride en fazla kazanç getiren marka--

SELECT	DISTINCT category_name,
		FIRST_VALUE(brand_name) OVER(PARTITION BY category_name ORDER BY Brand_Value DESC),
		MAX(Brand_Value) OVER(PARTITION BY category_name) MKS
FROM
(
		SELECT DISTINCT	C.category_name,
						B.brand_name,
						SUM(O.quantity*(1-O.discount)*O.list_price)
						OVER(PARTITION BY C.category_name,B.Brand_name) Brand_Value
		FROM			product.category	C,
						product.product		P,
						sale.order_item		O,
						product.brand		B
		WHERE			C.category_id = P.category_id 
					AND P.product_id = O.product_id
					AND P.brand_id = B.brand_id
) TBL

SELECT	DISTINCT category_name,
		MAX(Brand_Value) OVER(PARTITION BY category_name) MKS
FROM
(
		SELECT DISTINCT	C.category_name,
						B.brand_name,
						SUM(O.quantity*(1-O.discount)*O.list_price)
						OVER(PARTITION BY C.category_name,B.Brand_name) Brand_Value
		FROM			product.category	C,
						product.product		P,
						sale.order_item		O,
						product.brand		B
		WHERE			C.category_id = P.category_id 
					AND P.product_id = O.product_id
					AND P.brand_id = B.brand_id
) TBL






		
		



