--- CASE 3 --- TRANSACTION ANALYSIS FOR MARKET EXPANSION ---

---  QUERY 1 --- 
--- TOTAL TRANSACTION VOLUME BY STATE ---

USE phonepe;
SELECT State, SUM(Count) AS Transaction_Count
FROM map_transaction
GROUP BY State
ORDER BY Transaction_Count DESC;

--- QUERY 2 ---
--- TOP 10 DISTRICTS BY TRANSACTION VOLUME ---

USE phonepe;
SELECT State, District, SUM(Count) AS Total_Transaction
FROM map_transaction
GROUP BY State, District
ORDER BY Total_Transaction DESC
LIMIT 10;

--- QUERY 3 ---
--- TOP PIN CODES BY TRANSACTION VOLUME ---

USE phonepe;
SELECT State, Entity_Name AS Pincodes, SUM(Amount) AS Total_Transactions
FROM top_transaction
WHERE Level = 'Pincodes'
GROUP BY State, Entity_Name
ORDER BY Total_Transactions DESC
LIMIT 10;

--- QUERY 4 ---
--- YEAR ON YEAR GROWTH IN TRANSACTIONS BY STATES ---

	USE phonepe;
	SELECT State, Year, SUM(Count) AS Current_Year_Transaction,
		 LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year) AS Previous_Year_Transaction,
		 ROUND(((SUM(Count) - LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year))
			  / LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year)) * 100, 2) AS Growth_Percentage
	FROM map_transaction
	GROUP BY State, Year
	ORDER BY State, Year;

--- QUERY 5 ---
--- TOTAL TRANSACTION VALUE BY STATE AND TRANSACTION TYPE ---

USE phonepe;
SELECT State, Category, SUM(Amount) AS Total_Transaction_Value
FROM aggregated_transaction
GROUP BY State, Category
ORDER BY Total_Transaction_Value DESC;