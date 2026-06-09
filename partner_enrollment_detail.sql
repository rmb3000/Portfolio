/*
================================================
Partner Enrollment Detail by Industry and Status
Author:      Rex M. Burdette | rex@rexsixsigma.com
Platform:    Google BigQuery
Database:    workforce-edge-analytics
Schema:      workforce_edge
Description: Extends partner completion summary
             with industry segmentation, partner
             status filter, and withdrawal tracking.
             Provides a full enrollment funnel view:
             Active → Completed → Withdrawn by 
             partner, industry, tier, and status.
             Useful for identifying at-risk partners
             and industry-level completion patterns.
Output:      One row per company/industry/tier/
             status combination.
================================================
*/

SELECT
    ep.CompanyName,
    ep.Industry,
    ep.BenefitTier,
    ep.PartnerStatus,

    COUNT(le.LearnerID)                                     AS TotalLearners,

    SUM(
        CASE WHEN le.EnrollmentStatus = 'Active'
             THEN 1 ELSE 0 END
    )                                                       AS ActiveLearners,

    SUM(
        CASE WHEN le.EnrollmentStatus = 'Completed'
             THEN 1 ELSE 0 END
    )                                                       AS Completions,

    SUM(
        CASE WHEN le.EnrollmentStatus = 'Withdrawn'
             THEN 1 ELSE 0 END
    )                                                       AS Withdrawals,

    ROUND(
        100.0 * SUM(CASE WHEN le.EnrollmentStatus = 'Completed'
                         THEN 1 ELSE 0 END)
        / NULLIF(COUNT(le.LearnerID), 0), 1
    )                                                       AS CompletionRate_Pct

FROM `workforce-edge-analytics.workforce_edge.Employer_Partners` ep

LEFT JOIN `workforce-edge-analytics.workforce_edge.Learner_Enrollment` le
    ON ep.PartnerID = le.PartnerID

GROUP BY
    ep.CompanyName,
    ep.Industry,
    ep.BenefitTier,
    ep.PartnerStatus
