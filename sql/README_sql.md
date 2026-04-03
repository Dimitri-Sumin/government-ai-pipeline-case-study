# SQL Analytical Layer

This folder contains the SQL layer used to transform lead-level pipeline data into country-level analytical outputs, apply institutional rule-based classification, and evaluate scenario-based changes in country prioritization.

## Structure

- `00_load_data.sql`  
  Creates tables and loads CSV data into PostgreSQL.

- `01_country_pipeline_base.sql`  
  Builds the main country-level analytical table by aggregating leads, joining institutional rule inputs, deriving execution capacity (`ex`), assigning `predicted_level`, and mapping countries into business priority segments.

- `02_priority_volume.sql`  
  Summarizes the distribution of countries and leads across business priority segments.

- `03_priority_stage_depth.sql`  
  Compares average and maximum pipeline depth by priority segment.

- `04_priority_conversion.sql`  
  Measures final-stage reach rate by priority segment.

- `05_validation_checks.sql`  
  Runs data consistency, model coverage, and rule integrity checks.

- `06_truth_table.sql`  
  Generates the full truth table for the institutional rule-based model across all possible binary input combinations.

- `07_counterfactuals.sql`  
  Evaluates how country-level predicted levels change under alternative institutional scenarios, such as removing blocking constraints or switching budget signals on.

## Execution Order

Run scripts in the following order:

1. `00_load_data.sql`
2. `01_country_pipeline_base.sql`
3. `02_priority_volume.sql`
4. `03_priority_stage_depth.sql`
5. `04_priority_conversion.sql`
6. `05_validation_checks.sql`
7. `06_truth_table.sql`
8. `07_counterfactuals.sql`

## Logic Overview

The institutional rule-based model uses four binary input variables:

- `sa`
- `str`
- `budget_signal`
- `blocking_constraint`

Execution capacity is derived as:

- `ex = 1` if `budget_signal = 1` and `blocking_constraint = 0`
- otherwise `ex = 0`

Predicted institutional level is assigned as:

- `Level 1` if `sa = 0`
- `Level 2` if `sa = 1` and (`str = 0` or `ex = 0`)
- `Level 3` if `sa = 1` and `str = 1` and `ex = 1`

Business priority is mapped as:

- `Delayed` if `blocking_constraint = 1`
- `Focus` if `predicted_level = 'Level 3'`
- `Nurture` if `predicted_level = 'Level 2'`
- `Low Priority` if `predicted_level = 'Level 1'`

## Notes

- `"won"` represents reaching the final pipeline stage, not necessarily a successfully closed deal.
- `04_priority_conversion.sql` measures final-stage reach rate, not strict commercial win rate.
- `06_truth_table.sql` is a full logical enumeration of the model and is useful for transparency and validation.
- `07_counterfactuals.sql` is used to test how priority-relevant conditions change under alternative institutional assumptions.
- All queries are written for PostgreSQL.
