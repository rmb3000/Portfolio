# Workforce Edge Partner Analytics — BigQuery & Looker Studio

![Google BigQuery](https://img.shields.io/badge/BigQuery-4285F4?style=flat&logo=googlecloud&logoColor=white)
![Looker Studio](https://img.shields.io/badge/Looker%20Studio-4285F4?style=flat&logo=looker&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=flat&logo=mysql&logoColor=white)

A partner analytics dashboard built on **Google BigQuery** and **Looker Studio**, tracking enrollment, completion, career outcomes, and retention for a corporate workforce development program — with a parallel Power BI build covering the same data model across five report pages.

---

## Dashboard Preview
![Workforce Edge Dashboard](./screenshots/Power%20BI%20Page%201.jpg)

**[📊 View Live Looker Studio Dashboard](https://datastudio.google.com/reporting/dd739b8b-6250-40df-971d-f03ee7c8dbde)**

---

## 📋 Project Overview

**Workforce Edge** is a corporate partner program connecting employer organizations to a workforce development curriculum, tracking learner enrollment through completion, career outcomes, and long-term retention.

This project demonstrates the same partner analytics model built two ways: a live, interactive **Looker Studio** dashboard running directly on **BigQuery**, and a parallel **Power BI** build covering enrollment, career outcomes, retention, engagement, and trend analysis across five report pages.

---

## 🏗️ Data Model

Three source tables joined on `PartnerID`:

```
Employer_Partners
       │  PartnerID, BenefitTier, Industry, PartnerStatus
       │
       ▼
Learner_Enrollment
       │  PartnerID, EnrollmentStatus, CompletionDate
       │
       ▼
Learner_Outcome
       │  PartnerID, Promoted_Within12Mo, SalaryIncrease_Pct,
       │  RetainedAt12Mo, ManagerRating
       │
       ▼
   BigQuery (Looker Studio)  +  Power BI Semantic Model
```

---

## 📊 Dashboard — Looker Studio (Live, BigQuery)

3-page interactive dashboard built on live BigQuery data:

- **Page 1 — Enrollment & Completion**: 5 KPIs plus completion rate and learner volume by partner
- **Page 2 — Career Outcomes**: Promotion rate and salary increase by partner
- **Page 3 — Retention & Engagement**: 12/24-month retention, manager ratings, skills applied

**[📊 View Live Dashboard](https://datastudio.google.com/reporting/dd739b8b-6250-40df-971d-f03ee7c8dbde)**

---

## 📊 Dashboard — Power BI (5-Page Build)

**Page 1 — Enrollment & Completion**
![Page 1](./screenshots/Power%20BI%20Page%201.jpg)

**Page 2 — Career Outcomes**
![Page 2](./screenshots/Power%20BI%20Page%202.jpg)

**Page 3 — Retention**
![Page 3](./screenshots/Power%20BI%20Page%203.jpg)

**Page 4 — Engagement**
![Page 4](./screenshots/Power%20BI%20Page%204.jpg)

**Page 5 — Trends**
![Page 5](./screenshots/Power%20BI%20Page%205.jpg)

---

## 📈 Key Metrics

| Metric | Description |
|---|---|
| Completion Rate | % of enrolled learners who completed the program |
| Promotion Rate | % promoted within 12 months of completion |
| Avg Salary Increase | Average % salary increase post-completion |
| 12-Month Retention | % retained at employer 12 months post-completion |
| 24-Month Retention | % retained at employer 24 months post-completion |
| Manager Rating | Average manager satisfaction score by partner |
| Skills Applied Score | Average score measuring learning application on the job |

---

## 🔍 SQL Queries

| File | Description |
|---|---|
| `partner_completion_summary.sql` | Completion rates by partner and benefit tier |
| `partner_enrollment_detail.sql` | Full enrollment funnel by industry and partner status |
| `partner_outcomes.sql` | Promotion rate, salary increase, and 12-month retention by partner |

---

## 🔢 DAX Measures

Defined in `dax_measures.txt` — includes completion rate, promotion rate, average salary increase, and retention calculations mirroring the BigQuery SQL logic for the Power BI build.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Data Warehouse | Google BigQuery |
| Live Dashboard | Looker Studio |
| Parallel Build | Power BI Desktop |
| Query Language | SQL |
| Semantic Layer | DAX (Power BI) |

---

## 📁 Repository Structure

```
Workforce_Edge_Analytics/
│
├── partner_completion_summary.sql
├── partner_enrollment_detail.sql
├── partner_outcomes.sql
├── dax_measures.txt
│
├── screenshots/
│   ├── Power BI Page 1.jpg
│   ├── Power BI Page 2.jpg
│   ├── Power BI Page 3.jpg
│   ├── Power BI Page 4.jpg
│   └── Power BI Page 5.jpg
│
└── README.md
```

---

## 👤 About

Built by **Rex M. Burdette, MBA** — Senior Data Analytics Leader and Lean Six Sigma Master Black Belt with 20+ years in healthcare and manufacturing analytics.

- 🔗 [LinkedIn](https://linkedin.com/in/rexburdette)
- 📧 rex.burdette@gmail.com
- 🐙 [GitHub](https://github.com/rmb3000)

---

*This project uses simulated partner program data for demonstration purposes.*
