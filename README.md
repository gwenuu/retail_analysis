# Online Retail Sales Analysis

## Overview

A data analysis project using real transaction data from the UCI Online Retail dataset (2010–2011).

The goal is to explore sales performance, revenue trends, and customer purchasing behavior using Python and SQL.

## Tools

- **Python (pandas)** — data cleaning and preparation
- **PostgreSQL** — data storage and SQL analysis
- **pgAdmin** — running and testing SQL queries
- **Tableau Public** — data visualization

## Dataset

The dataset contains 541,909 transaction line items from a UK-based online retailer, covering December 2010 to December 2011.

It includes invoice numbers, product descriptions, quantities, prices, customer IDs, transaction dates, and countries.

Source: [UCI Machine Learning Repository — Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)

## Data Cleaning

I used pandas to check the dataset for missing values, duplicate rows, cancelled invoices, negative quantities, and invalid prices.

The initial checks found:

- 135,080 rows with missing customer IDs
- 5,268 duplicate rows
- 10,624 rows with negative quantities
- 2,517 rows with zero or negative prices

For the sales analysis, I excluded cancelled invoices, nonpositive quantities and prices, and invalid dates.

I kept rows with missing customer IDs because they can still contribute to total revenue. Duplicate rows were also retained because identical records aren't necessarily data errors.

The prepared dataset was saved as `cleaned_retail.csv` and imported into PostgreSQL.

## SQL Analysis

Using PostgreSQL, I analyzed:

- Total revenue, orders, and customers
- Monthly revenue trends
- Top products by revenue
- Revenue by country
- Highest-spending customers
- Repeat customers and purchase frequency
- Average order value

The queries use SQL operations including `GROUP BY`, `SUM`, `COUNT`, `HAVING`, and Common Table Expressions (CTEs).

## Key Findings

**1. Revenue is concentrated in the United Kingdom**

The UK generated approximately £9.03 million in positive-sales revenue, far more than any other country. The Netherlands and Ireland were among the largest markets outside the UK.

**2. Sales increased toward the end of 2011**

Monthly revenue increased significantly during the later months of 2011, with November showing the highest revenue among the complete months. This may be related to seasonal shopping demand, although the data alone cannot establish the cause.

**3. Missing customer information affects customer analysis**

Almost 25% of the original transaction lines have no customer ID. These records can contribute to revenue calculations, but they cannot reliably be used for customer-level purchase frequency or repeat-customer analysis.

**4. Product rankings require careful interpretation**

Some transaction descriptions represent charges such as postage rather than physical products. These should be treated separately when interpreting the best-selling products.

## Visualizations

### Monthly Revenue Trend

Monthly sales revenue from December 2010 to December 2011.

![Monthly Revenue](<visualizations/Monthly Revenue Trend _ 2010–2011.png>)

### Revenue by Country

Top ten countries by positive-sales revenue.

![Revenue by Country](<visualizations/Revenue by Country _ 2010–2011.png>)

Both visualizations were created using Tableau Public from SQL query results.

## Project Structure

```text
retail_analysis/
├── data/
│   ├── online_retail.csv
│   └── cleaned_retail.csv
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_sales_analysis.sql
│   └── 03_customer_analysis.sql
├── visualizations/
│   ├── Monthly Revenue Trend _ 2010–2011.png
│   └── Revenue by Country _ 2010–2011.png
├── clean_data.py
└── README.md
```

## How to Run

The project requires Python, pandas, and PostgreSQL.

**1. Clone the repository**

```bash
git clone https://github.com/gwenuu/retail_analysis.git
cd retail_analysis/retail_analysis
```

**2. Install pandas and prepare the data**

```bash
python3 -m pip install pandas
python3 clean_data.py
```

This generates `data/cleaned_retail.csv`.

**3. Create a PostgreSQL database**

```bash
createdb online_retail_project
```

This step is only needed the first time.

**4. Create the sales table**

```bash
psql -d online_retail_project -f sql/01_create_table.sql
```

**5. Import the cleaned dataset**

```bash
psql -d online_retail_project -c "\copy sales FROM 'data/cleaned_retail.csv' WITH (FORMAT csv, HEADER true)"
```

**6. Run the SQL analysis**

```bash
psql -d online_retail_project -f sql/02_sales_analysis.sql
psql -d online_retail_project -f sql/03_customer_analysis.sql
```

The SQL files can also be opened and executed individually in pgAdmin.

## Limitations

- The analysis focuses on positive sales and doesn't account for subsequent returns or cancellations when calculating net revenue.
- Missing customer IDs limit customer-level analysis.
- Duplicate rows were not automatically removed.
- December 2010 and December 2011 are incomplete months, so their revenue shouldn't be directly compared with full months.
- Revenue is not the same as profit; the dataset does not include product costs.

## Data Source

Chen, D. (2015). *Online Retail*. UCI Machine Learning Repository.

https://doi.org/10.24432/C5BW33

