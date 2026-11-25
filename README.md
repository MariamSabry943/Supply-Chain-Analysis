# Supply Chain Analysis

End-to-end supply chain analytics project covering order performance, customer and product profiles, sales representatives, and delivery operations using SQL and Power BI.

## Data Pipeline & Architecture
- **Bronze Layer:** Raw source tables (`Customers`, `Products`, `Salesman`, `Orders`) loaded into the `SupplyChain` database.
- **Silver Layer:** Data cleansing and standardization in T-SQL using `TRY_CAST`, string trimming/casing normalization, duplicate handling (`ROW_NUMBER`), `NULL` handling (`COALESCE` / fallback values), calculated fields (`Age`, `Years_In_Company`), and primary keys.
- **Gold Layer:** Analytical/reporting layer built from the cleaned Silver data to power BI reporting—structured for analytical querying and connected directly to **Power BI** for interactive dashboards, DAX measures, and KPI tracking.

## Tech Stack
- **SQL (T-SQL / SQL Server):** Data cleaning, transformation, and Gold layer preparation for analytics.
- **Power BI:** Connected to the Gold layer for interactive reporting, DAX calculations, and visual storytelling.

## Repository Contents
- SQL scripts for data cleaning and Gold layer preparation.
- Power BI report file (`.pbix`) and dashboard visuals.
- `README.md` for project overview and documentation.

  ## Key Insights

- **$33.05M** total revenue and **$3.97M** total profit (**12%** profit margin).
- **181K** orders and **21K** customers.
- **Customers & Markets:** **Consumer** leads with **51.79%** (**11K** customers) , with **$3.73M** in total discounts and **$183.11** average order value.
- **118** products, **603** salesmen, and **384K** units sold.
- **Shipping & Delays:** **54.83%** late delivery rate (**99K** late vs. **82K** on-time, **0.57** average shipping delay).

## Recommendations

- Review **Standard Class** shipping operations and **September** delay spikes to lower the **54.83%** late delivery rate and support year-end sales.
- Re-evaluate discounts (**$3.73M**) and focus on high-profit categories and products (like **Fishing**).


