/*
Purpose:
Build country-level analytical table by combining pipeline data with institutional rules.

Steps:
1. Aggregate leads at country level
2. Join institutional variables (country_rules)
3. Derive execution capacity (EX)
4. Classify countries into Levels (1, 2, 3)
5. Assign business priority

Output:
Country-level dataset with pipeline metrics + classification + priority
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

        cr.SA,
        cr.STR,
        cr.Budget_Signal,
        cr.Blocking_Constraint

    FROM country_agg ca
    LEFT JOIN country_rules cr
        ON ca.country = cr.country
),

derived AS (
    SELECT
        *,

        CASE
            WHEN Budget_Signal = 1 AND Blocking_Constraint = 0 THEN 1
            ELSE 0
        END AS EX

    FROM joined
),

classified AS (
    SELECT
        *,

        CASE
            WHEN SA = 0 THEN 'Level 1'
            WHEN SA = 1 AND (STR = 0 OR EX = 0) THEN 'Level 2'
            WHEN SA = 1 AND STR = 1 AND EX = 1 THEN 'Level 3'
            ELSE 'Unclassified'
        END AS level

    FROM derived
),

final AS (
    SELECT
        *,

        CASE
            WHEN Blocking_Constraint = 1 THEN 'Delayed'
            WHEN level = 'Level 3' THEN 'Focus'
            WHEN level = 'Level 2' THEN 'Nurture'
            ELSE 'Low Priority'
        END AS priority

    FROM classified
)

SELECT *
FROM final
ORDER BY total_leads DESC;