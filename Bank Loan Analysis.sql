use bank;
SELECT * FROM FINANCE_1;
SELECT * FROM FINANCE_2;

 ## Grade and sub grade wise revol_bal

select grade, sub_grade, sum(revol_bal) as total_revol_bal 
from finance_1 inner join finance_2 
on(finance_1.id = finance_2.id) 
group by grade, sub_grade 
order by grade, sub_grade;


## State wise and last_credit_pull_d wise loan status

select addr_State, last_Credit_pull_D, loan_Status
from finance_1 inner join finance_2
on (finance_1.id = finance_2.id)
group by addr_State, last_Credit_pull_D, loan_Status
order by last_Credit_pull_D;

## Home ownership Vs last payment date stats

select
home_ownership, last_pymnt_d
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by
home_ownership, last_pymnt_d
order by
home_ownership, last_pymnt_d ;

## Year wise loan amount Stats

SELECT 
		YEAR(LAST_CREDIT_PULL_D) AS YEAR, 
        SUM(LOAN_AMNT) AS TOTAL, 
        AVG(LOAN_AMNT) AS AVERAGE, 
        MAX(LOAN_AMNT) AS MAXIMUM, 
        MIN(LOAN_AMNT) AS MINIMUM 
FROM 
		FINANCE_1 AS F1 
JOIN 	
		FINANCE_2 AS F2 
ON 
		F1.ID=F2.ID 
GROUP BY 
		YEAR 
ORDER BY 
		YEAR;
        
        
## Total Payment for Verified Status Vs Total Payment for Non Verified Status

SELECT 
		VERIFICATION_STATUS, 
        concat(round(SUM(TOTAL_PYMNT)/1000000,3),"M") as TotalPayment, 
        concat(round(((SUM(TOTAL_PYMNT) / 
        (SELECT SUM(TOTAL_PYMNT) FROM FINANCE_2 AS F1 JOIN FINANCE_1 AS F2 ON F1.ID=F2.ID WHERE VERIFICATION_STATUS IN ("Verified","Not Verified")))*100),2),"%") as PercentageOfTotal
FROM 
		FINANCE_1 AS F1 
JOIN 	
		FINANCE_2 AS F2 
ON 	
		F1.ID=F2.ID
GROUP BY 
		VERIFICATION_STATUS 
HAVING 
		VERIFICATION_STATUS IN ("Verified","Not Verified");
