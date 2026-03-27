# Institutional AI Readiness Model  
Rule-Based Configurational Approach to National AI Commitment  

# Government AI Pipeline Case Study

## Overview

This repository presents a rule-based institutional model designed to explain when national-level AI programs reach strategic commitment.  
Analytical case study based on generalized patterns observed across public-sector AI engagements.

The framework formalizes institutional conditions frequently observed in public-sector AI initiatives and translates them into a transparent, reproducible analytical model.  
The project focuses on transforming structured engagement signals into an explainable model for prioritization and strategic decision-making.

The focus is institutional feasibility rather than market demand or predictive modeling.

## Objective

What institutional conditions are necessary for a country to reach strategic commitment in national-level AI programs?  

To design a rule-based analytical framework that evaluates country-level AI readiness and supports prioritization of opportunities in public-sector AI contexts.

## Country Priority Distribution

![Priority Summary](priority_summary.png)

The distribution is heavily skewed toward the Low priority segment:

- 77 countries (~84%) fall into Low Priority  
- 9 countries are classified as Nurture  
- 4 countries reach Focus  
- 2 countries are Delayed  

This indicates a structurally imbalanced pipeline where most countries do not meet the institutional conditions required for progression.

## Conceptual Framework

The model follows a configurational logic rather than additive scoring.

Strategic commitment is not treated as a cumulative index.  
Instead, it emerges only when specific institutional conditions are jointly satisfied.

The framework operationalizes three core dimensions:

- SA (Senior Access) — direct access to senior decision-makers capable of strategic authorization  
- STR (Formal Strategy) — existence of a formal national AI strategy  
- EX (Execution Capacity) — ability to operationalize AI initiatives  

Execution capacity is derived from two observable signals:

- Budget_Signal — presence of an explicit funding or budget commitment  
- Blocking_Constraint — presence of structural, governance, or institutional barriers  

Execution capacity is defined as:

EX = 1 if Budget_Signal = 1 AND Blocking_Constraint = 0  
Otherwise EX = 0  

Execution capacity is contingent on both funding availability and absence of structural barriers.

## Dataset

The dataset contains structured information about public-sector engagement activity across multiple countries, aggregated into country-level signals.

- country  
- stage (outreach, engagement, meeting, proposal, won)  
- stage_order  
- won (final stage reached indicator)  
- is_closed  

Main files:

- data/clean_dataset.csv  
- data/country_rules.csv  

## Methodology

The analysis is built in two layers:

### 1. Data aggregation (SQL layer)

Lead-level data is aggregated to the country level:

- number of leads  
- stage distribution  
- maximum stage reached  
- final-stage counts  

Implemented in:

- sql/01_country_priority_base.sql  

### 2. Rule-based readiness model

A structured rule-based layer translates qualitative signals into analytical variables:

- SA (Senior Access)  
- STR (Formal Strategy)  
- Budget_Signal  
- Blocking_Constraint  

Execution capacity:

EX = 1 if Budget_Signal = 1 AND Blocking_Constraint = 0  

Classification:

- Level 1 → SA = 0  
- Level 2 → SA = 1 AND (STR = 0 OR EX = 0)  
- Level 3 → SA = 1 AND STR = 1 AND EX = 1  

Priority logic:

- Blocking_Constraint = 1 → Delayed  
- Level 3 → Focus  
- Level 2 → Nurture  
- Else → Low Priority  

## SQL Analytical Layer

The SQL layer provides structured diagnostics and validation.

### Priority Volume

- sql/02_priority_volume.sql  
- Measures distribution of countries across priority segments  

### Priority Performance

- sql/03_priority_performance.sql  
- Average progression and stage depth by priority  

### Priority Conversion

- sql/04_priority_conversion.sql  

Final-stage reach rate:

final_stage_rate = won_count / total_leads  

Important:

"won" represents reaching the final stage, not necessarily a successfully closed deal.

Observed results:

- Focus → 0.0183  
- Nurture → 0.0042  
- Low Priority → 0  
- Delayed → 0  

Clear separation between structurally viable and non-viable segments.

### Validation Checks

- sql/05_validation_checks.sql  

Ensures:

- full country coverage  
- no missing joins  
- no duplicate rules  
- classification integrity  

## Pipeline Priority Analysis

### Progression

![Progression](outputs/priority_analysis/progression_by_priority.png)

Average stage reached:

- Focus → 2.55  
- Nurture → 2.13  
- Low Priority → ~1.6–1.7  
- Delayed → ~1.6  

Focus countries show materially deeper pipeline progression.

### Volume

![Volume](outputs/priority_analysis/volume_by_priority.png)

- Focus → 273 leads  
- Nurture → 237  
- Delayed → 102  
- Low Priority → 57  

Pipeline is concentrated in higher-priority segments.

### Conversion Interpretation

- Focus → reaches final stage consistently  
- Nurture → occasional progression to final stage  
- Delayed → structurally blocked at later stages  
- Low Priority → fails early  

Pipeline inefficiency is structural, not random.

## Key Insight

The pipeline is structurally inefficient:

- ~84% of countries fall into Low Priority  
- These countries generate minimal progression  
- Meaningful advancement is concentrated in a small subset  

This reflects misallocation of effort rather than lack of activity.

## Methodological Positioning

This is not a predictive ML model.

It:

- uses necessary-condition logic  
- applies binary institutional signals  
- is fully explainable  
- supports structural diagnostics  

The approach is closer to institutional analysis and QCA than to scoring models.

## Counterfactual Analysis

The model evaluates how changes in constraints affect outcomes:

- removing blocking constraints  
- activating budget signals  
- combined adjustments  

Findings:

- SA is a hard constraint  
- Budget is required for execution  
- Removing governance barriers alone is insufficient without funding  

Strategic commitment requires joint institutional alignment.

## Repository Structure

- data/ — input datasets (anonymized)  
- sql/ — SQL analytical layer  
- src/ — Python model and scripts  
- outputs/ — charts and analytical outputs  
- README.md — project documentation  

## Tech Stack

- Excel — data structuring  
- PostgreSQL — analytical SQL layer  
- Python — rule-based modeling and counterfactual analysis  
- GitHub — documentation and reproducibility  

## Data Note

The dataset is an analytical reconstruction based on generalized patterns observed across public-sector engagements.  
It is anonymized and does not represent any specific organization’s operational pipeline.

## How to Run

Install dependencies:

pip install -r requirements.txt

Run the model:

python src/model_rules.py

Generate truth table:

python src/truth_table.py

Run counterfactual analysis:

python src/counterfactuals.py
