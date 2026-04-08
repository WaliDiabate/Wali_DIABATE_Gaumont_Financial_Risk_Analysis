# Wali_DIABATE_Gaumont_Financial_Risk_Analysis
Gaumont Financial Risk Analysis Designing a Relational Database (SGBD) to track film ROI (vue SQL). By structuring data on budgets, talent "bankability," and weekly box-office, we provide a Decision Support Tool to analyze project-based financing and production risks. A clean data foundation for future predictive modeling by Wali DIABATE
# Gaumont: Financial Risk & ROI Analysis

## 1. Project Overview
This project focuses on the financial ecosystem of **Gaumont**, a global leader in film production and distribution. In the cinema industry, every movie is a **standalone investment** with a high-risk profile. Our goal is to design a **Decision Support System (DSS)** based on a relational database to track and manage the financial performance of these assets.

## 2. Problem Statement
Gaumont manages a massive catalog of films, yet financial data is often fragmented. 
**The challenge:** How to structure heterogeneous data (budgets, talent influence, and weekly box-office) into a unified system to calculate the **Return on Investment (ROI)** and assess financial risks linked to talent dependency and market timing.

## 3. Database Architecture (SGBD)
To ensure data integrity, we have designed a **Relational Schema** that captures the complexity of the film industry:
* **Films Table:** Centralizes budgets, genres, and release dates.
* **People Table:** Tracks directors and cast to measure "bankability."
* **Financing Table:** Details funding sources (CNC, subsidies, equity).
* **Weekly_Entries Table:** Time-series data to track box-office performance week by week.

*Note: The ROI is calculated as a **SQL View**, ensuring real-time financial KPIs without data redundancy.*

## 4. Finality & M2 Perspectives
The primary goal is to provide a decision-making tool for Gaumont's financial department. While the M1 focuses on **Data Engineering** and **SGBD structure**, this clean dataset will serve as a foundation for **Predictive Machine Learning models** in Master 2.

## 5. Tech Stack
* **Language:** SQL, Python
* **Database:** SQLite / PostgreSQL
* **Libraries:** Pandas, Matplotlib (for data visualization)
* **License:** MIT
