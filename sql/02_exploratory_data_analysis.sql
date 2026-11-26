CREATE DATABASE churn_project;
USE churn_project;

SELECT * FROM churn_project.telco_churn_cleaned;

-- 1. OVERALL KPIs: Total Customers, Churned Count, Churn Rate %, & Revenue at Risk
SELECT 
    COUNT(*) AS total_customers,
    SUM(Churn_Numeric) AS churned_customers,
    ROUND(AVG(Churn_Numeric) * 100, 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS monthly_revenue_at_risk
FROM telco_churn_cleaned;


-- 2. CHURN RATE & REVENUE EXPOSURE BY CONTRACT TYPE
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(Churn_Numeric) AS churned_customers,
    ROUND(AVG(Churn_Numeric) * 100, 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS revenue_at_risk
FROM telco_churn_cleaned
GROUP BY Contract
ORDER BY churn_rate_pct DESC;


-- 3. EARLY ATTRITION ANALYSIS: CHURN RATE BY TENURE COHORT

-- 1. Add the new column to your table
ALTER TABLE telco_churn_cleaned ADD COLUMN Tenure_Cohort VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

-- 2. Populate the column based on customer tenure
UPDATE telco_churn_cleaned
SET Tenure_Cohort = CASE 
    WHEN tenure <= 12 THEN '0-12 Months'
    WHEN tenure <= 24 THEN '13-24 Months'
    WHEN tenure <= 48 THEN '25-48 Months'
    ELSE '48+ Months'
END;

SET SQL_SAFE_UPDATES = 1;

SELECT 
    Tenure_Cohort,
    COUNT(*) AS total_customers,
    SUM(Churn_Numeric) AS churned_customers,
    ROUND(AVG(Churn_Numeric) * 100, 2) AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM telco_churn_cleaned
GROUP BY Tenure_Cohort
ORDER BY churn_rate_pct DESC;


-- 4. SERVICE VULNERABILITY: CHURN RATE BY INTERNET SERVICE
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(Churn_Numeric) AS churned_customers,
    ROUND(AVG(Churn_Numeric) * 100, 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS revenue_at_risk
FROM telco_churn_cleaned
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;


-- 5. BILLING FRICTION: CHURN RATE BY PAYMENT METHOD
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(Churn_Numeric) AS churned_customers,
    ROUND(AVG(Churn_Numeric) * 100, 2) AS churn_rate_pct
FROM telco_churn_cleaned
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;


-- 6. HIGH-RISK COMPOUND SEGMENT (Month-to-Month + Fiber Optic + First Year)
SELECT 
    Contract,
    InternetService,
    Tenure_Cohort,
    COUNT(*) AS total_customers,
    SUM(Churn_Numeric) AS churned_customers,
    SUM(Churn_Numeric) AS churned_customers,
    ROUND(AVG(Churn_Numeric) * 100, 2) AS churn_rate_pct,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS revenue_at_risk
FROM telco_churn_cleaned
WHERE Contract = 'Month-to-month'
  AND InternetService = 'Fiber optic'
  AND Tenure_Cohort = '0-12 Months'
GROUP BY Contract, InternetService, Tenure_Cohort;