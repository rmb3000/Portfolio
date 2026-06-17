# CMS Open Payments Analytics — Microsoft Fabric Lakehouse

![Microsoft Fabric](https://img.shields.io/badge/Microsoft%20Fabric-0078D4?style=flat&logo=microsoft&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)

A complete end-to-end healthcare analytics pipeline built on **Microsoft Fabric** using **Medallion architecture** — from live CMS Open Payments API ingestion through Bronze, Silver, and Gold Delta layers to an interactive Power BI dashboard surfacing provider payment analytics by manufacturer, state, and specialty.

---

## Dashboard Preview
![CMS Open Payments Dashboard](./screenshots/CMS%20Open%20Payments%20Dashboard.png)

---

## 📋 Project Overview

**CMS Open Payments** is a federally mandated transparency program publishing data on payments made by pharmaceutical and medical device manufacturers to physicians and teaching hospitals. The full dataset contains over 14.7 million records for the 2023 program year alone.

This project demonstrates a Medallion Lakehouse pipeline on **Microsoft Fabric** — ingesting live data directly from the CMS Open Payments REST API, transforming through Bronze, Silver, and Gold Delta layers, and delivering an interactive Power BI dashboard surfacing payment patterns by manufacturer, state, and physician specialty.

---

## 🏗️ Architecture

```
CMS Open Payments API
       │
       ▼
┌─────────────────────┐
│       BRONZE        │  Raw API ingestion
│   Delta / Parquet   │  500 records, 91 columns — full fidelity, no transformations
└─────────────────────┘
       │
       ▼
┌─────────────────────┐
│       SILVER        │  Cleaned, typed, renamed
│   Delta / Parquet   │  14 columns, quality-flagged
└─────────────────────┘
       │
       ▼
┌─────────────────────┐
│        GOLD         │  Aggregated analytics tables
│   Delta / Parquet   │  By Manufacturer, State, and Specialty
└─────────────────────┘
       │
       ▼
┌─────────────────────┐
│      Power BI       │  KPI cards + interactive bar charts
│  Fabric-native      │
└─────────────────────┘
```

---

## 📊 Dashboard

![CMS Open Payments Dashboard](./screenshots/CMS%20Open%20Payments%20Dashboard.png)

### Key Visuals
- **KPI Cards** — total payments, transaction counts, and record summary
- **Total Payments by Manufacturer** — bar chart ranking top paying manufacturers
- **Total Payments by State** — geographic distribution of payment volume
- **Payments by Specialty** — breakdown of which physician specialties receive the most payments

---

## 📈 Key Findings (500-record sample)

| Manufacturer | Total Payments | Transactions |
|---|---|---|
| Minerva Surgical Inc | $10,653 | 339 |
| Neuronetics Inc | $6,809 | 161 |

**Key insight:** California leads all states in total payment volume in the sample, and Allopathic & Osteopathic Physicians receive the majority of payments — consistent with this specialty representing the largest share of practicing U.S. physicians.

*Note: findings reflect a 500-record development sample, not the full 14.7M-record dataset. The pipeline architecture is designed to scale to the full dataset in a production deployment.*

---

## 🗄️ Gold Layer Tables

| Table | Description |
|---|---|
| Gold — Manufacturer | Aggregated total payments and transaction counts by manufacturer |
| Gold — State | Aggregated total payments by state |
| Gold — Specialty | Aggregated total payments by physician specialty |

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Lakehouse | Microsoft Fabric |
| Ingestion | Python (Requests) |
| Transformation | Python (Pandas) |
| Storage Format | Parquet |
| Architecture | Medallion (Bronze → Silver → Gold) |
| Visualization | Power BI (Fabric-native report) |
| Data Source | CMS Open Payments API |

---

## 📁 Repository Structure

```
CMS_OpenPayments_Lakehouse/
│
├── CMS_Bronze_Ingestion.ipynb
├── CMS_Silver_Transformation.ipynb
├── CMS_Gold_Aggregation.ipynb
│
├── screenshots/
│   └── CMS Open Payments Dashboard.png
│
└── README.md
```

---

## 🏥 Data Source

| Field | Detail |
|---|---|
| Dataset | CMS Open Payments |
| Publisher | Centers for Medicare & Medicaid Services |
| Program Year | 2023 |
| Total Records Available | 14,700,786 |
| Access | Public REST API — no authentication required |

---

## Portfolio Note

Built as a portfolio demonstration of Microsoft Fabric Lakehouse architecture relevant to healthcare analytics environments. In production, Silver Delta tables would be registered as managed tables and the Gold semantic model would connect via Direct Lake mode, with the pipeline scaled to ingest the full 14.7M-record dataset.

---

## 👤 About

Built by **Rex M. Burdette, MBA** — Senior Data Analytics Leader and Lean Six Sigma Master Black Belt with 20+ years in healthcare and manufacturing analytics.

- 🔗 [LinkedIn](https://linkedin.com/in/rexburdette)
- 📧 rex.burdette@gmail.com
- 🐙 [GitHub](https://github.com/rmb3000)

---

*This project uses publicly available CMS data.*
