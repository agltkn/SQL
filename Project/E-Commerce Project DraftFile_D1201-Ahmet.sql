

--DAwSQL Session -8 

--E-Commerce Project Solution



--1. Join all the tables and create a new table called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)

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
LEFT JOIN
		dbo.prod_dimen P ON M.Prod_id = P.Prod_id
LEFT JOIN
		dbo.orders_dimen O ON M.Ord_id = O.Ord_id
LEFT JOIN
		dbo.shipping_dimen S ON M.Ship_id = S.Ship_id
LEFT JOIN
		dbo.cust_dimen C ON M.Cust_id = C.Cust_id

--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.

WITH table1 AS
				(
				SELECT DISTINCT Cust_id,Customer_Name,COUNT(Ord_id) OVER(PARTITION BY Cust_id) count_of_orders
				FROM combined_table
				)
SELECT TOP 3 Cust_id,Customer_Name,count_of_orders
FROM table1
ORDER BY count_of_orders DESC


--/////////////////////////////////



--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.

ALTER TABLE combined_table
ADD DaysTakenForDelivery INT

UPDATE combined_table
SET DaysTakenForDelivery = DATEDIFF(day,Order_Date,Ship_Date)


--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"
SELECT Cust_id,Customer_Name,Province,Region,Customer_Segment, DaysTakenForDelivery
FROM combined_table
WHERE DaysTakenForDelivery IN
(
SELECT TOP 1 DaysTakenForDelivery
FROM combined_table
ORDER BY DaysTakenForDelivery DESC
)

--////////////////////////////////



--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use date functions and subqueries
SELECT MONTH(Order_Date) Month_in_2021,COUNT(DISTINCT Cust_id) Customer_came_back_number
FROM combined_table
WHERE Cust_id in
(
SELECT DISTINCT cust_id
FROM combined_table
WHERE DATEPART(MONTH, Order_Date)=1
AND DATEPART(YEAR,Order_Date)=2011
) 
AND datepart(year,order_date) = 2011
GROUP BY MONTH(Order_Date)




--////////////////////////////////////////////


--6. write a query to return for each user according to the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions

SELECT DISTINCT cust_id,
				order_date,
				dense,
				[1st_ord_date],
				DATEDIFF(day, [1st_ord_date], order_date) time_elapsed
FROM	
		(
		SELECT	Cust_id,
				ord_id,
				order_date,
				MIN (Order_Date) OVER (PARTITION BY cust_id) [1st_ord_date],
				DENSE_RANK () OVER (PARTITION BY cust_id ORDER BY Order_date) dense
		FROM	combined_table
		) TBL
WHERE	dense = 3



--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by all customers.
--Use CASE Expression, CTE, CAST and/or Aggregate Functions

SELECT *
FROM combined_table

WITH TBL1 AS
(
SELECT	Cust_id,
		SUM (CASE WHEN Prod_id = 11 THEN Order_Quantity ELSE 0 END) P11,
		SUM (CASE WHEN Prod_id = 14 THEN Order_Quantity ELSE 0 END) P14,
		SUM (Order_Quantity) TOTAL_PROD
FROM	combined_table
GROUP BY Cust_id
HAVING
		SUM (CASE WHEN Prod_id = 11 THEN Order_Quantity ELSE 0 END) >= 1 AND
		SUM (CASE WHEN Prod_id = 14 THEN Order_Quantity ELSE 0 END) >= 1
)

SELECT	Cust_id, P11, P14, TOTAL_PROD,
		CAST (1.0*P11/TOTAL_PROD AS NUMERIC (3,2)) AS RATIO_P11,
		CAST (1.0*P14/TOTAL_PROD AS NUMERIC (3,2)) AS RATIO_P14
FROM TBL1

--/////////////////



--CUSTOMER SEGMENTATION



--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.

CREATE VIEW customer_logs AS
SELECT	cust_id,
		YEAR (ORDER_DATE) [Year],
		MONTH (ORDER_DATE) [Month]
FROM	combined_table
ORDER BY 1,2,3

--//////////////////////////////////



  --2.Create a “view” that keeps the number of monthly visits by users. (Show separately all months from the beginning  business)
--Don't forget to call up columns you might need later.

CREATE VIEW nmb_of_visits AS 

SELECT	Cust_id, [YEAR], [MONTH], COUNT(*) NUM_OF_LOG
FROM	customer_logs
GROUP BY Cust_id, [YEAR], [MONTH]



--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can order the months using "DENSE_RANK" function.
--then create a new column for each month showing the next month using the order you have made above. (use "LEAD" function.)
--Don't forget to call up columns you might need later.

CREATE VIEW nxt_visit AS 
SELECT *,
		LEAD(cur_month, 1) OVER (PARTITION BY Cust_id ORDER BY cur_month) next_vst_month
FROM 
(
SELECT  *,
		DENSE_RANK () OVER (ORDER BY [YEAR] , [MONTH]) cur_month
		
FROM	nmb_of_visits
) A

--/////////////////////////////////



--4. Calculate monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.







--///////////////////////////////////


--5.Categorise customers using average time gaps. Choose the most fitted labeling model for you.
--For example: 
--Labeled as “churn” if the customer hasn't made another purchase for the months since they made their first purchase.
--Labeled as “regular” if the customer has made a purchase every month.
--Etc.
	







--/////////////////////////////////////




--MONTH-WISE RETENTÝON RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps





--//////////////////////


--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Number of Customers Retained in The Current Month / Total Number of Customers in the Current Month

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.







---///////////////////////////////////
--Good luck!