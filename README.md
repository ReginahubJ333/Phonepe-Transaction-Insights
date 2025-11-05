# 📊 PhonePe Transaction Insights Dashboard

### 🚀 Comprehensive Data Analysis & Visualization using SQL, Python, and Streamlit

This project presents an **end-to-end analytical dashboard** of PhonePe’s digital transaction data from raw SQL data extraction to interactive visualization focusing on 5 major business cases that reveal transaction dynamics, insurance trends, user engagement, and market growth.

## 🧠 Project Overview

**Objective:**  
To analyze and visualize digital payment and user behaviour data from the PhonePe Pulse dataset to uncover regional trends, user patterns, and growth opportunities across India.

**Tools & Technologies:**
- 🐬 MySQL — Data storage and SQL-based analysis (25 queries total)
- 🐍 Python — Data manipulation (Pandas)
- 📊 Plotly — Interactive charts (bar, pie, line, treemap, sunburst)
- 🌐 Streamlit — Dynamic, user-friendly dashboard
- 🧱 VS Code — Development environment

## **Business Cases Covered:**

### **1️ Decoding Transaction Dynamics**
- SQL Queries: 5
- Focus: Transaction trends, state-wise volume, top-performing categories.
- Key Charts:
  - Bar Chart — Top 5 performing states by transaction volume  
  - Pie Chart — Distribution by transaction category  
  - Line Chart — Quarterly transaction trend  
- Insight:
  > Maharashtra, Karnataka, and Bihar lead in total transaction amounts.  
  > Peer-to-Peer payments dominate overall digital transactions.

### **2️ Insurance Penetration and Growth Potential**
- SQL Queries: 5
- Focus: Growth of insurance policy transactions across states and years.
- Key Charts:
  - Choropleth Map — Insurance policy distribution by state  
  - Horizontal Bar Chart — Year-wise top performing states  
- Insight:
  > Karnataka, Andhra Pradesh, and Tamil Nadu show the highest policy penetration.  
  > Northeastern regions indicate untapped market opportunities.

### **3️ Market Expansion Analysis**
- SQL Queries: 5  
- Focus: Year-on-year transaction growth trends across states.  
- Key Charts:
  - Treemap — Transaction growth across states and years  
  - Bubble Chart — Growth % vs Total Transactions  
- Insight:
  > Rapid growth seen in smaller states like Ladakh and Arunachal Pradesh.  
  > Karnataka and Maharashtra maintain consistent large-scale growth.

### **4️ Device Dominance and User Engagement**
- SQL Queries: 5  
- Focus: User base distribution by smartphone brand and state.  
- Key Charts:
  - Sunburst Chart — Device brand dominance across states  
  - Stacked Bar Chart — Top brands by total users  
- Insight:
  > Xiaomi, Samsung, and Vivo dominate across most states.  
  > Apple and OnePlus show strong urban concentration (Delhi, Karnataka).

### **5️ Insurance Transaction Analysis**
- SQL Queries: 5  
- Focus: State-wise and category-wise insurance transaction performance.  
- Key Charts:
  - Histogram — Lowest performing states  
  - Choropleth — Regional performance comparison  
- Insight:
  > Lakshadweep, Andaman & Nicobar, and J&K exhibit the highest growth percentages year-over-year, though from smaller bases.

## 🧾 SQL Workflow Summary

A total of **25 SQL queries** were executed — 5 per business case — covering:
- Aggregations (`SUM`, `AVG`, `LAG`, `ROUND`)
- Window functions for YoY growth
- Grouping and ranking
- State, Year, Quarter, and Category-based analysis

## 🖥️ Streamlit Dashboard Overview

**Dashboard Features:**
✅ Sidebar navigation for 5 business cases  
✅ Dynamic chart selection (line, bar, treemap, sunburst)  
✅ Real-time SQL integration using `mysql.connector`  
✅ Clean, responsive UI with interactive tooltips and hover data  

## **Run the Dashboard:**
streamlit run app.py

## **Dashboard Sections**:

Case 1: Transaction Dynamics
Case 2: Insurance Penetration
Case 3: Market Expansion
Case 4: Device Dominance
Case 5: Insurance Transactions

## 🧩 **Folder Structure**

PhonePe_Transaction_Insights/
│
├── app.py                     # Streamlit Dashboard
├── 1.Decoding_Transaction_Dynamics.sql
├── 2.Insurance_Penetration.sql
├── 3.Market_Expansion.sql
├── 4.Device_Dominance.sql
├── 5.Insurance_Transactions.sql
├── requirements.txt
└── README.md

## **Steps Followed**:

✅ Data Extraction: Pulled raw PhonePe data into MySQL
✅ Data Cleaning: Removed nulls, handled duplicates, standardized state names
✅ Query Development: Designed 25 analytical SQL queries
✅ Visualization: Built multiple charts using Plotly
✅ Dashboard Creation: Integrated visuals into Streamlit app
✅ Insights & Reporting: Compiled key findings in PPT & README

## 🧠 **Key Insights Summary**

✅	Digital Payments Growth: Exponential YoY increase across most states.
✅ Regional Trends: Southern and Western states dominate in both volume and user base.
✅ Insurance Uptake: Strong in high-income states, low in rural North-East.
✅ Device Engagement: Affordable Android brands drive rural adoption.
✅ Market Potential: Smaller states exhibit massive growth potential for fintech expansion.

## 🧰 Tech Stack

| **Component**   | **Technology Used**        |
|-----------------|----------------------------|
| Database        | MySQL                      |
| Data Analysis   | SQL, Pandas                |
| Visualization   | Plotly Express             |
| Dashboard       | Streamlit                  |
| Environment     | VS Code                    |
| Reporting       | Google Slides / PowerPoint |


## 🏁 **Conclusion**

This project delivers a complete data-to-insight pipeline:
**Raw data → SQL insights → Visual analytics → Streamlit dashboard → Business recommendations**.
The findings highlight India’s rapid digital payment adoption, insurance penetration potential, and device-driven engagement, empowering financial inclusion strategies.