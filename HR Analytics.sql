USE PROJECT_HR;
SHOW DATABASES;
SHOW TABLES;
SELECT * FROM HR_1;
SELECT * FROM HR_2;

DESC HR_1;
DESC HR_2;

SELECT COUNT(*) FROM HR_1;
SELECT COUNT(*) FROM HR_2;

-- AVERAGE ATTRITION RATE FOR ALL DEPARTMENT

WITH SAMPLE AS (SELECT DEPARTMENT,COUNT(*) AS ATTRITIONCOUNT FROM HR_1 WHERE ATTRITION= "YES" GROUP BY DEPARTMENT),
	 SAMPLE1 AS (SELECT DEPARTMENT,COUNT(*) AS FULLCOUNT FROM HR_1 GROUP BY DEPARTMENT)
     SELECT S.DEPARTMENT,CONCAT(ROUND(ATTRITIONCOUNT/FULLCOUNT*100,2),"%") AS ATTRITION_RATE FROM SAMPLE1 AS S1 INNER JOIN SAMPLE AS S ON S.DEPARTMENT=S1.DEPARTMENT GROUP BY DEPARTMENT;
     
 -- ALTERNATIVE METHOD 

SELECT DEPARTMENT,CONCAT(ROUND(SUM(CASE ATTRITION WHEN "YES" THEN 1 ELSE 0 END)/COUNT(EMPLOYEENUMBER)*100,2),"%") FROM HR_1 GROUP BY DEPARTMENT;


-- AVERAGE HOURLY RATE OF MALE RESEARCH SCIENTIST
SELECT * FROM HR_1;
SELECT AVG(HOURLYRATE) AS AVG_HOURLY_RATE FROM HR_1 WHERE JOBROLE="RESEARCH SCIENTIST" AND GENDER = "MALE";



-- ATTRITION RATE VS MONTHLY INCOME STATUS

SELECT CONCAT(FLOOR(MONTHLYINCOME/10000)*10,"K","-",(FLOOR(MONTHLYINCOME/10000)*10)+10,"K") AS INCOME_BIN, 
SUM(
CASE ATTRITION WHEN "YES"THEN 1 ELSE 0 
END
)
/
COUNT(EMPLOYEECOUNT)*100 AS ATR_RATE FROM HR_1 INNER JOIN HR_2 ON HR_1.EMPLOYEENUMBER=HR_2.`Employee ID` GROUP BY INCOME_BIN ORDER BY INCOME_BIN;



-- AVERAGE WORKING YEARS FOR ALL DEPARTMENT 

SELECT * FROM HR_1;
SELECT * FROM HR_2;
SELECT  DEPARTMENT, AVG(TOTALWORKINGYEARS) AS AVG_WORKING_YEARS FROM HR_1 INNER JOIN HR_2 ON `Employee ID` = EMPLOYEENUMBER GROUP BY DEPARTMENT;




-- JOB ROLE VS WORK LIFE BALANCE

SELECT JOBROLE,AVG(WORKLIFEBALANCE) AS WORK_LIFE_BALANCE FROM HR_1 INNER JOIN HR_2 ON `Employee ID` = EMPLOYEENUMBER GROUP BY JOBROLE;



-- ATTRITION RATE VS YEAR SINCE LAST PROMOTION

SELECT * FROM HR_2;

SELECT DISTINCT YEARSSINCELASTPROMOTION, SUM(CASE ATTRITION  WHEN  "YES" THEN 1 ELSE 0 END)/COUNT(EMPLOYEECOUNT)*100  AS ATR_RATE FROM HR_1 JOIN HR_2 ON HR_1.EMPLOYEENUMBER = HR_2.`Employee ID` GROUP BY YEARSSINCELASTPROMOTION ORDER BY YEARSSINCELASTPROMOTION;	