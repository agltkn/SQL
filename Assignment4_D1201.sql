/*CALL PRODUCT_ID, QUANTITY and TOTAL SALES*/

SELECT product_id, discount, SUM(quantity) Sales_Quantity
FROM sale.order_item
GROUP BY product_id,discount
ORDER BY product_id,discount


/*CALL FOLLOWING SALES QUANTITY PER EACH DISCOUNT BASED ON PRODUCT*/

SELECT	product_id,
		discount,
		LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount) Following_Sales
FROM sale.order_item
GROUP BY product_id, discount
ORDER BY product_id

/*CHECK EFFECTS OF INCREASING DISCOUNT ON SALES QUANTITY*/

SELECT	product_id,
		discount,
		LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount) Following_Sales,
		CASE
			WHEN ((LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount)) - SUM(quantity)) < 0 THEN 'NEGATIVE'
			WHEN ((LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount)) - SUM(quantity)) = 0 THEN 'NEUTRAL'
			WHEN ((LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount)) - SUM(quantity)) > 0 THEN 'POSITIVE'
			END Discount_Effect
FROM sale.order_item
GROUP BY product_id, discount
ORDER BY product_id

/*SAVE THIS RESULT AS A TABLE*/

CREATE VIEW Effect_Table
		AS
		SELECT	product_id,
		discount,
		LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount) Following_Sales,
		CASE
			WHEN ((LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount)) - SUM(quantity)) < 0 THEN 'NEGATIVE'
			WHEN ((LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount)) - SUM(quantity)) = 0 THEN 'NEUTRAL'
			WHEN ((LEAD(SUM(quantity)) OVER (PARTITION BY product_id ORDER BY discount)) - SUM(quantity)) > 0 THEN 'POSITIVE'
			END Discount_Effect
		FROM sale.order_item
		GROUP BY product_id, discount

/*SELECT REQUESTED COLUMNS FROM Effect_Table*/
SELECT product_id,Discount_Effect
FROM Effect_Table

