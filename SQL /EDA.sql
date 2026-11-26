-- Exploảtory Data Analysis

Select * 
From layoffs_staging2;

Select Max(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2;

Select *
From layoffs_staging2
Where percentage_laid_off =1
Order by total_laid_off desc;

Select company, Sum(total_laid_off)
From layoffs_staging2
Group by company
order by 2 desc;

Select Min(`date`), Max(`date`)
From layoffs_staging2;

Select industry, Sum(total_laid_off)
From layoffs_staging2
Group by industry
order by 2 desc;

Select country, Sum(total_laid_off)
From layoffs_staging2
Group by country
order by 2 desc;

Select Year(`date`), Sum(total_laid_off)
From layoffs_staging2
Group by Year(`date`)
order by 2 desc;

Select Substring(`date`,1,7) `month`, sum(total_laid_off)
From layoffs_staging2
Where Substring(`date`,1,2) is not null
Group by `month`
order by 1 ASC;


With Rolling_Total AS
(
Select Substring(`date`,1,7) `month`, sum(total_laid_off) total_laid_off
From layoffs_staging2
Where Substring(`date`,1,2) is not null
Group by `month`
order by 1 ASC
)
Select `month`, total_laid_off,
 Sum(total_laid_off) Over(Order by`month`) As rolling_total
From Rolling_Total;

Select company, Sum(total_laid_off)
From layoffs_staging2
Group by company
order by 2 desc;

Select company,Year(`date`), Sum(total_laid_off)
From layoffs_staging2
Group by company,Year(`date`)
Order by 3 desc;


With Company_Year (Company, Years, Total_laid_off) AS
(
Select company,Year(`date`), Sum(total_laid_off)
From layoffs_staging2
Group by company,Year(`date`)
)
, Company_Year_Rank AS
(Select *, Dense_Rank() Over(Partition By years Order by total_laid_off DESC) As Ranking
From Company_Year
Where Years is not null
)
Select *
From Company_Year_Rank
Where Company = 'Uber'
;


