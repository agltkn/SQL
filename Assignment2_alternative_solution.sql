
SELECT 
	E.*,

	ISNULL(NULLIF(ISNULL(STR(F.customer_id), 'No'), STR(F.customer_id)), 'Yes') First_product,
	ISNULL(NULLIF(ISNULL(STR(G.customer_id), 'No'), STR(G.customer_id)), 'Yes') Second_product,
	ISNULL(NULLIF(ISNULL(STR(H.customer_id), 'No'), STR(H.customer_id)), 'Yes') Third_product

FROM
(
SELECT distinct A.customer_id, A.first_name, A.last_name
FROM  sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id
AND B.order_id = C.order_id
AND C.product_id = D.product_id
AND D.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
) AS E
LEFT JOIN
(
SELECT distinct A.customer_id, A.first_name, A.last_name
FROM  sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id
AND B.order_id = C.order_id
AND C.product_id = D.product_id
AND D.product_name = 'Polk Audio - 50 W Woofer - Black'
) AS F
ON E.customer_id = F.customer_id
LEFT JOIN
(
SELECT distinct A.customer_id, A.first_name, A.last_name
FROM  sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id
AND B.order_id = C.order_id
AND C.product_id = D.product_id
AND D.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'
) AS G
ON E.customer_id = G.customer_id
LEFT JOIN
(
SELECT distinct A.customer_id, A.first_name, A.last_name
FROM  sale.customer A, sale.orders B, sale.order_item C, product.product D
WHERE A.customer_id = B.customer_id
AND B.order_id = C.order_id
AND C.product_id = D.product_id
AND D.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)'
) AS H
ON E.customer_id = H.customer_id
ORDER BY E.customer_id