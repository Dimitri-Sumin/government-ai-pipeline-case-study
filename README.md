Institutional AI Readiness Model

Rule-Based Configurational Approach to National AI Commitment

Overview

This repository presents a rule-based institutional model designed to explain when national-level AI programs reach strategic commitment.

The project formalizes institutional conditions observed in real-world B2G engagements and translates them into a transparent, reproducible analytical framework implemented in Python.

The focus is institutional feasibility rather than market demand.

Research Question

What institutional conditions are necessary for a country to reach strategic commitment in national-level AI programs?

Conceptual Model

The model assumes configurational logic rather than additive scoring.

Strategic commitment occurs only when three institutional conditions are jointly present:

SA — Senior decision access

STR — Formal national AI strategy

EX — Execution capacity

Execution capacity is operationalized as:

EX = 1 if Budget_Signal = 1 AND Blocking_Constraint = 0
EX = 0 otherwise

Absence of any required condition prevents Level 3 commitment.

Level Classification

Level 1
SA = 0

No senior institutional access.

Level 2
SA = 1 AND (STR = 0 OR EX = 0)

Senior access exists, but strategic or execution conditions are incomplete.

Level 3
SA = 1 AND STR = 1 AND EX = 1

Full institutional configuration enabling strategic national AI commitment.

Repository Structure

AI_Readiness_Project/

data/
 country_rules.csv

src/
 model_rules.py

outputs/
 predictions.csv

README.md

How to Run

Create environment:

conda create -n ai-readiness python=3.11 -y
conda activate ai-readiness
pip install pandas

Run:

python src/model_rules.py

Output:

outputs/predictions.csv

Sample Output

Country | SA | STR | EX | Predicted_Level
Uzbekistan | 1 | 0 | 1 | 2
Saudi Arabia | 1 | 1 | 1 | 3
Malaysia | 1 | 1 | 0 | 2
Montenegro | 0 | 0 | 0 | 1
Ukraine | 1 | 1 | 0 | 2

Methodological Positioning

This model applies necessary-condition logic:

Without senior access → no strategic commitment

Without execution capacity → no Level 3

Without formal strategy → no Level 3

The structure aligns with configurational reasoning and institutional analysis rather than regression-based scoring approaches.

All theoretical assumptions are explicitly mapped to operational rules.

Practical Context

The framework is informed by direct engagement with national-level stakeholders in AI initiatives across multiple regions.

Observed patterns consistently showed:

Senior decision access determines whether AI discussions become strategic.

Formal national strategy signals institutional seriousness and budget alignment.

Execution capacity is frequently constrained by structural or governance bottlenecks.

This repository formalizes those institutional dynamics into a structured analytical model.

Purpose

This project demonstrates:

Translation of qualitative institutional insight into formal logic

Clear operationalization of strategic conditions

Reproducible Python-based analytical pipeline

Transparent classification framework
