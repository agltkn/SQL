CREATE VIEW JTable
AS
SELECT	M.mf_id,
		M.Cust_id,
		C.Customer_Name,
		C.Province,
		C.Region,
		C.Customer_Segment,
		M.Ord_id,
		O.Order_Date,
		O.Order_Priority,
		M.Ship_id,
		S.Order_ID,
		S.Ship_Mode,
		S.Ship_Date,
		M.Prod_id,
		P.Product_Category,
		P.Product_Sub_Category,
		M.Sales,
		M.Discount,
		M.Order_Quantity,
		M.Product_Base_Margin
FROM dbo.market_fact M
LEFT JOIN dbo.prod_dimen P ON M.Prod_id = P.Prod_id
LEFT JOIN dbo.orders_dimen O ON M.Ord_id = O.Ord_id
LEFT JOIN dbo.shipping_dimen S ON M.Ship_id = S.Ship_id
LEFT JOIN dbo.cust_dimen C ON M.Cust_id = C.Cust_id

SELECT *
FROM JTable
