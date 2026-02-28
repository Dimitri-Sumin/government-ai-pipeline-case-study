Institutional AI Readiness Model
Rule-Based Configurational Approach to National AI Commitment
Overview

This repository presents a rule-based institutional model designed to explain when national-level AI programs reach strategic commitment.

The framework formalizes institutional conditions frequently observed in public-sector AI initiatives and translates them into a transparent, reproducible analytical model implemented in Python.

The focus is institutional feasibility rather than market demand or predictive modeling.

Research Question

What institutional conditions are necessary for a country to reach strategic commitment in national-level AI programs?

Conceptual Framework

The model follows a configurational logic rather than additive scoring.

Strategic commitment is not treated as a cumulative index.
Instead, it emerges only when specific institutional conditions are jointly satisfied.

The framework operationalizes three core dimensions:

SA (Senior Access) — direct access to senior decision-makers capable of strategic authorization

STR (Formal Strategy) — existence of a formal national AI strategy

EX (Execution Capacity) — ability to operationalize AI initiatives

Execution capacity is derived from two observable signals:

Budget_Signal — presence of an explicit funding or budget commitment

Blocking_Constraint — presence of structural, governance, or institutional barriers

Execution capacity is defined as:

EX = 1 if Budget_Signal = 1 AND Blocking_Constraint = 0
Otherwise EX = 0

Classification Logic

The model applies strict necessary-condition reasoning:

Level 1 → SA = 0

Level 2 → SA = 1 AND (STR = 0 OR EX = 0)

Level 3 → SA = 1 AND STR = 1 AND EX = 1

This structure reflects conjunctural causality:
absence of any required condition prevents the highest level of institutional commitment.

Methodological Positioning

This is not a predictive ML model and does not rely on regression or scoring techniques.

Instead, it:

Applies necessary-condition logic

Uses transparent binary institutional signals

Explicitly maps conceptual assumptions to operational rules

Enables structural diagnostics rather than probabilistic prediction

The approach is structurally closer to institutional analysis and QCA-style reasoning than to additive scoring models.

Implementation

The repository includes:

A full truth table covering all possible institutional configurations

A classification script applying the rule-based logic

A counterfactual analysis module identifying binding constraints

Reproducible results generated from structured CSV inputs

The logic is implemented in Python and can be applied to any dataset structured around the defined institutional variables.

Counterfactual Analysis

Beyond static classification, the model includes a counterfactual layer to identify binding institutional constraints.

For each case, the framework evaluates:

Baseline predicted level

Level if blocking constraints were removed

Level if budget signals were activated

Level if both constraints were resolved

This allows identification of the specific bottleneck preventing advancement:

Senior Access Constraint
If SA = 0, no other institutional adjustments change the level.

Budget Constraint
Removing governance barriers does not shift commitment without explicit funding signals.

Governance Constraint
In some systems, eliminating structural barriers immediately enables Level 3.

This demonstrates that national AI commitment is conjunctural rather than additive.
Strategic advancement requires joint institutional alignment.

Repository Structure
data/      Example input dataset (anonymized)
src/       Model scripts (classification, truth table, counterfactuals)
outputs/   Generated analytical outputs (optional, excluded via .gitignore)
README.md  Project documentation
Data Note

Data examples are simplified and anonymized for structural demonstration purposes.
The model operates exclusively on abstract institutional indicators and does not rely on confidential or proprietary information.

How to Run

Install dependencies:

pip install -r requirements.txt

Run the truth table:

python src/truth_table.py

Run counterfactual analysis:

python src/counterfactuals.py

Purpose

This project demonstrates:

Translation of qualitative institutional insight into formal logic

Clear operationalization of strategic conditions

Reproducible rule-based analytical modeling

Diagnostic identification of structural constraints

The project moves beyond scoring approaches and offers a transparent, rule-based diagnostic framework for institutional AI readiness.
