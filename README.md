nstitutional AI Readiness Model
Rule-Based Configurational Approach to National AI Commitment
Overview

This repository presents a rule-based institutional model designed to explain when national-level AI programs reach strategic commitment.

The framework formalizes institutional conditions observed in real-world B2G engagements and translates them into a transparent, reproducible analytical model implemented in Python.

The focus is institutional feasibility rather than market demand.

Research Question

What institutional conditions are necessary for a country to reach strategic commitment in national-level AI programs?

Conceptual Logic

The model follows a configurational rather than additive approach.

Strategic commitment is not treated as a cumulative score.
Instead, it emerges only when specific institutional conditions are jointly satisfied.

Core assumptions:

Senior decision access determines whether AI discussions become strategic.

A formal national AI strategy signals institutional seriousness.

Execution capacity depends on both budget signals and absence of structural blocking constraints.

Execution capacity is defined as:

EX = 1 if Budget_Signal = 1 AND Blocking_Constraint = 0
Otherwise EX = 0

Predicted levels follow strict logical rules:

Level 1 → SA = 0

Level 2 → SA = 1 AND (STR = 0 OR EX = 0)

Level 3 → SA = 1 AND STR = 1 AND EX = 1

All theoretical assumptions are explicitly mapped to operational rules.

Implementation

The repository includes:

A full truth table covering all possible institutional configurations

A classification script applying the rule-based model

A counterfactual analysis layer identifying binding constraints

Reproducible outputs generated from structured CSV inputs

The logic is implemented in Python and can be applied to any dataset structured around the defined institutional variables.

Counterfactual Analysis

Beyond static classification, the model includes a counterfactual layer to identify binding institutional constraints.

For each country, the script evaluates:

Baseline predicted level

Level if blocking constraints were removed

Level if budget signals were activated

Level if both constraints were resolved

This allows the framework to distinguish between different structural bottlenecks:

Senior access constraint
If SA = 0, no combination of budget or governance adjustments shifts the country beyond Level 1.

Budget constraint
In some cases, removing governance friction does not change the level unless a formal budget signal is present.

Governance constraint
Some countries reach Level 3 immediately once blocking institutional constraints are removed.

This demonstrates that national AI commitment is conjunctural rather than additive.
Strategic advancement requires the joint presence of institutional conditions, and progress depends on which specific constraint is binding.

Repository Structure
data/            Input datasets (anonymized examples)
src/             Model scripts (truth table + counterfactual analysis)
outputs/         Generated analytical outputs
README.md        Project description
Purpose

This project demonstrates:

Translation of qualitative institutional insight into formal logic

Clear operationalization of strategic conditions

Reproducible rule-based analytical modeling

Transparent classification framework

The project therefore moves beyond scoring and offers a transparent, rule-based diagnostic framework for institutional AI readiness.
