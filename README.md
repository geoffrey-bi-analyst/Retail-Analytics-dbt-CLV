\# Retail Analytics dbt Project



\## Overview

This project implements a complete analytics pipeline for retail sales data, including Customer Lifetime Value (CLV) modeling using dbt on BigQuery.



\## Project Structure

retail\_analytics/

├── models/

│ ├── staging/ # Raw data cleaning (4 models)

│ ├── marts/

│ │ ├── core/ # Dimension and fact tables (4 models)

│ │ └── analytics/ # CLV analysis (1 model)

├── tests/ # Data quality tests (custom SQL)

├── docs/ # Auto-generated documentation

└── analyses/ # Ad-hoc analysis SQL



text



\## Key Features



\### Data Quality

\- 60+ automated tests (uniqueness, not-null, referential integrity, range checks)

\- Custom business rule validation

\- dbt\_utils package for advanced testing



\### Customer Lifetime Value (CLV)

\- RFM segmentation (Recency, Frequency, Monetary)

\- 12-month CLV prediction

\- Customer health scoring (0-100)

\- Segment-based insights (Champion, Loyal, Potential, At Risk, Churned)



\### Documentation

\- Auto-generated dbt docs with lineage graph

\- Column-level descriptions

\- Source table definitions



\## Models Summary



| Layer | Model | Description |

|-------|-------|-------------|

| Staging | stg\_stores | Cleaned store dimension |

| Staging | stg\_products | Cleaned product dimension with margin |

| Staging | stg\_sales | Cleaned sales fact table |

| Staging | stg\_customers | Unique customer extraction |

| Core | dim\_stores | Store dimension (star schema) |

| Core | dim\_products | Product dimension (star schema) |

| Core | dim\_customers | Customer dimension with CLV metrics |

| Core | fact\_sales | Sales fact table |

| Analytics | customer\_clv | RFM analysis + CLV predictions |



\## Setup Instructions



\### Prerequisites

\- Python 3.12

\- dbt-core and dbt-bigquery

\- Google Cloud Project with BigQuery enabled



\### Installation



```bash

\# Clone repository

git clone https://github.com/yourusername/retail\_analytics\_dbt.git

cd retail\_analytics\_dbt



\# Install dependencies

pip install dbt-core dbt-bigquery

dbt deps



\# Configure connection

\# Add your service account key to project root

\# Update profiles.yml with keyfile path



\# Run models

dbt run



\# Test data quality

dbt test



\# Generate documentation

dbt docs generate

dbt docs serve

Key SQL Techniques Demonstrated

Window functions (RFM analysis)



CTEs for modular transformations



Complex CASE statements for segmentation



Referential integrity constraints



Data type casting and standardization



Architecture

text

BigQuery Raw Data → dbt Staging → dbt Core (Star Schema) → dbt Analytics (CLV) → Documentation/Visualization

Results

11 production models across 3 layers



60+ automated tests ensuring data quality



RFM segmentation of customer base



Predictive CLV for 12-month planning



\## Live Dashboard



View the interactive CLV dashboard on Looker Studio:



\[🔗 Click here to view the Customer Lifetime Value Dashboard]https://datastudio.google.com/reporting/99b0657e-4094-4654-a2a8-6c7cffa5a3b9



\### Dashboard Features

\- \*\*KPI Cards\*\*: Total customers, average CLV, total lifetime value

\- \*\*Segment Analysis\*\*: CLV distribution by customer segment

\- \*\*Customer Ranking\*\*: Top 20 customers by predicted value

\- \*\*Interactive Filtering\*\*: Filter by RFM segment



\## Project Status



✅ \*\*Complete\*\* - Production-ready analytics pipeline



\### Components



| Component | Status | Link |

|-----------|--------|------|

| dbt Models | ✅ 11 models | \[GitHub](https://github.com/geoffrey-bi-analyst/Retail-Analytics-dbt-CLV) |

| Data Tests | ✅ 60+ passing | \[dbt Cloud](https://cloud.getdbt.com) |

| Documentation | ✅ Auto-generated | `dbt docs serve` |

| BigQuery | ✅ Live tables | `neat-bongo-497216-c8.retail\_analytics` |

| Looker Studio | ✅ Interactive dashboard | \[View Dashboard](https://datastudio.google.com/reporting/99b0657e-4094-4654-a2a8-6c7cffa5a3b9) |

| dbt Cloud | ✅ Scheduled daily | Daily refresh at 6 AM |

| Version Control | ✅ GitHub | \[Repository Link] |



\### Skills Demonstrated



\- Data modeling (star schema, dimensions, facts)

\- dbt (ELT, testing, documentation)

\- Advanced SQL (window functions, CTEs, RFM analysis)

\- Customer Lifetime Value (CLV) modeling

\- Cloud data warehouse (BigQuery)

\- Data visualization (Looker Studio)

\- Version control (Git/GitHub)

\- CI/CD and orchestration (dbt Cloud)



\### Dashboard Preview



The Looker Studio dashboard shows:

\- Total customers, average CLV, total lifetime value

\- CLV distribution by customer segment

\- Top 20 customers by predicted value

\- Retention cohort heatmap

\- Monthly CLV trends



Author

Geoffrey BI-Analyst



License

MIT

