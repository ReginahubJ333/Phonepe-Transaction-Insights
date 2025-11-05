--- CASE 4 --- DEVICE DOMINANCE AND USER ENGAGEMENT ANALYSIS ---

--- QUERY 1 ---
--- DEVICE POPULARITY BY STATE ---

USE phonepe;
SELECT State, Category, SUM(Count) AS Total_Users
FROM aggregated_User
GROUP BY State, Category
ORDER BY State, Total_Users DESC;

--- QUERY 2 ---
--- YEAR-WISE USER DISTRIBUTION BY CATEGORY ---

USE phonepe;
SELECT Year, Category, SUM(Count) AS Total_Users
FROM aggregated_User
GROUP BY Year, Category
ORDER BY Total_Users DESC;

	--- QUERY 3 ---
	--- LOW UTILIZED DEVICES ---

USE phonepe;
	SELECT Category, SUM(Count) AS Total_Activity
FROM aggregated_User
GROUP BY Category
	HAVING Total_Activity < (
		  SELECT AVG(Total_Activity)
		  FROM (SELECT SUM(Count) AS Total_Activity FROM aggregated_User GROUP BY Category) AS Average_Category
	)
	ORDER BY Total_Activity DESC;  

--- QUERY 4 ---
--- STATE-WISE ACTIVITY ---

USE phonepe;
SELECT State, SUM(Count) AS Total_Activity
FROM aggregated_User
GROUP By State
ORDER BY Total_Activity DESC;

--- QUERY 5 ---
--- QUARTERLY ACTIVITY ---

USE phonepe;
SELECT Year, Quarter, SUM(Count) AS Total_Activity
FROM aggregated_User
GROUP BY Year, Quarter
ORDER BY Year, Quarter;
