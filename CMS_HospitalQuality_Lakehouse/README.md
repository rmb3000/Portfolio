CMS API (xubh-q36u)
      │
      ▼
┌─────────────┐
│   BRONZE    │  Raw ingestion via CMS Provider Data API
│  Delta Lake │  Full fidelity, no transformations
└─────────────┘
      │
      ▼
┌─────────────┐
│   SILVER    │  Cleaned, typed, standardized
│  Delta Lake │  Column selection, rename, type casting,
└─────────────┘  data quality flags, hospital_type normalization
      │
      ▼
┌─────────────┐
│    GOLD     │  Aggregated, analytics-ready
│  Delta Lake │  Four aggregation tables
└─────────────┘
      │
      ▼
┌─────────────┐
│  Power BI   │  Live Databricks connection
│  Dashboard  │  2-page interactive report
└─────────────┘
