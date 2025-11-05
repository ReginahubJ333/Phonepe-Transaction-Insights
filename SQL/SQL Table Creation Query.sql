CREATE DATABASE Phonepe;
USE Phonepe;
--- VERIFIED THE LOADED DATA
SELECT * FROM phonepe.aggregated_insurance;
SELECT * FROM phonepe.aggregated_transaction;
SELECT * FROM phonepe.aggregated_user;
SELECT * FROM phonepe.map_transaction;
SELECT * FROM phonepe.top_transaction;

--- AGGREGATED INSURANCE
USE phonepe;
CREATE TABLE aggregated_insurance (
     State TEXT (50000),
     Year INT,
     Quarter INT,
     Category TEXT (50000),
     Count BIGINT,
	 Amount DECIMAL (20,2)
     );

--- AGGREGATED TRANSACTION
USE phonepe;
CREATE TABLE aggregated_transaction (
	State TEXT (50000),
    Year INT,
    Quarter INT,
    Category TEXT (50000),
    Count BIGINT,
    Amount DECIMAL (20,2)
    );

--- AGGREGATED USER
USE phonepe;
CREATE TABLE aggregated_user (
     State TEXT (50000),
     Year INT,
     Quarter INT,
     Category TEXT (50000),
     Count BIGINT,
     Registered_Users BIGINT,
     App_Opens BIGINT	
     );
     
--- MAP TRANSACTION
USE phonepe;
CREATE TABLE map_transaction (
     State TEXT (50000),
     District TEXT (50000),
     Year INT,
     Quarter INT,
     Count BIGINT,
     Amount DECIMAL (20,2)
     );
     
--- MAP USER
USE phonepe;
CREATE TABLE map_user (
     State TEXT (50000),
     Year INT,
     Quarter INT,
     Category TEXT (50000),
     Count BIGINT,
     Registered_Users BIGINT,
     App_Opens BIGINT
     );

--- TOP TRANSACTION
USE phonepe;
CREATE TABLE top_transaction (
    State TEXT (50000),
    Year INT,
    Quarter INT,
    Level TEXT (50000),
    Entity_Name TEXT (50000),
    Count BIGINT,
    Amount DECIMAL (20,2)
    );
    
--- TOP USER
USE phonepe;
CREATE TABLE top_user (
     State TEXT (50000),
     Year INT,
     Quarter INT,
     Category TEXT (50000),
     Count BIGINT,	
     Registered_Users BIGINT,
     App_Opens BIGINT
     );
    
--- CHECKING MISSING VALUES --- AGGREGATED_INSURANCE
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Category is NULL THEN 1 ELSE 0 END) AS missing_category,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Amount is NULL THEN 1 ELSE 0 END) AS missing_amount
FROM aggregated_insurance;   

--- CHECKING DUPLICATE RECORDS --- AGGREGATED INSURANCE
USE phonepe;
SELECT State, Year, Quarter, COUNT(*) AS duplicate_count
FROM aggregated_insurance
GROUP BY State, Year, Quarter
HAVING COUNT(*) > 1;
 
--- CHECKING MISSING VALUES --- AGGREGATED TRANSACTION
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Category is NULL THEN 1 ELSE 0 END) AS missing_category,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Amount is NULL THEN 1 ELSE 0 END) AS missing_amount
FROM aggregated_transaction; 

--- CHECKING MISSING VALUES --- AGGREGATED USER
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Category is NULL THEN 1 ELSE 0 END) AS missing_category,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Registered_Users is NULL THEN 1 ELSE 0 END) AS missing_registed_users,
      SUM(CASE WHEN App_Opens is NULL THEN 1 ELSE 0 END) AS missing_app_opens
FROM aggregated_user;      

--- CHECKING MISSING VALUES --- MAP TRANSACTION
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN District is NULL THEN 1 ELSE 0 END) AS missing_district,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Amount is NULL THEN 1 ELSE 0 END) AS missing_amount
FROM map_transaction;      

--- CHECKING MISSING VALUES --- MAP USER
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Category is NULL THEN 1 ELSE 0 END) AS missing_category,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Registered_Users is NULL THEN 1 ELSE 0 END) AS missing_registered_users,
      SUM(CASE WHEN App_Opens is NULL THEN 1 ELSE 0 END) AS missing_app_opens
      FROM map_user;      

--- CHECKING MISSING VALUES --- TOP TRANSACTION
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Level is NULL THEN 1 ELSE 0 END) AS missing_level,
      SUM(CASE WHEN Entity_Name is NULL THEN 1 ELSE 0 END) AS missing_entity_name,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Amount is NULL THEN 1 ELSE 0 END) AS missing_amount
FROM top_transaction; 

--- CHECKING MISSING VALUES --- TOP USER
USE phonepe;
SELECT
      SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS missing_state,
      SUM(CASE WHEN Year is NULL THEN 1 ELSE 0 END) AS missing_year,
      SUM(CASE WHEN Quarter is NULL THEN 1 ELSE 0 END) AS missing_quarter,
      SUM(CASE WHEN Category is NULL THEN 1 ELSE 0 END) AS missing_category,
      SUM(CASE WHEN Count is NULL THEN 1 ELSE 0 END) AS missing_count,
      SUM(CASE WHEN Registered_Users is NULL THEN 1 ELSE 0 END) AS missing_registered_users,
      SUM(CASE WHEN App_Opens is NULL THEN 1 ELSE 0 END) AS missing_app_opens
      FROM top_user;  
    
---- COMIBINED VIEW TRANSACTION SUMMARY --- AGGREGATED, MAP AND TOP
USE phonepe;
CREATE VIEW combined_transaction_summary AS
SELECT
      a.state,
      a.year,
      a.quarter,
      a.amount AS aggregated_amount,
      m.amount AS map_amount,
      t.amount AS top_amount,
      (a.amount - m.amount) AS diff_agg_map,
      (a.amount - t.amount) AS diff_agg_top
FROM aggregated_transaction a
JOIN map_transaction m
ON a.state = m.state AND a.year = m.year AND a.quarter = m.quarter
JOIN top_transaction t 
ON a.state = t.state AND a.year = t.year AND a.quarter = t.quarter; 

SELECT * FROM combined_transaction_summary;
   
--- COMBINED VIEW USER SUMMARY --- AGGREGATED, MAP AND TOP
USE phonepe;
CREATE VIEW combined_user_summary AS
SELECT
      a.state,
      a.year,
      a.quarter,
      a.registered_users AS aggregated_users,
      m.registered_users AS map_users,
      t.registered_users AS top_users,
      (a.registered_users - m.registered_users) AS diff_agg_map,
      (a.registered_users - t.registered_users) AS diff_agg_top
FROM aggregated_user a
JOIN map_user m
ON a.state = m.state AND a.year = m.year AND a.quarter = m.quarter
JOIN top_user t
ON a.state = t.state AND a.year = t.year AND a.quarter = t.quarter;    

SELECT * FROM combined_user_summary;  