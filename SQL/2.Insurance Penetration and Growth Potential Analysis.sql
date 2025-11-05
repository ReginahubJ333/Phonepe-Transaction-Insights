--- CASE 2 --- INSURANCE PENETRATION AND GROWTH POTENTIAL ANALYSIS ---

--- QUERY 1 ---
--- TOP 5 STATES BY TOTAL POLICY COUNT ---

USE phonepe;
SELECT
      State, SUM(Count) AS Total_Policy
FROM aggregated_insurance
GROUP BY State
ORDER BY Total_Policy DESC
LIMIT 5;  

	--- QUERY 2 ---
	--- STATES WITH LOWEST INSURANCE ---

	USE phonepe;
	SELECT
		  State, SUM(Count) AS Total_Policy
	FROM aggregated_insurance
	GROUP BY State
	ORDER BY Total_Policy ASC
	LIMIT 5;   

--- QUERY 3 ---
--- STATE-WISE YEARLY INSURANCE POLICY DISTRIBUTION ANALYSIS ---

USE phonepe;
SELECT
     State, Year, SUM(Count) AS Total_Policy
FROM aggregated_insurance
GROUP BY State, Year
ORDER BY State, Total_Policy DESC;

--- QUERY 4 ---
--- IDENTIFYING LOW PENETRATION STATES ---

USE phonpe;
SELECT
      State, SUM(Count) AS Total_Policy
FROM aggregated_insurance
GROUP BY State
HAVING SUM(Count) < (SELECT AVG(Total_Policy)
     FROM (SELECT SUM(Count) AS Total_Policy FROM aggregated_insurance GROUP BY State) AS s
)
ORDER BY Total_Policy ASC; 

--- QUERY 5 ---
--- QUARTERLY TREND ANALYSIS ---

USE phonpe;
SELECT Year, Quarter, SUM(Count) AS Total_Policy
FROM aggregated_insurance
GROUP BY Year, Quarter
ORDER BY Year, Quarter;    
      