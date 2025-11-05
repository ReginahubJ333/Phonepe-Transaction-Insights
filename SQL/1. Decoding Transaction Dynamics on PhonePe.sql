--- DATA ANALYSIS -- 
--- CASE 1 --- DECODING TRANSACTION DYNAMICS ON PHONEPE---

--- QUERY 1 ---
--- TRANSACTION TRENDS BY STATE ---

USE phonepe;
SELECT State, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY State
ORDER BY Total_Amount DESC;

--- QUERY 2 ---
--- QUARTERLY GROWTH ---

USE phonepe;
SELECT Year, Quarter, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY Year, Quarter
ORDER BY Year, Quarter DESC;

--- QUERY 3 ---
--- TOP PERFORMING CATEGORIES ---

USE phonepe;
SELECT Category, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY Category
ORDER BY Total_Amount DESC;

--- QUERY 4 ---
--- HIGH AND LOW PERFORMING STATES ---

USE phonepe;
WITH HIGH AS (
SELECT State, 
     SUM(Amount) AS Total_Amount, 'High Performing' AS Performance_Category
FROM aggregated_transaction
GROUP BY State
HAVING SUM(Amount) > (SELECT AVG(Amount) FROM aggregated_transaction)
ORDER BY Total_Amount DESC
LIMIT 5
),
LOW AS (
SELECT
	State, SUM(Amount) AS Total_Amount, 'Low Performing' AS Performance_Category
FROM aggregated_transaction
GROUP BY State
HAVING SUM(Amount) < (SELECT AVG(Amount) FROM aggregated_transaction)
ORDER BY Total_Amount ASC
LIMIT 10
)
SELECT * FROM HIGH
UNION ALL
SELECT * FROM LOW;

--- QUERY 5 ---
--- DISTRICT LEVEL HIGH PERFORMING ---

USE phonepe;
SELECT State, District, SUM(Amount) AS Total_Amount
FROM map_transaction
GROUP BY State, District
ORDER BY State, Total_Amount DESC
LIMIT 10;



     
