-- ============================================================================
-- Script 01: Data Validation & Grain Check Routines
-- Purpose: Verify entity integrity, key uniqueness, and table relationships
-- Author: Katina McKenzie
-- ============================================================================

-- 1. Check Primary Key Uniqueness in Member Dimension (Ensure no duplicates)

SELECT 
    member_id, 
    COUNT(*) AS record_count
FROM dim_members
GROUP BY member_id
HAVING COUNT(*) > 1;

-- 2. Verify Fact Table Grain (Check claim_id uniqueness)

SELECT 
    claim_id, 
    COUNT(*) AS duplicate_claims
FROM fact_claims
GROUP BY claim_id
HAVING COUNT(*) > 1;

-- 3. Orphan Key Check (Find claims pointing to members missing from the Member Dimension)

SELECT 
    c.claim_id,
    c.member_id AS claim_member_id
FROM fact_claims c
LEFT JOIN dim_members m 
    ON c.member_id = m.member_id
WHERE m.member_id IS NULL;

-- 4. Attribute Distribution Check (Verify member counts by attribution group)

SELECT 
    attribution_group,
    COUNT(member_id) AS total_members,
    AVG(risk_score) AS avg_mara_risk_score
FROM dim_members
GROUP BY attribution_group;