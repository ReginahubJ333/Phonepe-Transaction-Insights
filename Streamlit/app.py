import streamlit as st
import pandas as pd
import mysql.connector
import plotly.express as px 
import json
import requests

# MYSQL CONNECTION

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin",
    database="phonepe"
)
# STREAMLIT TITLE

st.set_page_config(page_title="Phonepe Dashboard", layout="wide")
st.title("PHONEPE TRANSACTION INSIGHTS DASHBOARD")

# SIDEBAR FOR NAVIGATION

menu = st.sidebar.radio("Select Dashboard Section:",
                        ["Dashboard Overview",
                        "1. Decoding Transaction Dynamics",
                        "2. Insurance Penetration and Growth",
                        "3. Market Expansion Analysis",
                        "4. Device Dominance and User Engagement",
                        "5. Insurance Transaction Analysis"])

# DASHBOARD OVERVIEW

if menu == ("Dashboard Overview"):
    st.header("Phonepe Dashboard Overview") 
    st.markdown("""
    1 **Decoding Transaction Dynamics** Trends, growth, and performance across states.  
    2 **Insurance Penetration & Growth** Regional adoption and potential areas.  
    3 **Market Expansion Analysis** Transaction patterns and new opportunities.  
    4 **Device Dominance & User Engagement** Brand preferences and usage insights.  
    5 **Insurance Transaction Analysis** Deep dive into insurance transactions by type and value.
     """)
   
# CASE 1: DECODING TRANSACTION DYNAMICS
elif menu == "1. Decoding Transaction Dynamics":
    st.header("Case 1: Decoding Transaction Dynamics")
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Admin",
        database="phonepe"
    )
    
    states = pd.read_sql("SELECT DISTINCT State FROM aggregated_transaction;", conn)
    years = pd.read_sql("SELECT DISTINCT Year FROM aggregated_transaction ORDER BY Year;", conn)

    selected_state = st.sidebar.selectbox(" Choose State:", ["All States"] + list(states["State"]))
    selected_year = st.sidebar.selectbox(" Choose Year:", ["All Years"] + list(years["Year"]))

    query1 = """
    SELECT State, Year, Quarter, Category, SUM(Count) AS Total_Transactions, SUM(Amount) AS Total_Amount
    FROM aggregated_transaction
    GROUP BY State, Year, Quarter, Category;
    """
    df = pd.read_sql(query1, conn)
    conn.close()

    if selected_state != "All States":
        df = df[df["State"] == selected_state]
    if selected_year != "All Years":
        df = df[df["Year"] == selected_year] 
    # LINE CHART: TRANSACTION TREND

    fig1 = px.bar(df, x="Quarter", y="Total_Amount", color="Category", barmode="group", title=f"Transaction Trend for {selected_state if selected_state!='All States' else 'All India'}", text_auto=".2s")
    st.plotly_chart(fig1, use_container_width=True)

    # BAR CHART: TOP STATES

    df_state = df.groupby("State", as_index=False)["Total_Amount"].sum().sort_values(by="Total_Amount", ascending=False)

    fig2 = px.bar(df_state.head(10), x="State", y="Total_Amount", color="Total_Amount", color_continuous_scale="viridis", title=" Top 10 States by Total Transaction Value")
    st.plotly_chart(fig2, use_container_width=True)

    st.markdown("""
                **Insights:**
                - Southern states like Andhra Pradesh, Telangana, and Karnataka lead transaction volumes.  
                - Consistent year-on-year growth shows India's increasing digital payment adoption.  
                - Peer-to-peer and merchant payments are dominant across states.
                """)

# CASE 2: INSURANCE PENETRATION AND GROWTH

elif menu == "2. Insurance Penetration and Growth":
    st.header("Case 2: Insurance Penetration and Growth Potential Analysis")
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Admin",
        database="phonepe"
    )

    query2 = """
    SELECT State, Year, SUM(Count) AS Total_Policies
    FROM aggregated_insurance
    GROUP BY State, Year;
    """
    df_ins = pd.read_sql(query2, conn)
    conn.close()
    df_ins["Total_Policy"] = pd.to_numeric(df_ins["Total_Policies"], errors="coerce")
    years = sorted(df_ins["Year"].unique())
    selected_year = st.sidebar.selectbox("Select Year:", years)

    df_filtered = df_ins[df_ins["Year"] == selected_year]
           
# HORIZONTAL BAR CHART
    st.subheader(f"Insurance Policies By States {selected_year}") 
    fig_bar = px.bar(df_filtered.sort_values("Total_Policies", ascending=True), x="Total_Policies", y="State", orientation="h", color="Total_Policies", color_continuous_scale="Viridis", title=f"Insurance Policy Distribution By States - {selected_year}", labels={"Total_Policies": "Total Policies Issued", "State": "State"})
    fig_bar.update_layout(xaxis_title="Total Policies", yaxis_title="State",height=800)
    st.plotly_chart(fig_bar, use_container_width=True)

# LINE CHART: MULTI-YEAR LINE CHART (TOP STATES)
    st.subheader("Yearly Growth Trend (Top 5 States)") 
    top_states = df_ins.groupby("State")["Total_Policies"].sum().nlargest(5).index
    df_top = df_ins[df_ins["State"].isin(top_states)]
    fig_line = px.line(df_ins, x="Year", y="Total_Policies", color="State", markers=True, title="Top 5 States By Insurance Policy Growth (2018-2024)")
    st.plotly_chart(fig_line, use_container_width=True)
     
    st.markdown("""
    **Insights:**
    - In **{selected_year}**, Karnataka, Maharashtra, and Tamil Nadu lead in total insurance policies, confirming high penetration in digitally mature regions.     
    - The horizontal bar chart highlights clear state-wise differences, while the line chart shows consistent multi-year growth patterns among the top performers.  
    """)

# CASE 3: MARKET EXPANSION ANALYSIS

elif menu == "3. Market Expansion Analysis":
    st.header(" Case 3: Market Expansion Analysis")
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Admin",
        database="phonepe")

    query3 = """
    SELECT State, Year, SUM(Count) AS Current_Year_Transaction,
     LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year) AS Previous_Year_Transaction,
     ROUND(((SUM(Count) - LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year))
          / LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year)) * 100, 2) AS Growth_Percentage
    FROM map_transaction
    GROUP BY State, Year
    ORDER BY State, Year;
    """
    df_growth = pd.read_sql(query3, conn)
    conn.close()

    df_growth = df_growth.dropna(subset=["Growth_Percentage"])
    
    selected_year = st.sidebar.selectbox("Select Year:", sorted(df_growth["Year"].unique()))
    df_selected = df_growth[df_growth["Year"] == selected_year]

    url = "https://raw.githubusercontent.com/geohacker/india/master/state/india_telengana.geojson"
    india_states = requests.get(url).json()

    # INDIA MAP   
    fig_map = px.choropleth(
        df_selected,
        geojson=india_states,
        featureidkey="properties.NAME_1",
        locations="State",
        color="Growth_Percentage",
        color_continuous_scale="RdYlGn",
        title=f"Growth Percentage by State - ({selected_year})"
    )
    fig_map.update_geos(
        fitbounds="locations",
        visible=False)
    st.plotly_chart(fig_map, use_container_width=True)
        
    st.markdown(f"""
    **Insights:** {selected_year}
        - Green regions indicate strong market growth, signaling higher transaction expansion.  
        - Red/Brown regions highlight slower or negative growth, requiring strategic focus.  
        - States like Karnataka, Maharashtra, and Uttar Pradesh consistently show high transaction volumes and stable growth.  
        """)

# CASE4: DEVICE DOMINANCE AND USER ENGAGEMENT

elif menu == "4. Device Dominance and User Engagement":
    st.header("Case 4: Device Dominance and User engagement")
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Admin",
        database="phonepe"
    )
    query4 = """
            SELECT State, Category AS Brand, SUM(Count) AS Total_Users
            FROM aggregated_User
            GROUP BY State, Category
            ORDER BY State, Total_Users DESC;
            """
    df_device = pd.read_sql(query4, conn)
    conn.close()

    df_device = df_device[df_device["Brand"] != "Nill"]
    df_device = df_device[df_device["Total_Users"] > 0]

    selected_state = st.sidebar.selectbox("Select State:", sorted(df_device["State"].unique()))
    df_state = df_device[df_device["State"] == selected_state]

# PIE CHART
    st.subheader("Device Brand Share in {selected_state}")
    fig_pie = px.pie(df_state, names="Brand", values="Total_Users", title=f"Device Brand Share - {selected_state}", hole=0.4, color_discrete_sequence=px.colors.qualitative.Set3)
    config = {"displayModeBar": False, "responsive": True}    
    st.plotly_chart(fig_pie, config=config)

    st.markdown("""
            **Insights:**
            - The pie chart shows which mobile brands dominate PhonePe usage in this state.
            - Xiaomi, Samsung, and Vivo often lead in user count.
            - Apple and OnePlus have a stronger share in metro or high-income regions.
            - Helps identify user engagement patterns based on device brand preference.
        """)

# CASE 5: INSURANCE TRANSACTION ANALYSIS

elif menu == "5. Insurance Transaction Analysis":
    st.header("Case 5: Insurance Transaction Analysis")

    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Admin",
        database="phonepe"
    )
    query5 = """
    SELECT State, Year, SUM(Count) AS Total_Transactions,
          LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year) AS Previous_Year,
          ROUND(
          ((SUM(Count)-LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year))
          /LAG(SUM(Count)) OVER (PARTITION BY State ORDER BY Year) * 100),
          2
        ) AS Growth_Percentage  
    FROM aggregated_insurance
    GROUP BY State, Year
    ORDER BY Growth_Percentage DESC
    LIMIT 5;
    """
    df_growth = pd.read_sql(query5, conn)

    if conn.is_connected():
        conn.close()
    df_growth = df_growth.dropna(subset=["Growth_Percentage"])

    fig5 = px.bar(df_growth, x="State", y="Growth_Percentage", color="Growth_Percentage", text="Growth_Percentage", color_continuous_scale="Viridis", title="Top 5 States With Highest Grwoth In Transaction In A Year")
    fig5.update_traces(texttemplate='%{text:.2f}%', textposition='outside')
    fig5.update_layout(yaxis_title="Growth_Percentage (%)", xaxis_title="State")

    st.plotly_chart(fig5, use_container_width=True)

    st.markdown("""
                **Insights**:
        - Lakshadweep (875%) and Andaman & Nicobar Islands (688.9%) lead with the sharpest insurance adoption jumps, driven by digital outreach in small populations.  
        - Northern territories like Jammu & Kashmir and Ladakh follow closely, showing increasing integration of insurance into financial habits.  
        - Kerala (325%) reflects strong policyholder expansion, signaling regional trust in digital insurance systems.  
        - The data highlights untapped growth opportunities in smaller or previously underrepresented regions.
    """)

   




         
    

