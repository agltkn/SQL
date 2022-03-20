CREATE DATABASE ECMR
USE ECMR

SELECT *
FROM cust_dimen

SELECT *
FROM market_fact$

SELECT *
FROM orders_dimen

SELECT *
FROM prod_dimen$

SELECT *
FROM shipping_dimen

CREATE VIEW JTable
AS
SELECT *
FROM dbo.market_fact$ M
LEFT JOIN dbo.prod_dimen$ P ON M.Prod_id = P.Prod_id
LEFT JOIN dbo.orders_dimen O ON M.Ord_id = O.Ord_id
LEFT JOIN dbo.shipping_dimen S ON M.Ship_id = S.Ship_id
LEFT JOIN dbo.cust_dimen C ON M.Cust_id = C.Cust_id

