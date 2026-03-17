Institutional AI Readiness Model  
Rule-Based Configurational Approach to National AI Commitment  

# Government AI Pipeline Case Study

## Overview

This repository presents a rule-based institutional model designed to explain when national-level AI programs reach strategic commitment.  
Analytical case study based on a real institutional AI pipeline involving government-level engagements.

The framework formalizes institutional conditions frequently observed in public-sector AI initiatives and translates them into a transparent, reproducible analytical model implemented in Python.  
The project focuses on transforming raw lead data into a structured, explainable model for prioritization and strategic decision-making.

The focus is institutional feasibility rather than market demand or predictive modeling.

---

## Objective

What institutional conditions are necessary for a country to reach strategic commitment in national-level AI programs?  

To design a rule-based analytical framework that evaluates country-level AI readiness and supports prioritization of opportunities in a government AI pipeline.

---

## Country Priority Distribution

![Priority Summary](priority_summary.png)

The distribution is heavily skewed toward the Low priority segment (~84%), indicating a structurally unbalanced pipeline and potential inefficiencies in targeting and qualification.

---

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

---

## Dataset

The dataset contains structured information about government leads across multiple countries, including:

- country  
- stage (outreach, engagement, meeting, proposal)  
- stage_order  
- deal progression indicators (won, is_closed)  

Main file:  
data/clean_dataset.xlsx  

---

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

- SA (Strategic Alignment)  
- STR (Stakeholder Readiness)  
- Budget_Signal  
- Blocking_Constraint  

Defined in:  
data/country_rules.csv  

These variables are used to classify countries into readiness segments.

---

## Classification Logic

The model applies strict necessary-condition reasoning:

Level 1 → SA = 0  
Level 2 → SA = 1 AND (STR = 0 OR EX = 0)  
Level 3 → SA = 1 AND STR = 1 AND EX = 1  

This structure reflects conjunctural causality:  
absence of any required condition prevents the highest level of institutional commitment.

---

## Priority Logic

Final prioritization is based on a simple but explainable logic:

- Blocking constraint (e.g. budget) overrides everything → Delayed  
- High readiness → Focus  
- Medium readiness → Nurture  
- Low readiness → Low Priority  

This creates a transparent decision framework rather than a black-box model.

---

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

---

## Key Insight

The project demonstrates how qualitative signals (political context, budget constraints, engagement level) can be formalized into a structured analytical model.

---

## Methodological Positioning

This is not a predictive ML model and does not rely on regression or scoring techniques.

Instead, it:

- applies necessary-condition logic  
- uses transparent binary institutional signals  
- explicitly maps conceptual assumptions to operational rules  
- enables structural diagnostics rather than probabilistic prediction  

The approach is structurally closer to institutional analysis and QCA-style reasoning than to additive scoring models.

---

## Implementation

The repository includes:

- a full truth table covering all possible institutional configurations  
- a classification script applying the rule-based logic  
- a counterfactual analysis module identifying binding constraints  
- reproducible results generated from structured CSV inputs  

The logic is implemented in Python and can be applied to any dataset structured around the defined institutional variables.

---

## Counterfactual Analysis

Beyond static classification, the model includes a counterfactual layer to identify binding institutional constraints.

For each case, the framework evaluates:

- baseline predicted level  
- level if blocking constraints were removed  
- level if budget signals were activated  
- level if both constraints were resolved  

This allows identification of the specific bottleneck preventing advancement:

- Senior Access Constraint  
  If SA = 0, no other institutional adjustments change the level  

- Budget Constraint  
  Removing governance barriers does not shift commitment without explicit funding signals  

- Governance Constraint  
  In some systems, eliminating structural barriers immediately enables Level 3  

This demonstrates that national AI commitment is conjunctural rather than additive.  
Strategic advancement requires joint institutional alignment.

---

## Repository Structure

data/      Example input dataset (anonymized)  
src/       Model scripts (classification, truth table, counterfactuals)  
outputs/   Generated analytical outputs (optional, excluded via .gitignore)  
README.md  Project documentation  

---

## Tech Stack

- Excel (data structuring, pivot analysis)  
- Rule-based modeling  
- GitHub (project structure and documentation)  

---

## Data Note

Data examples are simplified and anonymized for structural demonstration purposes.  
The model operates exclusively on abstract institutional indicators and does not rely on confidential or proprietary information.

---

## How to Run

Install dependencies:

pip install -r requirements.txt  

Run the truth table:

python src/truth_table.py  

Run counterfactual analysis:

python src/counterfactuals.py  

---

## Purpose

This project demonstrates:

- translation of qualitative institutional insight into formal logic  
- clear operationalization of strategic conditions  
- reproducible rule-based analytical modeling  
- diagnostic identification of structural constraints  

The project moves beyond scoring approaches and offers a transparent, rule-based diagnostic framework for institutional AI readiness.

---

## Author

Dmytro Suminov
