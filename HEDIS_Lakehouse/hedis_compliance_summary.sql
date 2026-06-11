/*
================================================
HEDIS Measure Compliance Summary
Author:      Rex M. Burdette | rex@rexsixsigma.com
Platform:    Microsoft Fabric SQL Analytics Endpoint
Lakehouse:   HEDIS Quality Analytics Lakehouse
Layer:       Silver (Cleaned and Transformed)
Description: Calculates compliance rates across all
             HEDIS quality measures...
================================================
*/

SELECT
    MeasureCode,
    COUNT(*)                                                AS TotalEligible,
    SUM(CASE WHEN Numerator = 'Y' THEN 1 ELSE 0 END)      AS Compliant,
    SUM(CASE WHEN GapOpen = 'Y' THEN 1 ELSE 0 END)        AS OpenGaps,
    CAST(ROUND(100.0 * SUM(CASE WHEN Numerator = 'Y'
        THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 1)
        AS DECIMAL(5,1))                                    AS ComplianceRate_Pct
FROM Silver_HEDIS_Measure_Results
GROUP BY MeasureCode
ORDER BY ComplianceRate_Pct ASC
