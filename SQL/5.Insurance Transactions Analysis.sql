--- CASE 5 --- INSURANCE TRANSACTION ANALYSIS ---

--- QUERY 1 ---
--- TOTAL INSURANCE TRANSACTION BY STATE ---

USE phonepe;
SELECT State, SUM(Count) AS Total_Transactions
FROM aggregated_insurance
WHERE Year = 2024 AND Quarter = 4
GROUP BY State
ORDER BY Total_Transactions DESC;

--- QUERY 2 ---
--- YEAR-WISE TOTAL INSURANCE TRANSACTIONS ---

USE phonepe;
SELECT Year, SUM(Count) AS Total_Transactions
FROM aggregated_insurance
GROUP BY Year
ORDER BY Year DESC;

--- QUERY 3 ---
--- TOP 5 STATES WITH HIGHEST GROWTH IN TRANSACTION IN A YEAR ---

USE phonepe;
SELECT State, Year, SUM(Count) AS Total_Transactions,
      LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year) AS Previous_Year,
      ROUND(
      ((SUM(Count)-LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year))
      /LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year) * 100),
      2
    ) AS Growth_Percentage  
FROM aggregated_insurance
GROUP BY State, Year
ORDER BY Growth_Percentage DESC
LIMIT 5;      

--- QUERY 4 ---
--- TOTAL INSURANCE AMOUNT OVER YEARS ---

USE phonepe;
SELECT Year, SUM(Amount) As Total_Amount
FROM aggregated_insurance
GROUP BY Year
ORDER BY Year;

--- QUERY 5 ---
--- TOP 5 STATES BY AVERAGE QUARTERLY GROWTH ---

USE phonepe;
WITH Quarterly AS (
    SELECT State, Year, Quarter, SUM(Count) AS Total_Transactions
    FROM aggregated_insurance
    GROUP BY State, Year, Quarter
)
SELECT State, ROUND(AVG(Total_Transactions),2) AS Average_Quarterly_Transactions
FROM Quarterly
GROUP BY State
ORDER BY Average_Quarterly_Transactions DESC
LIMIT 5;    