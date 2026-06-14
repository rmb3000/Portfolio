# CMS Open Payments Lakehouse
## Microsoft Fabric Medallion Architecture | Live CMS API Ingestion

### Overview
End-to-end Medallion Lakehouse pipeline ingesting live CMS Open Payments data 
(14.7M+ records available) into Bronze, Silver, and Gold Delta layers on 
Microsoft Fabric, with Power BI dashboard surfacing provider payment analytics 
by manufacturer, state, and specialty.

### Architecture
- **Bronze** — Raw API ingestion from CMS Open Payments (500 records, 91 columns)
- **Silver** — Cleaned, typed, renamed, quality-flagged (14 columns)
- **Gold** — Aggregated analytics tables by Manufacturer, State, and Specialty
- **Dashboard** — Power BI report with KPI cards and interactive bar charts

### Data Source
- **CMS Open Payments API** — 14,700,786 records available (2023 program year)
- Federally mandated transparency data on pharma/device payments to physicians
- No authentication required — publicly accessible REST API

### Tech Stack
- Microsoft Fabric Lakehouse
- Python (Pandas, Requests)
- Medallion Architecture (Bronze → Silver → Gold)
- Power BI (Fabric-native report)
- Parquet file format

### Key Findings (500 record sample)
- Minerva Surgical Inc: $10,653 total payments (339 transactions)
- Neuronetics Inc: $6,809 total payments (161 transactions)
- California leads all states in total payment volume
- Allopathic & Osteopathic Physicians receive the majority of payments

### Portfolio Note
Built as a portfolio demonstration of Microsoft Fabric Lakehouse architecture 
relevant to healthcare analytics environments. In production, Silver Delta tables 
would be registered as managed tables and the Gold semantic model would connect 
via Direct Lake mode.
