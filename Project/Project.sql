SELECT	M.mf_id,
		C.Cust_id,
		S.Ship_id,
		P.Prod_id,
		O.Ord_id,
		C.Customer_Name,
		C.Province,C.Region,
		C.Customer_Segment,
		S.Order_ID,
		S.Ship_Mode,
		S.Ship_Date,
		P.Product_Category,
		P.Product_Sub_Category,
		O.Order_Date,
		O.Order_Priority,
		M.Sales,
		M.Discount,
		M.Order_Quantity,
		M.Product_Base_Margin
INTO
		dbo.combined_table
FROM 
		dbo.market_fact M
LEFT JOIN dbo.prod_dimen P ON M.Prod_id = P.Prod_id
LEFT JOIN dbo.orders_dimen O ON M.Ord_id = O.Ord_id
LEFT JOIN dbo.shipping_dimen S ON M.Ship_id = S.Ship_id
LEFT JOIN dbo.cust_dimen C ON M.Cust_id = C.Cust_id

SELECT *
FROM combined_table
where Cust_id = 1080

WITH table1 AS
				(
				SELECT DISTINCT Cust_id,Customer_Name,COUNT(Ord_id) OVER(PARTITION BY Cust_id) count_of_orders
				FROM combined_table
				)
SELECT TOP 3 Cust_id,Customer_Name,count_of_orders
FROM table1
ORDER BY count_of_orders DESC


--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.

ALTER TABLE combined_table
ADD DaysTakenForDelivery INT

UPDATE combined_table
SET DaysTakenForDelivery = DATEDIFF(day,Order_Date,Ship_Date)

SELECT Order_Date,Ship_Date,DATEDIFF(day,Order_date,Ship_Date) Date_dif
FROM combined_table

SELECT Order_Date,Ship_Date,DaysTakenForDelivery
FROM combined_table
ORDER BY DaysTakenForDelivery DESC

--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"

SELECT Customer_Name
FROM combined_table
WHERE DaysTakenForDelivery IN
(
SELECT TOP 1 DaysTakenForDelivery
FROM combined_table
ORDER BY DaysTakenForDelivery DESC
)
--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use date functions and subqueries

/*2011 ocak ayýndaki müþterilerin 2011' deki tüm aylara göre daðýlýmý.
Mesela 2011 Ocak ayýnda 100 müþteri vardý. Bu 100 müþteriden;
Þubat ayýnda 20,
Mart ayýnda 30,
Nisan ayýnda 10,
....
tanesi tekrar gelmiþ anlamýnda bir rapor.*/

SELECT COUNT(Cust_id) OVER(PARTITION BY DATEPART(MONTH,Order_Date))
FROM combined_table
WHERE Order_Date BETWEEN 2011-01-01 AND 2011-12-31


SELECT COUNT(Cust_id)
FROM

SELECT Cust_id,Order_Date
FROM combined_table
GROUP BY DATEPART(MONTH,Order_Date)
WHERE DATEPART(YEAR,Order_Date) = 2011