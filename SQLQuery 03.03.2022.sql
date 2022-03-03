------ Built-in Functions

-- March 3,2022

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset
	)

SELECT * FROM t_date_time

SELECT GETDATE()

INSERT t_date_time VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

SELECT * FROM t_date_time


INSERT t_date_time (
	A_time,
	A_date,
	A_smalldatetime,
	A_datetime,
	A_datetime2,
	A_datetimeoffset
	)
VALUES
	('12:00:00',
	'2021-07-17',
	'2021-07-17',
	'2021-07-17',
	'2021-07-17',
	'2021-07-17'
	)

SELECT * FROM t_date_time

SELECT CONVERT(VARCHAR, GETDATE(),7)

SELECT CONVERT(DATE, '25 OCT 21', 6)

SELECT	A_date,
		DATENAME(DW,A_date) [DAYS],
		DAY (A_date) [DAYS2]
FROM	t_date_time



SELECT	A_date,
		DATENAME(DW, A_date) [DAY],
		DAY (A_date) [DAY2],
		MONTH(A_date),
		YEAR (A_date),
		A_time,
		DATEPART (NANOSECOND, A_time),
		DATEPART (MONTH, A_date)
FROM	t_date_time

---DATEDIFF---

SELECT	A_date,	
		A_datetime
FROM	t_date_time


SELECT	A_date,	
		A_datetime,
		DATEDIFF (DAY, A_date, A_datetime) Diff_day,
		DATEDIFF (MONTH, A_date, A_datetime) Diff_month,
		DATEDIFF (YEAR, A_date, A_datetime) Diff_month,
		DATEDIFF (HOUR, A_smalldatetime, A_datetime) Diff_Hour,
		DATEDIFF (MINUTE, A_smalldatetime, A_datetime) Diff_Hour
FROM	t_date_time

SELECT shipped_date, order_date,
		DATEDIFF (DAY, order_date, shipped_date) [DIFF]
FROM sale.orders


SELECT * FROM sale.orders

SELECT order_date,
		DATEADD (YEAR, 3, order_date) [new_year],
		DATEADD (DAY, -5, order_date) [new_day]
FROM [sale].[orders]

SELECT order_date,
        DATEADD (YEAR, 3, (DATEADD (DAY, -5, order_date))) [new_date]
FROM [sale].[orders]


-- EOMONTH
SELECT EOMONTH(order_date) LAST_DAY, order_date, EOMONTH(order_date, 2) after_2
FROM [sale].[orders]

-- ISDATE

SELECT ISDATE ('123456')

SELECT ISDATE ('1982-12-06') --1 VEYA 0 SONUÇ VERÝR

--LEN/ CHARINDEX/ PATHINDEX

SELECT LEN(123456)

SELECT LEN('WELCOME')

SELECT LEN(WELCOME)

SELECT CHARINDEX('C','CHARACTER')
SELECT CHARINDEX('C','CHARACTER', 2)
SELECT CHARINDEX('CT','CHARACTER')

SELECT PATINDEX ('%R','CHARACTER')
SELECT PATINDEX ('R%','CHARACTER')
SELECT PATINDEX ('___R%','CHARACTER')

SELECT LEFT('CHARACTER', 3)
SELECT LEFT(' CHARACTER', 3)

SELECT RIGHT('CHARACTER', 3)
SELECT RIGHT('CHARACTER ', 3)

SELECT SUBSTRING('CHARACTER', 3, 5)
SELECT SUBSTRING('CHARACTER', -1, 5) --CHA DÖNDÜRÜR

SELECT LOWER('CHARACTER')
SELECT UPPER('character')
SELECT UPPER(LEFT('character',1))
SELECT UPPER(LEFT('character',1)) + LOWER(RIGHT('character',8))
SELECT UPPER(LEFT('character',1)) + LOWER(RIGHT('character',LEN ('character')-1))

SELECT * FROM STRING_SPLIT ('John, Jeremy, Jack, George', ',')

----- LTRIM/ RTRIM/ TRIM-----

SELECT TRIM ('     CHARACTER')

SELECT TRIM ('     CHARACTER     ')

SELECT TRIM ('     CHAR ACTER     ')

SELECT TRIM('?, ' FROM '    ?SQL Server,    ') AS TrimmedString;

SELECT LTRIM ('     CHARACTER     ') 

SELECT RTRIM ('     CHARACTER     ')

----REPLACE/ STR-----

SELECT REPLACE('CHARACTER STRING', ' ', '/')

SELECT STR(5454)

SELECT STR(1234567891)

SELECT STR(5454, 10, 5)

SELECT STR(133215.654645, 11, 3)

----- CAST/ CONVERT/ COALESCE/ NULLIF/ ROUNF -----

SELECT CAST (456123 AS CHAR)

SELECT CAST (456.123 AS INT)


SELECT CONVERT (INT, 30.60)

SELECT CONVERT (VARCHAR(10), '2020-10-10')

SELECT COALESCE (NULL, NULL, 'Hi', 'Hello', NULL) Result;

SELECT NULLIF (10,10)

SELECT NULLIF('Hello', 'Hi') Result;

SELECT COALESCE (NULL, NULL, 'Hi', 'Hello', NULL) Result;

SELECT NULLIF (10,10)

SELECT NULLIF('Hello', 'Hi') Result;

SELECT ROUND (432.368, 2, 0) -- 0 YUKARI, 1 AÞAÐI YUVARLAR--

SELECT ROUND (432.368, 1, 0)

SELECT ROUND (432.368, 2, 1)

SELECT ROUND (432.368, 2)