--Data from Covied19_Deaths table
SELECT *
FROM Covid19..Covid19_Deaths
--WHERE location = 'India'
ORDER BY location, date;

--Data from Covied19_Vaccinations table
SELECT *
FROM Covid19..Covid19_Vaccinations
ORDER BY location, date;

-- Percentage of population infected in India
SELECT location, SUM(new_cases) AS TotalCases, population, (SUM(new_cases)/population)*100 AS PercentPeopleInfected FROM Covid19..Covid19_Deaths
WHERE location = 'India'
GROUP BY location, population;

-- Country with highest percentage of population infected
SELECT TOP 1 location, SUM(new_cases) AS TotalCases, population, (SUM(new_cases)/population)*100 AS PercentPeopleInfected FROM Covid19..Covid19_Deaths
WHERE continent is not null
GROUP BY location, population
ORDER BY TotalCases DESC;

-- Country with lowest population per 1 million infected (countries infected with Covid)
SELECT location, SUM(new_cases) AS TotalCases, population, (SUM(new_cases)/population)*1000000 AS PopulationInfectedPerMillion FROM Covid19..Covid19_Deaths
WHERE continent is not null AND total_cases is not null
GROUP BY location, population
ORDER BY PopulationInfectedPerMillion;

-- total deaths in India
SELECT location as Country, population as Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths FROM Covid19..Covid19_Deaths
WHERE location = 'India'
GROUP BY location, population;

-- Countries with most deaths (at least 1 death)
SELECT * FROM
(
SELECT location AS Country, SUM(CONVERT(int, new_deaths)) AS TotalDeaths FROM Covid19..Covid19_Deaths
WHERE continent is not null
GROUP BY location
) AS temp
WHERE TotalDeaths is not null
ORDER BY TotalDeaths DESC;

-- Countries with least deaths (at least 1 death)
SELECT * FROM
(
SELECT location, MAX(CONVERT(int, total_deaths)) AS TotalDeaths FROM Covid19..Covid19_Deaths
WHERE continent is not null
GROUP BY location
) as temp
WHERE TotalDeaths is not null
ORDER BY TotalDeaths;

-- 2nd method
SELECT location AS Country, SUM(CONVERT(int, new_deaths)) AS TotalDeaths FROM Covid19..Covid19_Deaths
WHERE continent is not null AND total_deaths is not null
GROUP BY location
ORDER BY TotalDeaths;

-- Mortality Rate India (Cases to death ratio)
SELECT location as Country, population as Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths,
SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(float, new_deaths))/SUM(CONVERT(float, new_cases)))*100 AS Ratio FROM Covid19..Covid19_Deaths
WHERE location = 'India'
GROUP BY location, population;

-- Countries with highest Mortality Rate (Cases to death ratio)
SELECT * FROM
(
SELECT location as Country, population as Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths,
SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(float, new_deaths))/SUM(CONVERT(float, new_cases)))*100 AS MortalityRate FROM Covid19..Covid19_Deaths
GROUP BY location, population
) AS temp
WHERE MortalityRate is not null
ORDER BY MortalityRate DESC;

-- Countries with lowest Mortality Rate (Cases to death ratio)
SELECT * FROM
(
SELECT location as Country, population as Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths,
SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(float, new_deaths))/SUM(CONVERT(float, new_cases)))*100 AS MortalityRate FROM Covid19..Covid19_Deaths
GROUP BY location, population
) AS temp
WHERE MortalityRate is not null
ORDER BY MortalityRate;

-- Most infected continent
SELECT location AS Continent, SUM(CONVERT(int, new_cases)) AS TotalCases FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location
ORDER BY TotalCases DESC;

-- Least infected continent
SELECT location AS Continent, SUM(CONVERT(int, new_cases)) AS TotalCases FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location
ORDER BY TotalCases;

-- Continent with highest percentage of population infected
SELECT location AS Continent, population AS Population, SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(int, new_cases))/population)*100 AS PercentPopulationInfected
FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Continent with lowest percentage of population infected
SELECT location AS Continent, population AS Population, SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(int, new_cases))/population)*100 AS PercentPopulationInfected
FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location, population
ORDER BY PercentPopulationInfected;

-- Continent with most deaths
SELECT location AS Continent, population AS Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths
FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location, population
ORDER BY TotalDeaths DESC;

-- Continent with least deaths
SELECT location AS Continent, population AS Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths
FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location, population
ORDER BY TotalDeaths;

-- Continents with highest Mortality Rate (Cases to death ratio)
SELECT * FROM
(
SELECT location as Continent, population as Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths,
SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(float, new_deaths))/SUM(CONVERT(float, new_cases)))*100 AS MortalityRate FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location, population
) AS temp
WHERE MortalityRate is not null
ORDER BY MortalityRate DESC;

-- Continents with lowest Mortality Rate (Cases to death ratio)
SELECT * FROM
(
SELECT location as Continent, population as Population, SUM(CONVERT(int, new_deaths)) AS TotalDeaths,
SUM(CONVERT(int, new_cases)) AS TotalCases,
(SUM(CONVERT(float, new_deaths))/SUM(CONVERT(float, new_cases)))*100 AS MortalityRate FROM Covid19..Covid19_Deaths
WHERE location IN ('Asia', 'North America', 'South America', 'Africa', 'Australia', 'Europe', 'Antarctica')
GROUP BY location, population
) AS temp
WHERE MortalityRate is not null
ORDER BY MortalityRate;

-- Global Numbers
SELECT TOP 1 location, date, population, total_cases, total_deaths,
(total_cases/population)*100 AS PercentPopulationInfected,
(total_deaths/total_cases)*100 as MortalityRateByCases,
(total_deaths/population)*100 as MortalityRateByPopulation
FROM Covid19..Covid19_Deaths
WHERE location = 'World'
ORDER BY date DESC;

-- Vaccinations

-- Total vaccinations in India
SELECT location AS 'Country', SUM(CONVERT(int, new_vaccinations)) AS 'Total_Vaccinations'
FROM Covid19..Covid19_Vaccinations
WHERE location = 'India'
GROUP BY location;

-- Most vaccinated Country
SELECT TOP 1 location AS 'Country', SUM(CONVERT(bigint, new_vaccinations)) AS 'Total_Vaccinations'
FROM Covid19..Covid19_Vaccinations
WHERE continent is not null
GROUP BY location
ORDER BY 'Total_Vaccinations' DESC;

-- Least vaccinated Country (with vaccinations started)
SELECT TOP 1 * FROM
(
SELECT location AS 'Country', SUM(CONVERT(bigint, new_vaccinations)) AS Total_Vaccinations
FROM Covid19..Covid19_Vaccinations
WHERE continent is not null
GROUP BY location
)
AS temp
WHERE CONVERT(bigint, Total_Vaccinations) is not null
ORDER BY Total_Vaccinations;

-- Country with most tests
SELECT TOP 1 location AS Country, SUM(CONVERT(bigint, new_tests)) AS Total_Tests
FROM Covid19..Covid19_Vaccinations
WHERE continent is not null
GROUP BY location
ORDER BY Total_Tests DESC;

-- Country with least tests (with testing started)
SELECT TOP 1 * FROM
(
SELECT location AS 'Country', SUM(CONVERT(bigint, new_tests)) AS Total_Tests
FROM Covid19..Covid19_Vaccinations
WHERE continent is not null
GROUP BY location
)
AS temp
WHERE CONVERT(bigint, Total_Tests) is not null
ORDER BY Total_Tests;
