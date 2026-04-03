/*
Purpose:
Generate a full truth table for the institutional rule-based model.

Steps:
1. Enumerate all binary combinations of SA, STR, Budget_Signal, and Blocking_Constraint
2. Derive execution capacity (EX)
3. Predict institutional level based on rule logic
4. Return all configurations in sorted order

Output:
Truth table with all 16 possible configurations and their predicted levels
*/

WITH combinations AS (
    SELECT
        sa,
        str,
        budget_signal,
        blocking_constraint
    FROM generate_series(0, 1) AS sa
    CROSS JOIN generate_series(0, 1) AS str
    CROSS JOIN generate_series(0, 1) AS budget_signal
    CROSS JOIN generate_series(0, 1) AS blocking_constraint
),

derived AS (
    SELECT
        sa AS "SA",
        str AS "STR",
        budget_signal AS "Budget_Signal",
        blocking_constraint AS "Blocking_Constraint",

        CASE
            WHEN budget_signal = 1 AND blocking_constraint = 0 THEN 1
            ELSE 0
        END AS "EX"
    FROM combinations
),

classified AS (
    SELECT
        *,

        CASE
            WHEN "SA" = 0 THEN 1
            WHEN "SA" = 1 AND ("STR" = 0 OR "EX" = 0) THEN 2
            WHEN "SA" = 1 AND "STR" = 1 AND "EX" = 1 THEN 3
        END AS "Predicted_Level"
    FROM derived
)

SELECT *
FROM classified
ORDER BY
    "SA",
    "STR",
    "Budget_Signal",
    "Blocking_Constraint";
