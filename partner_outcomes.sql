/*
================================================
Partner Outcomes Analysis
Author:      Rex M. Burdette | rex@rexsixsigma.com
Platform:    Google BigQuery
Database:    workforce-edge-analytics
Schema:      workforce_edge
Description: Aggregates learner outcomes by partner
             company -- calculates promotion rate,
             average salary increase, and 12-month
             retention rate to measure ROI of 
             workforce education partnerships.
Output:      One row per partner, ranked by 
             promotion rate descending.
================================================
*/

SELECT
    lo.CompanyName,
    COUNT(*)                                            AS TotalCompletions,
    
    SUM(
        CASE WHEN lo.Promoted_Within12Mo = TRUE 
             THEN 1 ELSE 0 END
    )                                                   AS Promotions,
    
    ROUND(
        100.0 * SUM(CASE WHEN lo.Promoted_Within12Mo = TRUE 
                         THEN 1 ELSE 0 END)
        / COUNT(*), 1
    )                                                   AS PromotionRate_Pct,
    
    ROUND(AVG(lo.SalaryIncrease_Pct), 1)               AS AvgSalaryIncrease_Pct,
    
    ROUND(
        100.0 * SUM(CASE WHEN lo.RetainedAt12Mo = 'Y' 
                         THEN 1 ELSE 0 END)
        / COUNT(*), 1
    )                                                   AS RetentionRate_12Mo_Pct

FROM `workforce-edge-analytics.workforce_edge.Learner_Outcome` lo

GROUP BY lo.CompanyName
ORDER BY PromotionRate_Pct DESC
