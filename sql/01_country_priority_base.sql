/*
Purpose:
Build a country-level analytical table by combining pipeline data with institutional rules.

Steps:
1. Aggregate leads at country level
2. Join institutional variables from country_rules
3. Derive execution capacity (EX)
4. Classify countries into predicted levels
5. Assign business priority

Output:
Country-level dataset with pipeline metrics, institutional classification,
and business priority
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
        ca.country,
        ca.total_leads,
        ca.outreach_count,
        ca.engagement_count,
        ca.meeting_count,
        ca.proposal_count,
        ca.won_count,
        ca.max_stage,
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
),

final AS (
    SELECT
        *,
        CASE
            WHEN blocking_constraint = 1 THEN 'Delayed'
            WHEN predicted_level = 'Level 3' THEN 'Focus'
            WHEN predicted_level = 'Level 2' THEN 'Nurture'
            WHEN predicted_level = 'Level 1' THEN 'Low Priority'
            ELSE 'Unclassified'
        END AS priority
    FROM classified
)

SELECT *
FROM final
ORDER BY total_leads DESC;
