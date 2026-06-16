# CMS Hospital Quality Lakehouse
## Databricks Medallion Architecture | Live CMS API Ingestion

### Overview
End-to-end Medallion Lakehouse pipeline ingesting live CMS Hospital General 
Information data (335 rated facilities) into Bronze, Silver, and Gold Delta 
layers on Databricks, with Power BI Desktop dashboard surfacing hospital quality 
analytics by type, ownership, and state.

### Architecture
- **Bronze** — Raw API ingestion from CMS Hospital General Information (xubh-q36u)
- **Silver** — Cleaned, typed, renamed, quality-flagged, hospital type standardized
- **Gold** — Aggregated analytics tables by State, Hospital Type, Ownership, and Top Rated Facilities
- **Dashboard** — 2-page Power BI report with KPI cards, bar charts, donut chart, and filterable facility table

### Data Source
- **CMS Hospital General Information API** — Dataset ID: xubh-q36u
- Publicly reported hospital quality ratings from CMS Provider Data Catalog
- No authentication required — publicly accessible REST API
- URL: https://data.cms.gov/provider-data/dataset/xubh-q36u

### Tech Stack
- Databricks (Serverless Compute)
- Python (PySpark, Pandas)
- Medallion Architecture (Bronze → Silver → Gold)
- Delta Lake (all layers)
- Power BI Desktop (Live Databricks Connection)

### Key Findings
- 335 U.S. hospitals with an overall quality rating
- VA Hospitals lead all types with an average rating of 4.4
- California ranks highest among states with an average rating of 3.2
- 75% of rated facilities are Acute Care Hospitals

### Notebooks
| Notebook | Description |
|---|---|
| `CMS_Bronze_Ingestion.ipynb` | API ingestion, raw Delta write |
| `CMS_Silver_Transformation.ipynb` | Cleaning, typing, standardization |
| `CMS_Gold_Aggregation.ipynb` | Four aggregation tables, Delta write |

### Portfolio Note
Built as a portfolio demonstration of Databricks Medallion Lakehouse architecture 
relevant to healthcare analytics environments. In production, notebooks would be 
orchestrated via Databricks Workflows and the Power BI semantic model would 
connect via Direct Lake mode with scheduled refresh.
