/*
Purpose:
Evaluate counterfactual scenarios for each country in the institutional rule-based model.

Steps:
1. Load institutional rule inputs for each country
2. Compute baseline EX and Level
3. Recompute Level under alternative scenarios:
   - no blocking constraint
   - budget signal switched on
   - budget signal on and no blocking constraint
4. Return country-level comparison table

Output:
Country-level counterfactual comparison of baseline vs alternative rule scenarios
*/

WITH base AS (
    SELECT
        country AS "Country",
        sa AS "SA",
        str AS "STR",
        budget_signal AS "Budget_Signal",
        blocking_constraint AS "Blocking_Constraint"
    FROM country_rules
),

scored AS (
    SELECT
        "Country",
        "SA",
        "STR",
        "Budget_Signal",
        "Blocking_Constraint",

        CASE
            WHEN "Budget_Signal" = 1 AND "Blocking_Constraint" = 0 THEN 1
            ELSE 0
        END AS "EX_base",

        CASE
            WHEN "SA" = 0 THEN 1
            WHEN "SA" = 1 AND (
                "STR" = 0
                OR (
                    CASE
                        WHEN "Budget_Signal" = 1 AND "Blocking_Constraint" = 0 THEN 1
                        ELSE 0
                    END
                ) = 0
            ) THEN 2
            WHEN "SA" = 1 AND "STR" = 1 AND (
                CASE
                    WHEN "Budget_Signal" = 1 AND "Blocking_Constraint" = 0 THEN 1
                    ELSE 0
                END
            ) = 1 THEN 3
        END AS "Level_base",

        CASE
            WHEN "SA" = 0 THEN 1
            WHEN "SA" = 1 AND (
                "STR" = 0
                OR (
                    CASE
                        WHEN "Budget_Signal" = 1 AND 0 = 0 THEN 1
                        ELSE 0
                    END
                ) = 0
            ) THEN 2
            WHEN "SA" = 1 AND "STR" = 1 AND (
                CASE
                    WHEN "Budget_Signal" = 1 AND 0 = 0 THEN 1
                    ELSE 0
                END
            ) = 1 THEN 3
        END AS "Level_if_no_blocking_constraint",

        CASE
            WHEN "SA" = 0 THEN 1
            WHEN "SA" = 1 AND (
                "STR" = 0
                OR (
                    CASE
                        WHEN 1 = 1 AND "Blocking_Constraint" = 0 THEN 1
                        ELSE 0
                    END
                ) = 0
            ) THEN 2
            WHEN "SA" = 1 AND "STR" = 1 AND (
                CASE
                    WHEN 1 = 1 AND "Blocking_Constraint" = 0 THEN 1
                    ELSE 0
                END
            ) = 1 THEN 3
        END AS "Level_if_budget_signal_on",

        CASE
            WHEN "SA" = 0 THEN 1
            WHEN "SA" = 1 AND (
                "STR" = 0
                OR (
                    CASE
                        WHEN 1 = 1 AND 0 = 0 THEN 1
                        ELSE 0
                    END
                ) = 0
            ) THEN 2
            WHEN "SA" = 1 AND "STR" = 1 AND (
                CASE
                    WHEN 1 = 1 AND 0 = 0 THEN 1
                    ELSE 0
                END
            ) = 1 THEN 3
        END AS "Level_if_budget_on_and_no_block"

    FROM base
)

SELECT *
FROM scored
ORDER BY "Level_base", "Country";
