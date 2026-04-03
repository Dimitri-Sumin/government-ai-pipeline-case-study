/*
Purpose:
Validate data consistency, model coverage, and rule integrity.

Checks:
1. Countries in leads missing from country_rules
2. Null values after joining country-level data with rules
3. Unexpected classifications
4. Duplicate countries in country_rules
5. Invalid values in rule fields (not 0/1)
*/

-- 1. Countries present in leads but missing from country_rules
SELECT DISTINCT l.country
FROM leads l
LEFT JOIN country_rules cr
    ON l.country = cr.country
WHERE cr.country IS NULL
ORDER BY l.country;


-- 2. Null checks after country-level join
WITH country_agg AS (
    SELECT
        country,
        COUNT(*) AS total_leads
    FROM leads
    GROUP BY country
),
joined AS (
    SELECT
        ca.country,
        ca.total_leads,
        cr.sa,
        cr.str,
        cr.budget_signal,
        cr.blocking_constraint
    FROM country_agg ca
    LEFT JOIN country_rules cr
        ON ca.country = cr.country
)
SELECT *
FROM joined
WHERE sa IS NULL
   OR str IS NULL
   OR budget_signal IS NULL
   OR blocking_constraint IS NULL
ORDER BY country;


-- 3. Unexpected classifications
WITH country_agg AS (
    SELECT
        country,
        COUNT(*) AS total_leads,
        MAX(stage_order) AS max_stage
    FROM leads
    GROUP BY country
),
joined AS (
    SELECT
        ca.*,
        cr.sa,
        cr.str,
        cr.budget_signal,
        cr.blocking_constraint
    FROM country_agg ca
    LEFT JOIN country_rules cr
        ON ca.country = cr.country
),
derived AS (
    SELECT
        *,
        CASE
            WHEN budget_signal = 1 AND blocking_constraint = 0 THEN 1
            ELSE 0
        END AS ex
    FROM joined
),
classified AS (
    SELECT
        *,
        CASE
            WHEN sa = 0 THEN 'Level 1'
            WHEN sa = 1 AND (str = 0 OR ex = 0) THEN 'Level 2'
            WHEN sa = 1 AND str = 1 AND ex = 1 THEN 'Level 3'
            ELSE 'Unclassified'
        END AS predicted_level
    FROM derived
)
SELECT *
FROM classified
WHERE predicted_level = 'Unclassified'
ORDER BY country;


-- 4. Duplicate country entries in country_rules
SELECT
    country,
    COUNT(*) AS row_count
FROM country_rules
GROUP BY country
HAVING COUNT(*) > 1
ORDER BY row_count DESC, country;


-- 5. Invalid values in rule fields (not 0/1)
SELECT *
FROM country_rules
WHERE sa NOT IN (0,1)
   OR str NOT IN (0,1)
   OR budget_signal NOT IN (0,1)
   OR blocking_constraint NOT IN (0,1);
