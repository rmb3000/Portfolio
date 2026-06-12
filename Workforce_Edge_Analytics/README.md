# Workforce Edge Partner Analytics

**Platform:** Google BigQuery · Looker Studio  
**Author:** Rex M. Burdette | rex@rexsixsigma.com

---

## 📊 Live Dashboard
**[View Live Dashboard](https://datastudio.google.com/reporting/dd739b8b-6250-40df-971d-f03ee7c8dbde)**

3-page interactive dashboard built on live BigQuery data:
- **Page 1:** Enrollment & Completion — 5 KPIs + completion rate and learner volume by partner
- **Page 2:** Career Outcomes — Promotion rate and salary increase by partner  
- **Page 3:** Retention & Engagement — 12/24-month retention, manager ratings, skills applied

---

## Data Model
Two source tables joined on PartnerID:

- **Employer_Partners** — partner company attributes (BenefitTier, Industry, PartnerStatus)
- **Learner_Enrollment** — enrollment records per learner (EnrollmentStatus, CompletionDate)
- **Learner_Outcome** — post-completion outcomes (Promoted_Within12Mo, SalaryIncrease_Pct, RetainedAt12Mo, ManagerRating)

---

## SQL Queries

| File | Description |
|------|-------------|
| `partner_completion_summary.sql` | Completion rates by partner and benefit tier |
| `partner_enrollment_detail.sql` | Full enrollment funnel by industry and partner status |
| `partner_outcomes.sql` | Promotion rate, salary increase, and 12-month retention by partner |

---

## Key Metrics
- **Completion Rate** — % of enrolled learners who completed the program
- **Promotion Rate** — % promoted within 12 months of completion
- **Avg Salary Increase** — average % salary increase post-completion
- **12-Month Retention** — % retained at employer 12 months post-completion
- **24-Month Retention** — % retained at employer 24 months post-completion
- **Manager Rating** — average manager satisfaction score by partner
- **Skills Applied Score** — average score measuring learning application on the job

- ## Power BI Dashboard Screenshots

**Page 1 — Enrollment & Completion**
![Page 1](Power%20BI%20Page%201.jpg)

**Page 2 — Career Outcomes**
![Page 2](Power%20BI%20Page%202.jpg)

**Page 3 — Retention**
![Page 3](Power%20BI%20Page%203.jpg)

**Page 4 — Engagement**
![Page 4](Power%20BI%20Page%204.jpg)

**Page 5 — Trends**
![Page 5](Power%20BI%20Page%205.jpg)
