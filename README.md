# Telecom Customer Churn Analysis (End-to-End Portfolio Project)

## 📌 Project Overview
Customer retention is one of the primary revenue drivers in the telecommunications industry. This end-to-end data analytics project investigates customer demographics, account details, and service usage across **7,043 subscribers** to identify key churn drivers, quantify monthly revenue at risk, and recommend targeted retention strategies.

**Tech Stack:**
* **Data Cleaning & Preprocessing:** Python (`Pandas`, `NumPy`, `SQLAlchemy`)
* **Exploratory Data Analysis (EDA):** MySQL Workbench
* **Data Visualization & Reporting:** Microsoft Power BI

---

### Key Performance Indicators (KPIs)
* **Total Customers:** `7,043`
* **Overall Churn Rate:** `26.54%` (`1,869` churned customers)
* **Monthly Revenue at Risk:** `$139,131`

---

## 🗂️ Repository Structure
```text
telecom-customer-churn-analysis/
│
├── data/
│   ├── raw/
│   │   └── WA_Fn-UseC_-Telco-Customer-Churn.csv   # Original Kaggle dataset
│   └── processed/
│       └── telco_churn_cleaned.csv                # Cleaned dataset ready for SQL & Power BI
│
├── notebooks/
│   └── 01_data_cleaning.ipynb                     # Python script for data wrangling & validation
│
├── sql/
│   └── 02_exploratory_data_analysis.sql           # MySQL queries uncovering churn & revenue metrics
│
├── dashboard/
│   ├── telco_churn_dashboard.pbix                 # Interactive Power BI report file
│   └── dashboard_preview.png                      # High-resolution snapshot of the dashboard
│
└── README.md                                      # Project documentation & business recommendations
