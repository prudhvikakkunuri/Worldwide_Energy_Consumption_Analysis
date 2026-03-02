CREATE DATABASE ENERGY;

USE ENERGY;

# country table 
CREATE TABLE country ( 
CID VARCHAR(10) PRIMARY KEY, 
Country VARCHAR(100) UNIQUE 
); 

SELECT * FROM COUNTRY;

#emission_3 table 
CREATE TABLE emission_3 ( 
country VARCHAR(100), 
energy_type VARCHAR(50), 
year INT, 
emission INT, 
per_capita_emission DOUBLE, 
FOREIGN KEY (country) REFERENCES country(Country) 
);
SELECT * FROM EMISSION_3;


#population table 
CREATE TABLE population ( 
countries VARCHAR(100), 
year INT, 
Value DOUBLE, 
FOREIGN KEY (countries) REFERENCES country(Country) 
);
SELECT * FROM POPULATION;

#production table 
CREATE TABLE production ( 
country VARCHAR(100), 
energy VARCHAR(50), 
year INT, 
production INT, 
FOREIGN KEY (country) REFERENCES country(Country) 
); 
SELECT * FROM PRODUCTION;

#gdp_3 table 
CREATE TABLE gdp_3 ( 
Country VARCHAR(100), 
year INT, 
Value DOUBLE, 
FOREIGN KEY (Country) REFERENCES country(Country) 
); 
SELECT * FROM GDP_3;
#consumption table 
CREATE TABLE consumption ( 
country VARCHAR(100), 
energy VARCHAR(50), 
year INT, 
consumption INT, 
FOREIGN KEY (country) REFERENCES country(Country) 
);
SELECT * FROM CONSUMPTION;


-- Questions
-- General & Comparative Analysis
-- 1. What is the total emission per country for the most recent year available?
SELECT 
    country,
    year,
    SUM(emission) AS total_emission
FROM emission_3
WHERE year = 2023   
GROUP BY country,year
ORDER BY total_emission DESC;


-- 2.What are the top 5 countries by GDP in the most recent year?
SELECT 
    Country,
    year,
    Value AS GDP
FROM gdp_3
WHERE year = 2024   
ORDER BY GDP DESC
LIMIT 5;

-- 3. Compare energy production and consumption by country and year. 
SELECT 
    p.country,
    p.year,
    SUM(p.production) AS total_production,
    SUM(c.consumption) AS total_consumption
FROM production p
JOIN consumption c
    ON p.country = c.country
   AND p.year = c.year
GROUP BY p.country, p.year
ORDER BY p.country, p.year;

select * from consumption;
select * from production;

-- 4.Which energy types contribute most to emissions across all countries?
SELECT 
    energy_type,
    SUM(emission) AS total_emission
FROM emission_3
GROUP BY energy_type
ORDER BY total_emission DESC;

select * from emission_3;

-- Trend Analysis Over Time
-- 5.How have global emissions changed year over year?
SELECT 
    year,
    SUM(emission) AS total_global_emission
FROM emission_3
GROUP BY year
ORDER BY year;

-- 6.What is the trend in GDP for each country over the given years?

SELECT 
    Country,
    year,
    Value AS GDP
FROM gdp_3
ORDER BY Country, year;

select * from gdp_3;

-- 7.How has population growth affected total emissions in each country?

SELECT 
    p.countries AS country,
    p.year,
    p.value AS population,
    SUM(e.emission) AS total_emission
FROM
    population p
        JOIN
    emission_3 e ON p.countries = e.country
        AND p.year = e.year
GROUP BY p.countries , p.year , p.value
ORDER BY p.countries;


select * from emission_3;
select * from population;

-- 8.Has energy consumption increased or decreased over the years for major economies?

SELECT 
    country, year, SUM(consumption) AS total_consumption
FROM
    consumption
GROUP BY country , year
ORDER BY total_consumption DESC;

-- 9.What is the average yearly change in emissions per capita for each country?

SELECT 
    country,
    AVG(per_capita_emission) AS avg_per_capita_emission
    FROM emission_3
GROUP BY country;

-- Ratio & Per Capita Analysis
-- 10.What is the emission-to-GDP ratio for each country by year?

SELECT 
    e.country,
    e.year,
    SUM(e.emission) / g.Value AS emission_to_gdp_ratio
FROM emission_3 e
JOIN gdp_3 g
  ON e.country = g.Country
 AND e.year = g.year
GROUP BY e.country, e.year, g.Value
ORDER BY e.country, e.year;


-- 11.What is the energy consumption per capita for each country over the last decade?
-- remind this question
SELECT 
    c.country,
    c.year,
    SUM(c.consumption) / p.Value AS consumption_per_capita
FROM consumption c
JOIN population p
    ON c.country = p.countries
   AND c.year = p.year
GROUP BY c.country, c.year, p.Value
ORDER BY c.country, c.year;


-- 12.How does energy production per capita vary across countries?
SELECT 
    pr.country,
    SUM(pr.production) / SUM(p.Value) AS production_per_capita
FROM production pr
JOIN population p
    ON pr.country = p.countries
   AND pr.year = p.year
GROUP BY pr.country
ORDER BY production_per_capita DESC;


-- 13.Which countries have the highest energy consumption relative to GDP?

SELECT 
    c.country,
    SUM(c.consumption) / SUM(g.Value) AS consumption_to_gdp_ratio
FROM consumption c
INNER JOIN gdp_3 g
    ON c.country = g.Country
   AND c.year = g.year
GROUP BY c.country
ORDER BY consumption_to_gdp_ratio DESC
LIMIT 10;



-- 14.What is the correlation between GDP growth and energy production growth?
SELECT 
    g.Country AS country,
    g.year,
    g.Value AS GDP,
    SUM(p.production) AS total_production
FROM gdp_3 g
INNER JOIN production p
    ON g.Country = p.country
   AND g.year = p.year
GROUP BY g.Country, g.year, g.Value
ORDER BY g.Country, g.year;


-- Global Comparisons

-- 15.What are the top 10 countries by population and how do their emissions compare?
SELECT MAX(year) FROM population;
SELECT 
    p.countries AS country,
    p.Value AS population,
    SUM(e.emission) AS total_emission
FROM population p
INNER JOIN emission_3 e
    ON p.countries = e.country
   AND p.year = e.year
WHERE p.year = 2023
GROUP BY p.countries, p.Value
ORDER BY p.Value DESC
LIMIT 10;

-- 16.Which countries have improved (reduced) their per capita emissions the most over the last decade?

SELECT
    e.country,
    SUM(CASE WHEN e.year = 2022 THEN e.emission / p.Value END) AS previous_per_capita,
    SUM(CASE WHEN e.year = 2023 THEN e.emission / p.Value END) AS present_per_capita,
    SUM(CASE WHEN e.year = 2022 THEN e.emission / p.Value END) -
    SUM(CASE WHEN e.year = 2023 THEN e.emission / p.Value END) AS reduction
FROM emission_3 e
JOIN population p
  ON e.country = p.countries
 AND e.year = p.year
WHERE e.year IN (2022, 2023)
GROUP BY e.country
HAVING previous_per_capita > present_per_capita
ORDER BY reduction DESC;

-- 17.What is the global share (%) of emissions by country?
SELECT 
    country,
    SUM(emission) * 100 / 
    (SELECT SUM(emission) FROM emission_3) AS global_emission_share_percent
FROM emission_3
GROUP BY country
ORDER BY global_emission_share_percent DESC;


-- 18.What is the global average GDP, emission, and population by year?
SELECT 
    y.year,
    AVG(g.Value) AS global_avg_gdp,
    AVG(e.emission) AS global_avg_emission,
    AVG(p.Value) AS global_avg_population
FROM (
    SELECT DISTINCT year FROM gdp_3
) y
JOIN gdp_3 g
  ON y.year = g.year
JOIN emission_3 e
  ON y.year = e.year
 AND g.Country = e.country
JOIN population p
  ON y.year = p.year
 AND g.Country = p.countries
GROUP BY y.year
ORDER BY y.year;

