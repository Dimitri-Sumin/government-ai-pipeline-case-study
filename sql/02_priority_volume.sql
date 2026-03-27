/*
Purpose:
Summarize country distribution by business priority.

Logic:
Uses the same country-level aggregation and classification pipeline
as 01_country_priority_base.sql, then groups countries by priority.

Output:
One row per priority segment with:
- number of countries
- total leads
- average leads per country
*/

WITH country_agg AS (
    SELECT
        country,
        COUNT(*) AS total_leads,
        COUNT(*) FILTER (WHERE stage = 'outreach') AS outreach_count,
        COUNT(*) FILTER (WHERE stage = 'engagement') AS engagement_count,
        COUNT(*) FILTER (WHERE stage = 'meeting') AS meeting_count,
        COUNT(*) FILTER (WHERE stage = 'proposal') AS proposal_count,
        COUNT(*) FILTER (WHERE stage = 'won') AS won_count,
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
        END AS level
    FROM derived
),

final AS (
    SELECT
        *,
        CASE
            WHEN blocking_constraint = 1 THEN 'Delayed'
            WHEN level = 'Level 3' THEN 'Focus'
            WHEN level = 'Level 2' THEN 'Nurture'
            ELSE 'Low Priority'
        END AS priority
    FROM classified
)

SELECT
    priority,
    COUNT(*) AS country_count,
    SUM(total_leads) AS total_leads,
    ROUND(AVG(total_leads), 2) AS avg_leads_per_country
FROM final
GROUP BY priority
ORDER BY total_leads DESC;