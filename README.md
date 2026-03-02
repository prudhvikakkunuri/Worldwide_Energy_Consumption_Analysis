![SQL](https://img.shields.io/badge/SQL-Structured_Query_Language-blue)
![Data Analysis](https://img.shields.io/badge/Data-Analysis-green)
![Energy Analytics](https://img.shields.io/badge/Domain-Energy_Analytics-orange)
![Emissions](https://img.shields.io/badge/Focus-Carbon_Emissions-red)
![Global Dataset](https://img.shields.io/badge/Scope-Global-lightgrey)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

# Global Energy Consumption & Carbon Emission Analysis (SQL)

## Project Overview
This project analyzes global energy production, energy consumption, carbon emissions, GDP, and population data using SQL.  
The goal is to understand how energy usage, economic growth, and emissions are related across countries and over time.

The analysis focuses on identifying patterns, trends, efficiency, and country-level differences using structured SQL queries.

---

## Business Context
Energy demand is increasing globally due to population growth and economic development.  
At the same time, carbon emissions from energy usage are a major environmental concern.

This project demonstrates how data analysis using SQL can support better energy planning, efficiency evaluation, and emission management.

---

## Dataset Description
The project uses multiple country-level datasets, including:

- **Country** – List of countries (master reference)
- **Population** – Population data by country and year
- **GDP** – Economic data by country and year
- **Energy Production** – Energy produced by source and year
- **Energy Consumption** – Energy consumed by source and year
- **Emissions** – Carbon emissions by source, country, and year

All datasets are linked using the **country** field, and the **year** column is used for time-based analysis.

---

## Database Design
A structured database schema was designed to organize the data efficiently.

- The **country table** acts as the central reference table.
- Other tables (population, GDP, production, consumption, emissions) are connected using the country field.
- This design avoids data duplication and supports accurate SQL joins and analysis.

---

## Objectives
- Design a structured database schema for global energy data
- Analyze energy production and consumption patterns
- Study carbon emission trends across countries
- Compare economic growth with emission levels
- Evaluate energy efficiency using ratio-based analysis
- Identify countries that have improved emission performance over time

---

## Key Analysis Questions
- What is the total emission per country in the most recent year?
- Which countries have the highest GDP?
- How does energy production compare with consumption?
- Which energy sources contribute most to emissions?
- How have global emissions changed over time?
- Has energy consumption increased in major economies?
- What is the emission-to-GDP ratio by country?
- Which countries have reduced per-capita emissions?
- What is the global emission share by country?

---

## Key Insights
- Global emissions are concentrated in a small number of countries.
- Energy usage, economic growth, and emissions are strongly connected.
- Coal and coke contribute significantly to emissions among energy sources.
- Some countries demonstrate that emissions can be reduced through better efficiency and planning.

---
## Use Cases

- Identifying high-emission countries for policy intervention  
- Comparing energy efficiency across economies  
- Supporting sustainability and climate reporting  
- Analyzing emission trends for long-term planning  
- Academic and research-oriented energy studies

---
## Conclusion
This project shows how SQL can be used to transform raw global energy data into meaningful insights.  
The analysis highlights the relationship between energy usage, economic growth, and emissions, and supports data-driven decision-making for sustainable energy and emission management.

---

## Author
**Bhanu Sai Prakash Bandaru**  
