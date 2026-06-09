/*
================================================
Partner Completion Summary
Author:      Rex M. Burdette | rex@rexsixsigma.com
Platform:    Google BigQuery
Database:    workforce-edge-analytics
Schema:      workforce_edge
Description: Summarizes learner enrollment and 
             completion activity by partner company
             and benefit tier. Uses LEFT JOIN to 
             include partners with no enrollments.
             Calculates completion rate as a 
             percentage of total learners enrolled.
Output:      One row per company/tier combination,
             ranked by total learner volume desc.
================================================
*/

SELECT
    ep.CompanyName,
    ep.BenefitTier,
    COUNT(le.LearnerID)                                     AS TotalLearners,

    SUM(
        CASE WHEN le.EnrollmentStatus = 'Active'
             THEN 1 ELSE 0 END
    )                                                       AS ActiveLearners,

    SUM(
        CASE WHEN le.EnrollmentStatus = 'Completed'
             THEN 1 ELSE 0 END
    )                                                       AS Completions,

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
    ep.BenefitTier

ORDER BY TotalLearners DESC
