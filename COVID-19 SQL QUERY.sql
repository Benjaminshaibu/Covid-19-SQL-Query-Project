Select *
From [Portfolio Project]..covidDeaths
order by 3,4 

--Select *
--From [Portfolio Project]..covidvaccinations
--order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project]..covidDeaths
order by 1,2

--Total Cases vs Total Deaths 

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio Project]..covidDeaths
Where location like '%Nigeria%'
order by 1,2

--Looking at Total Cases vs Population  (Show what percentage of the population got covid)

Select location, date, population, total_deaths, (total_cases/population)*100 as PercentageInfectedPopulation
From [Portfolio Project]..covidDeaths
Where location like '%Nigeria%'
order by 1,2

--Looking as Countries with the Hightest Infection Rate Compared to Population
Select location, population, MAX(total_cases) as HightestInfectionCount, MAX((total_cases/population))*100 as PercentageInfectedPopulation
---PercentagePopulationInfected
From [Portfolio Project]..covidDeaths
---Where location like '%Nigeria%'
Group by Location, population
order by PercentageInfectedPopulation desc

---By Continent
Select continent, MAX(cast(total_cases as int)) as TotalDeathCount
From [Portfolio Project]..covidDeaths
---Where location like '%Nigeria%'
Where continent is not null
Group by continent
order by TotalDeathCount desc

---Global Numbers across the world

Select date, SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From [Portfolio Project]..covidDeaths
---Where location like '%Nigeria%'
Where continent is not null
Group by date
order by 1,2

---Overall across the world
Select SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From [Portfolio Project]..covidDeaths
---Where location like '%Nigeria%'
Where continent is not null
---Group by date
order by 1,2

--Joining both tables CovidDeaths and CovidVaccinations
Select *
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location =vac.location
	and dea.date=vac.date

	---Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From [Portfolio Project]..CovidDeaths dea
Join [Portfolio Project]..CovidVaccinations vac
	On dea.location =vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3

