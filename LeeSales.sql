USE LeeSales
GO

/* Create Unit_Price and Unit_Cost columns in Sales table */
ALTER TABLE Sales
ADD Unit_Price money NULL, Unit_Cost money NULL;

UPDATE Sales
SET Sales.Unit_Price = Menu.Price,
	Sales.Unit_Cost = Menu.Cost
FROM Sales 
LEFT OUTER JOIN Menu 
ON Sales.Item_ID = Menu.ID

SELECT * FROM Sales

/* Create Total_Sale, Total_Cost, Revenue columns in Sales table */
ALTER TABLE Sales
ADD Total_Sales money NULL, Total_Cost money NULL, Revenue money NULL;

UPDATE Sales
SET Total_Sales = Sale_Unit*Unit_Price,
	Total_Cost = Sale_Unit*Unit_Cost,
	Revenue = Total_Sales - Total_Cost;

SELECT * FROM Sales
SELECT * FROM Branches

/* Analyzing Sales Data */
/* Extract 2017 revenue by store and create Store_Sales table */
SELECT [Branch_ID], SUM(Revenue) AS "Total_Revenue"
INTO Store_Sales
FROM Sales
GROUP BY [Branch_ID];

ALTER TABLE Store_Sales
ADD Store_Name VARCHAR(50) NULL;

UPDATE Store_Sales
SET [Store_Name] = [Name]
FROM Store_Sales LEFT OUTER JOIN Branches 
ON Store_Sales.[Branch_ID] = Branches.[Branch_ID];

SELECT * FROM Store_Sales
ORDER BY Branch_ID ASC;

/* Extract 2017 revenue by food type */
SELECT [Type], SUM(Revenue) AS "Total_Revenue"
INTO FoodType_Sales
FROM Sales
GROUP BY [Type];

/* Extract 2017 revenue by season */
/* By month */
SELECT MONTH(Date) AS "Month_Sales", SUM(Revenue) AS "Total_Revenue" 
INTO Month_Sales
FROM Sales
GROUP BY MONTH(Date)
ORDER BY "Month_Sales" ASC;

/* By Quarter */
SELECT DATEPART(Quarter, Date) AS "Quarter_Sales", SUM(Revenue) AS "Total_Revenue"
INTO Seanson_Sales
FROM Sales
GROUP BY DATEPART(Quarter, Date)
ORDER BY "Quarter_Sales" ASC;
