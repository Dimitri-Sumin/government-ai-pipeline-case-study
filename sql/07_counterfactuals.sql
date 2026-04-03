/*
Purpose:
Evaluate counterfactual scenarios for each country in the institutional rule-based model.

Steps:
1. Load institutional rule inputs for each country
2. Compute baseline execution capacity (EX) and predicted level
3. Recompute levels under alternative scenarios:
   - no blocking constraint
   - budget signal switched on
   - budget signal on and no blocking constraint
4. Return a country-level comparison table

Output:
Country-level counterfactual comparison of baseline vs alternative rule scenarios
*/

WITH base AS (
    SELECT
        country AS country,
        sa,
        str,
        budget_signal,
        blocking_constraint
    FROM country_rules
),

scenario_inputs AS (
    SELECT
        country,
        sa,
        str,
        budget_signal,
        blocking_constraint,

        budget_signal AS budget_signal_base,
        blocking_constraint AS blocking_constraint_base,

        budget_signal AS budget_signal_no_block,
        0 AS blocking_constraint_no_block,

        1 AS budget_signal_on,
        blocking_constraint AS blocking_constraint_budget_on,

        1 AS budget_signal_both,
        0 AS blocking_constraint_both
    FROM base
),

scenario_ex AS (
    SELECT
        country,
        sa,
        str,
        budget_signal,
        blocking_constraint,

        CASE
            WHEN budget_signal_base = 1 AND blocking_constraint_base = 0 THEN 1
            ELSE 0
        END AS ex_base,

        CASE
            WHEN budget_signal_no_block = 1 AND blocking_constraint_no_block = 0 THEN 1
            ELSE 0
        END AS ex_if_no_blocking_constraint,

        CASE
            WHEN budget_signal_on = 1 AND blocking_constraint_budget_on = 0 THEN 1
            ELSE 0
        END AS ex_if_budget_signal_on,

        CASE
            WHEN budget_signal_both = 1 AND blocking_constraint_both = 0 THEN 1
            ELSE 0
        END AS ex_if_budget_on_and_no_block
    FROM scenario_inputs
),

classified AS (
    SELECT
        country AS "Country",
        sa AS "SA",
        str AS "STR",
        budget_signal AS "Budget_Signal",
        blocking_constraint AS "Blocking_Constraint",
        ex_base AS "EX_base",

        CASE
            WHEN sa = 0 THEN 1
            WHEN sa = 1 AND (str = 0 OR ex_base = 0) THEN 2
            WHEN sa = 1 AND str = 1 AND ex_base = 1 THEN 3
            ELSE NULL
        END AS "Level_base",

        CASE
            WHEN sa = 0 THEN 1
            WHEN sa = 1 AND (str = 0 OR ex_if_no_blocking_constraint = 0) THEN 2
            WHEN sa = 1 AND str = 1 AND ex_if_no_blocking_constraint = 1 THEN 3
            ELSE NULL
        END AS "Level_if_no_blocking_constraint",

        CASE
            WHEN sa = 0 THEN 1
            WHEN sa = 1 AND (str = 0 OR ex_if_budget_signal_on = 0) THEN 2
            WHEN sa = 1 AND str = 1 AND ex_if_budget_signal_on = 1 THEN 3
            ELSE NULL
        END AS "Level_if_budget_signal_on",

        CASE
            WHEN sa = 0 THEN 1
            WHEN sa = 1 AND (str = 0 OR ex_if_budget_on_and_no_block = 0) THEN 2
            WHEN sa = 1 AND str = 1 AND ex_if_budget_on_and_no_block = 1 THEN 3
            ELSE NULL
        END AS "Level_if_budget_on_and_no_block"
    FROM scenario_ex
)

SELECT *
FROM classified
ORDER BY "Level_base", "Country";
