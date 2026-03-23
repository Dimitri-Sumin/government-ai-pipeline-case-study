Institutional AI Readiness Model  
Rule-Based Configurational Approach to National AI Commitment  

# Government AI Pipeline Case Study

## Overview

This repository presents a rule-based institutional model designed to explain when national-level AI programs reach strategic commitment.  
Analytical case study based on a real institutional AI pipeline involving government-level engagements.

The framework formalizes institutional conditions frequently observed in public-sector AI initiatives and translates them into a transparent, reproducible analytical model implemented in Python.  
The project focuses on transforming raw lead data into a structured, explainable model for prioritization and strategic decision-making.

The focus is institutional feasibility rather than market demand or predictive modeling.

## Objective

What institutional conditions are necessary for a country to reach strategic commitment in national-level AI programs?  

To design a rule-based analytical framework that evaluates country-level AI readiness and supports prioritization of opportunities in a government AI pipeline.

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

The dataset contains structured information about government leads across multiple countries and reflects real B2G pipeline activity aggregated into country-level signals.

- country  
- stage (outreach, engagement, meeting, proposal)  
- stage_order  
- deal progression indicators (won, is_closed)  

Main file:  
data/clean_dataset.xlsx  

## Methodology

The analysis is built in two layers:

### 1. Data aggregation

Lead-level data is aggregated to the country level:

- number of leads  
- maximum stage reached  
- engagement intensity  

This allows moving from individual deals to country-level signals.

### 2. Rule-based readiness model

A structured rule-based layer translates qualitative signals into analytical variables:

- SA (Senior Access)  
- STR (Formal Strategy)  
- Budget_Signal  
- Blocking_Constraint  

Defined in:  
data/country_rules.csv  

These variables are used to classify countries into readiness segments.

## Classification Logic

The model applies strict necessary-condition reasoning:

Level 1 → SA = 0  
Level 2 → SA = 1 AND (STR = 0 OR EX = 0)  
Level 3 → SA = 1 AND STR = 1 AND EX = 1  

Level 2 represents partial readiness where access exists but either strategic alignment or execution capacity is missing.

This structure reflects conjunctural causality:  
absence of any required condition prevents the highest level of institutional commitment.

## Priority Logic

Final prioritization follows a hierarchical override logic:

- Blocking constraint overrides everything → Delayed  
- Level 3 → Focus  
- Level 2 → Nurture  
- Level 1 → Low Priority  

This creates a transparent decision framework rather than a black-box model.

## Output

The model produces a country-level prioritization:

- Focus  
- Nurture  
- Delayed  
- Low Priority  

This can be used to:

- guide sales strategy  
- allocate resources  
- identify high-potential markets  

## Pipeline Priority Analysis

Detailed segmentation of pipeline performance across priority groups.

### Pipeline Progression by Priority Segment

![Progression](outputs/priority_analysis/progression_by_priority.png)

Average stage reached per segment:

- Focus → 2.55  
- Nurture → 2.13  
- Low Priority → 1.78  
- Delayed → 1.62  

Focus countries reach significantly higher progression compared to Low Priority (+43%), confirming alignment between institutional readiness and pipeline advancement.

Nurture shows intermediate progression, while Delayed and Low Priority stall early.

### Pipeline Volume by Priority Segment

![Volume](outputs/priority_analysis/volume_by_priority.png)

Number of leads per segment:

- Focus → 273  
- Nurture → 237  
- Delayed → 108  
- Low Priority → 51  

Focus and Nurture dominate pipeline volume.

Delayed shows meaningful volume with limited progression, indicating structural bottlenecks rather than lack of engagement.

### Stage Conversion Analysis

To understand where pipeline progression breaks down, stage-to-stage conversion rates were analyzed.

Key patterns:

- High-priority segments (Focus, Nurture) show consistent conversion across stages  
- Low Priority shows early drop-off between outreach and engagement  
- Delayed segments demonstrate stalled conversion at later stages (proposal → won)  

This confirms that pipeline inefficiency is not uniform:

- Low Priority fails at early qualification  
- Delayed fails at execution and commitment stages  

### Interpretation

Combining progression, volume, and conversion reveals a structural pattern:

- Focus → high progression, strong conversion, high volume → core strategic targets  
- Nurture → moderate progression and conversion → development potential  
- Delayed → volume present but blocked at late stages → execution constraints  
- Low Priority → early drop-off and low progression → structurally weak segment  

Pipeline performance is strongly driven by institutional conditions rather than random variation.

## Key Insight

The pipeline is structurally inefficient:

- 84% of countries fall into Low Priority  
- These countries generate minimal progression  
- Most meaningful advancement is concentrated in a small subset of countries  

This indicates resource dilution across structurally unviable segments rather than lack of pipeline activity.

## Methodological Positioning

This is not a predictive ML model and does not rely on regression or scoring techniques.

Instead, it:

- applies necessary-condition logic  
- uses transparent binary institutional signals  
- explicitly maps conceptual assumptions to operational rules  
- enables structural diagnostics rather than probabilistic prediction  

The approach is structurally closer to institutional analysis and QCA-style reasoning than to additive scoring models.

## Implementation

The repository includes:

- a full truth table covering all possible institutional configurations  
- a classification script applying the rule-based logic  
- a counterfactual analysis module identifying binding constraints  
- reproducible results generated from structured CSV inputs  

The logic is implemented in Python and can be applied to any dataset structured around the defined institutional variables.

## Counterfactual Analysis

Beyond static classification, the model includes a counterfactual layer to identify binding institutional constraints.

For each case, the framework evaluates:

- baseline predicted level  
- level if blocking constraints were removed  
- level if budget signals were activated  
- level if both constraints were resolved  

This allows identification of the specific bottleneck preventing advancement.

- Senior Access Constraint  
  If SA = 0, no other institutional adjustments change the level  

- Budget Constraint  
  Removing governance barriers does not shift commitment without explicit funding signals  

- Governance Constraint  
  In some systems, removing structural barriers enables progression  

This demonstrates that national AI commitment is conjunctural rather than additive.  
Strategic advancement requires joint institutional alignment.

## Repository Structure

data/      Example input dataset (anonymized)  
src/       Model scripts (classification, truth table, counterfactuals)  
outputs/   Generated analytical outputs (optional, excluded via .gitignore)  
README.md  Project documentation  

## Tech Stack

- Excel (data structuring, pivot analysis)  
- Python (rule-based modeling, counterfactual analysis)  
- GitHub (project structure and documentation)  

## Data Note

The dataset is derived from real B2G pipeline activity and has been anonymized and transformed for analytical use.

Sensitive and identifying elements have been removed, while preserving the structural characteristics necessary for modeling institutional dynamics.

## How to Run

Install dependencies:

pip install -r requirements.txt  

Run the truth table:

python src/truth_table.py  

Run counterfactual analysis:

python src/counterfactuals.py  

## Purpose

This project demonstrates:

- translation of qualitative institutional insight into formal logic  
- clear operationalization of strategic conditions  
- reproducible rule-based analytical modeling  
- diagnostic identification of structural constraints  

The project offers a transparent, rule-based framework for analyzing institutional AI readiness.

## Author

Dimitri Suminov
