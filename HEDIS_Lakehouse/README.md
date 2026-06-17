# HEDIS Quality Gap Analysis — Microsoft Fabric Lakehouse

![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![Microsoft Fabric](https://img.shields.io/badge/Microsoft%20Fabric-0078D4?style=flat&logo=microsoft&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

A complete end-to-end healthcare analytics pipeline built on **Microsoft Fabric** using **medallion architecture** — from raw Excel ingestion through Silver Delta tables to an interactive Power BI executive dashboard tracking HEDIS quality measure compliance and open care gaps.

---
## Dashboard Preview
![HEDIS Gap Analysis Dashboard](./screenshots/HEDIS%20Entire%20Power%20BI%20Dashboard%20Screenshot.jpg)

## 📋 Project Overview

**HEDIS (Healthcare Effectiveness Data and Information Set)** is the most widely used set of performance measures in managed care, maintained by NCQA. Health plans use HEDIS to measure clinical quality, identify care gaps, and drive care management outreach.

This project simulates a real-world HEDIS gap analysis pipeline for a regional health network — 200 members across 7 quality measures — demonstrating how a modern Fabric Lakehouse enables faster, more reliable clinical analytics than traditional ETL approaches.

---

## 🏗️ Architecture

```
Excel Dataset (Bronze)
       │
       ▼
Fabric OneLake Files
       │
       ▼
Dataflow Gen2 (Power Query Transformations)
       │
       ├── Data type corrections (Date, Text, Decimal)
       ├── Null handling (ServiceDate, ProviderName)
       ├── GapOpen null replacement
       └── NCQATarget_Pct text standardization
       │
       ▼
Silver Delta Tables (SQL Analytics Endpoint)
       │
       ├── Silver_Member_Enrollment (200 rows)
       ├── Silver_HEDIS_Measure_Results (288 rows)
       ├── Silver_Provider_Reference (10 rows)
       └── Silver_Measure_Reference (7 rows)
       │
       ▼
Semantic Model (Star Schema)
       │
       ├── Relationships (MemberID, MeasureCode, ProviderName)
       └── DAX Measures (Total Eligible, Compliant, Open Gaps, Compliance Rate %)
       │
       ▼
Power BI Dashboard
```

---

## 📊 Dashboard

![HEDIS Dashboard](./screenshots/HEDIS%20Entire%20Power%20BI%20Dashboard%20Screenshot.jpg)

### Key Visuals
- **KPI Cards** — Total Eligible (288), Total Compliant (178), Total Open Gaps (92), Compliance Rate (61.8%)
- **Compliance Rate % by Measure** — horizontal bar chart across 7 HEDIS measures
- **Total Open Gaps by Measure** — prioritized gap view for care management
- **Provider Gap Attribution** — open gaps by provider including "No Provider on Record" for unengaged members
- **MeasureCode Slicer** — interactive filtering across all visuals

---

## 📈 Key Findings

| Measure | Compliance Rate | Open Gaps | Priority |
|---------|----------------|-----------|---------|
| CDC-A1C | 78.6% | 6 | Low |
| CCS | 69.1% | 16 | Medium |
| BCS | 67.7% | 10 | Medium |
| COL | 64.6% | 26 | **High** |
| CBP | 55.6% | 20 | **High** |
| CDC-EYE | 50.0% | 14 | High |
| CDC-HBA1C-POOR | 31.8% | 0 | Inverse measure |

**Key insight:** 72 of 92 open gaps (78%) have no provider on record — representing members who have never been seen for that service. These are the primary care management outreach targets, not documentation failures.

---

## 🗄️ Data Model

**Fact Table:** Silver_HEDIS_Measure_Results
- MemberID (FK → Silver_Member_Enrollment)
- MeasureCode (FK → Silver_Measure_Reference)
- ProviderName (FK → Silver_Provider_Reference)
- Denominator, Exclusion, Numerator, GapOpen
- ServiceDate, CPT_LOINC_Code, MeasureYear, Notes

**Dimension Tables:**
- Silver_Member_Enrollment — demographics, plan, enrollment dates
- Silver_Measure_Reference — NCQA specifications, targets, triple-weighted flags
- Silver_Provider_Reference — NPI, practice, specialty

---

## 🔢 DAX Measures

```dax
Total Eligible = COUNTROWS(Silver_HEDIS_Measure_Results)

Total Compliant = 
CALCULATE(
    COUNTROWS(Silver_HEDIS_Measure_Results),
    Silver_HEDIS_Measure_Results[Numerator] = "Y"
)

Total Open Gaps = 
CALCULATE(
    COUNTROWS(Silver_HEDIS_Measure_Results),
    Silver_HEDIS_Measure_Results[GapOpen] = "Y"
)

Compliance Rate = 
ROUND(DIVIDE([Total Compliant], [Total Eligible]) * 100, 1)
```

---

## 🔍 SQL Gap Analysis

```sql
SELECT 
    MeasureCode,
    COUNT(*) AS TotalEligible,
    SUM(CASE WHEN Numerator = 'Y' THEN 1 ELSE 0 END) AS Compliant,
    SUM(CASE WHEN GapOpen = 'Y' THEN 1 ELSE 0 END) AS OpenGaps,
    CAST(ROUND(100.0 * SUM(CASE WHEN Numerator = 'Y' THEN 1 ELSE 0 END) 
        / COUNT(*), 1) AS DECIMAL(5,1)) AS ComplianceRate_Pct
FROM Silver_HEDIS_Measure_Results
GROUP BY MeasureCode
ORDER BY ComplianceRate_Pct ASC
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Storage | Microsoft Fabric OneLake / Delta Lake |
| Ingestion | Dataflow Gen2 (Power Query) |
| Transformation | Power Query M Language |
| Query | T-SQL / SQL Analytics Endpoint |
| Semantic Model | Power BI Direct Lake |
| Visualization | Power BI Service |
| DAX | Power BI DAX |
| Source Data | Excel (.xlsx) — 4 sheets |

---

## 📁 Repository Structure

```
hedis-gap-analysis-fabric/
│
├── README.md
├── data/
│   └── HEDIS_Bronze_Dataset.xlsx
├── sql/
│   └── hedis_gap_analysis.sql
└── screenshots/
    ├── fabric_pipeline.png
    ├── silver_tables.png
    ├── sql_results.png
    └── hedis_dashboard.png
```

---

## 🏥 HEDIS Measures Covered

| Code | Measure | Domain |
|------|---------|--------|
| BCS | Breast Cancer Screening | Effectiveness of Care |
| CCS | Cervical Cancer Screening | Effectiveness of Care |
| COL | Colorectal Cancer Screening | Effectiveness of Care |
| CDC-A1C | Diabetes Care — A1c Testing | At-Risk Population |
| CDC-HBA1C-POOR | Diabetes Care — Poor Control | At-Risk Population |
| CDC-EYE | Diabetes Care — Eye Exam | At-Risk Population |
| CBP | Controlling High Blood Pressure | At-Risk Population |

---

## 👤 About

Built by **Rex M. Burdette, MBA** — Senior Data Analytics Leader and Lean Six Sigma Master Black Belt with 20+ years in healthcare and manufacturing analytics.

- 🔗 [LinkedIn](https://linkedin.com/in/rexburdette)
- 📧 rex.burdette@gmail.com
- 🐙 [GitHub](https://github.com/rmb3000)

---

*This project uses simulated data for demonstration purposes. No real patient data was used.*
