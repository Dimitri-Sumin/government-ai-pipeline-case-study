# SQL Analytical Layer

This folder contains the SQL layer used to transform lead-level data into country-level analytical outputs and evaluate pipeline performance.

## Structure

- 00_load_data.sql  
  Creates tables and loads CSV data into PostgreSQL

- 01_country_priority_base.sql  
  Builds country-level dataset with classification and priority assignment

- 02_priority_volume.sql  
  Distribution of countries across priority segments

- 03_priority_stage_depth.sql  
  Average progression (max stage) by priority

- 04_priority_conversion.sql  
  Final-stage reach rate by priority segment

- 05_validation_checks.sql  
  Data consistency and model integrity checks

## Execution Order

Run scripts in the following order:

1. 00_load_data.sql  
2. 01_country_priority_base.sql  
3. 02_priority_volume.sql  
4. 03_priority_stage_depth.sql  
5. 04_priority_conversion.sql  
6. 05_validation_checks.sql  

## Notes

- "won" represents reaching the final stage, not necessarily a successfully closed deal
- All queries are designed for PostgreSQL
