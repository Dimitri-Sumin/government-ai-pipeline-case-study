# Government AI Pipeline Case Study

Analytical case study based on a real institutional AI pipeline involving government-level engagements.

The project focuses on transforming raw lead data into a structured, explainable model for prioritization and strategic decision-making.

---

## Objective

To design a rule-based analytical framework that evaluates country-level AI readiness and supports prioritization of opportunities in a government AI pipeline.

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

---

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

## Tech Stack

- Excel (data structuring, pivot analysis)  
- Rule-based modeling  
- GitHub (project structure and documentation)  

---

## Project Structure

data/  
  clean_dataset.xlsx  
  country_rules.csv  

src/  
  (analysis scripts – optional)  

README.md  

---

## Author

Dmytro Suminov
