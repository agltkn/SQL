/* a.Create above table (Actions) and insert values */

CREATE TABLE Actions
			(
			Visitor_ID INT,
			Adv_Type VARCHAR(20),
			[Action] VARCHAR(20),
			);

INSERT Actions VALUES
			 (1,'A', 'Left')
			,(2,'A', 'Order')
			,(3,'B', 'Left')
			,(4,'A', 'Order')
			,(5,'A', 'Review')
			,(6,'A', 'Left')
			,(7,'B', 'Left')
			,(8,'B', 'Order')
			,(9,'B', 'Review')
			,(10,'A', 'Review')

SELECT *
FROM Actions

/* b. Retrieve count of total Actions and Orders for each Advertisement Type */

CREATE VIEW Total_Actions 
	AS
	SELECT Adv_Type, COUNT(Action) Total, [Action]
	FROM Actions
	WHERE [Action] = 'Order'
	GROUP BY Adv_Type, [Action] 

CREATE VIEW Total_Orders 
	AS
	SELECT Adv_Type, COUNT([Action]) Total_Orders
	FROM Actions
	GROUP BY Adv_Type

SELECT	Total_Actions.Adv_Type,
		Total_Orders,
		Total
FROM Total_Orders, Total_Actions
WHERE Total_Actions.Adv_Type = Total_Orders.Adv_Type

/* c. Calculate Orders (Conversion) rates for each Advertisement Type
by dividing by total count of actions casting as float by multiplying by 1.0. */

SELECT	Total_Actions.Adv_Type,
		ROUND(CAST(Total AS float)/CAST(Total_Orders AS float), 2)
		AS Conversion_Rate
FROM Total_Actions, Total_Orders
WHERE Total_Actions.Adv_Type = Total_Orders.Adv_Type

SELECT	Total_Actions.Adv_Type,
		ROUND(CONVERT(float,Total)/CONVERT(float,Total_Orders), 2)
		AS Conversion_Rat
FROM Total_Actions, Total_Orders
WHERE Total_Actions.Adv_Type = Total_Orders.Adv_Type