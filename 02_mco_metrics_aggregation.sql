-- ============================================================================
-- Script 02: MCO Cost & Utilization Cohort Aggregation
-- Purpose: Calculate total spend, PMPM, and utilization by attribution group
-- Author: Katina McKenzie
-- ============================================================================

-- 1. Total Spend and PMPM Summary by Attribution Cohort

SELECT 
    m.attribution_group,
    COUNT(DISTINCT m.member_id) AS member_count,
    ROUND(AVG(m.risk_score), 2) AS avg_risk_score,
    SUM(c.paid_amount) AS total_paid_amount,
    -- PMPM Calculation assuming a 12-month measurement period
    ROUND(SUM(c.paid_amount) / (COUNT(DISTINCT m.member_id) * 12), 2) AS pmpm_paid
FROM dim_members m
LEFT JOIN fact_claims c 
    ON m.member_id = c.member_id
GROUP BY m.attribution_group
ORDER BY total_paid_amount DESC;

-- 2. Utilization Breakdown by Service Setting & Attribution Group

SELECT 
    m.attribution_group,
    c.claim_type,
    COUNT(c.claim_id) AS total_visits,
    SUM(c.allowed_amount) AS total_allowed,
    SUM(c.paid_amount) AS total_paid,
    ROUND(AVG(c.paid_amount), 2) AS avg_cost_per_claim
FROM dim_members m
INNER JOIN fact_claims c 
    ON m.member_id = c.member_id
GROUP BY 
    m.attribution_group,
    c.claim_type
ORDER BY 
    m.attribution_group, 
    total_paid DESC;