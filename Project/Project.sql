
CREATE VIEW JTable
AS
SELECT M.mf_id, C.Customer_Name,C.Province,C.Region,C.Customer_Segment
FROM dbo.market_fact M
LEFT JOIN dbo.prod_dimen P ON M.Prod_id = P.Prod_id
LEFT JOIN dbo.orders_dimen O ON M.Ord_id = O.Ord_id
LEFT JOIN dbo.shipping_dimen S ON M.Ship_id = S.Ship_id
LEFT JOIN dbo.cust_dimen C ON M.Cust_id = C.Cust_id

SELECT *
FROM JTable
