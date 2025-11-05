
import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px
print(" All libraries loaded sucessfully!")

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin",
    database="phonepe"
)
if conn.is_connected():
    print("connected to MYSQL successfully")

# TRANSACTION TRENDS BY STATE

query1 = """
SELECT State, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY State
ORDER BY Total_Amount DESC
LIMIT 5;
"""
df = pd.read_sql(query1,conn)
conn.close()
print(df)

plt.figure(figsize=(10,6))
plt.bar(df['State'], df['Total_Amount']/1e12, color='teal')
plt.title("State-Level Performance: Total Transaction Amount On Phonepe (Trillions)")
plt.xlabel("State")
plt.ylabel("Total Transaction Amount (Trillion)")
plt.xticks(rotation=30)
plt.tight_layout()
plt.show()

# QUARTERLY GROWTH

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin",
    database="phonepe")

query2 = """
SELECT Year, Quarter, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY Year, Quarter
ORDER BY Year, Quarter DESC;
"""

df = pd.read_sql(query2, conn)
conn.close()

df["Year_Quarter"] = df["Year"].astype(str) + "Q" + df["Quarter"].astype(str)

plt.figure(figsize=(12,6))
plt.plot(df["Year_Quarter"], df["Total_Transactions"]/1e9, marker="o", label="Transactions (in Billions)")
plt.plot(df["Year_Quarter"], df["Total_Amount"]/1e12, marker="s", label="Amount (in Trillions)")

plt.title("Quarterly Growth Trend (2018-2024)", fontsize=14, weight="bold")
plt.xlabel("Year-Quarter")
plt.ylabel("Value")
plt.legend()
plt.grid(alpha=0.3)
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# TOP PERFORMING CATEGORIES

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin",
    database="phonepe"
)
if conn.is_connected():
    print("connected to MYSQL successfully")

query3 = """
SELECT Category, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
FROM aggregated_transaction
GROUP BY Category
ORDER BY Total_Amount DESC;
"""

df = pd.read_sql(query3, conn)
conn.close()
print(df.head())

plt.figure(figsize=(10,6))
plt.barh(df['Category'], df['Total_Amount']/1e12, color='teal')
plt.title("Top Performing Categories On Phonepe (Trillions)")
plt.xlabel("Total Transaction Amount (Trillion)")
plt.ylabel("Category")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()

# HIGH AND LOW PERFORMING STATES

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin",
    database="phonepe")

query4 = """
WITH HIGH AS (
SELECT State, 
     SUM(Amount) AS Total_Amount, 'High Performing' AS Performance_Category
FROM aggregated_transaction
GROUP BY State
HAVING SUM(Amount) > (SELECT AVG(Amount) FROM aggregated_transaction)
ORDER BY Total_Amount DESC
LIMIT 5
),
LOW AS (
SELECT
	State, SUM(Amount) AS Total_Amount, 'Low Performing' AS Performance_Category
FROM aggregated_transaction
GROUP BY State
HAVING SUM(Amount) < (SELECT AVG(Amount) FROM aggregated_transaction)
ORDER BY Total_Amount ASC
LIMIT 10
)
SELECT * FROM HIGH
UNION ALL
SELECT * FROM LOW;
"""

df = pd.read_sql(query4, conn)
conn.close()

df = df.sort_values(by="Total_Amount", ascending=False)
plt.figure(figsize=(10,6))
colors = df["Performance_Category"].map({"High Performing": "#2ca02c", "Low Performing": "#d62728"})
plt.barh(df["State"], df["Total_Amount"], color=colors)
plt.xscale("log")
plt.xlabel("Total Transaction Amount (Log Scale)")
plt.title("High vs Low Performing States (Logarithmic View)")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()

# DISTRICT LEVEL HIGH PERFORMING

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin",
    database="phonepe")

query5 = """
SELECT State, District, SUM(Amount) AS Total_Amount
FROM map_transaction
GROUP BY State, District
ORDER BY State, Total_Amount DESC
LIMIT 10;
"""

df = pd.read_sql(query5, conn)
conn.close()

df["Total_Amount_Cr"] = df["Total_Amount"]/1e7
df = df.nlargest(10, "Total_Amount_Cr").sort_values("Total_Amount_Cr", ascending=True)

fig = px.bar(
    df,
    x="Total_Amount_Cr",
    y="District",
    color="State",
    orientation="h",
    title="Top 10 High Performing Districts by Total Transaction Amount",
    text_auto='.2s'
    )
fig.update_layout(
    xaxis_title="Total Transaction Amount (Crores)",
    yaxis_title="District",
    showlegend=True,
    template="plotly_white")
fig.show()