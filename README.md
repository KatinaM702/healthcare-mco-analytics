# Healthcare MCO Cost & Utilization Analytics

## Project Overview
This repository demonstrates SQL dimensional modeling, data validation routines, and Managed Care Organization (MCO) metric aggregations using synthetic claims data.

## Key Technical Focus Areas
- **Data Validation (`01_data_validation.sql`):** Primary key uniqueness checks, table grain verification, and orphan foreign key detection.
- **Financial & Utilization Metrics (`02_mco_metrics_aggregation.sql`):** Per Member Per Month (PMPM) spend calculations, risk score analysis, and service setting utilization breakdowns (Inpatient, ER, Primary Care, Pharmacy).

## Data Schema
- `dim_members.csv`: Member demographic, risk score, and attribution group dimensional data.
- `fact_claims.csv`: Claim line detail including dates of service, claim types, allowed amounts, and paid amounts.
