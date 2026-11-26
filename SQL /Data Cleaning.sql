-- Data Cleaning

Select *
From layoffs;

-- Step 1. Remove Duplicates
-- Step 2. Standardize the Data
-- Step 3. Null Values or Blank values
-- Step 4. Remove Any Colums if nescessary

Create table layoffs_staging
Like layoffs;

Select *
From layoffs_staging
;

Insert layoffs_staging
Select *
From layoffs;


Select *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
From layoffs_staging;

With duplicate_cte AS
(
Select *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
From layoffs_staging
)
Select *
From duplicate_cte
Where row_num > 1;


Select *
From layoffs_staging
Where company = 'Casper';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

Select *
From layoffs_staging2
Where row_num > 1;

Insert into layoffs_staging2
Select *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
From layoffs_staging;

Delete 
From layoffs_staging2
Where row_num > 1;

Select * 
From layoffs_staging2
Where company = 'Casper';

-- Standardizing data

Select distinct(Trim(company))
From layoffs_staging2;

Update layoffs_staging2
Set company = Trim(company);

Select distinct industry
From layoffs_staging2
Order by 1;

Select *
From layoffs_staging2
Where industry like 'Crypto%';

Update layoffs_staging2
Set industry = 'Crypto'
Where industry like 'Crypto%';

select distinct country, trim(Trailing '.' From country)
From layoffs_staging2
order by 1;

Update layoffs_staging2
Set country = trim(Trailing '.' From country)
Where country like 'United States%';

Select *
From layoffs_staging2;

Select `date`
From layoffs_staging2;

Update layoffs_staging2
Set `date` = STR_TO_DATE(`date`,'%m/%d/%Y') ;

Alter Table layoffs_staging2
Modify column `date` Date;

Select *
From layoffs_staging2
Where total_laid_off  is null
And percentage_laid_off is null;

Select *
From layoffs_staging2
Where industry = null
or industry = '';

Select *
From layoffs_staging2
Where company like 'Bally%';

Update layoffs_staging2
Set industry = null
Where industry = '';

Select t1.industry, t2.industry
From layoffs_staging2 t1
Join layoffs_staging2 t2
on t1.company = t2.company
And t1.location = t2.location
Where t1.industry is null
And t2.industry is not null;

Update layoffs_staging2 t1
Join layoffs_staging2 t2
on t1.company=t2.company
Set t1.industry=t2.industry 
Where t1.industry is null
And t2.industry is not null;

Delete 
From layoffs_staging2
Where total_laid_off is null
And percentage_laid_off is null;

Select *
From layoffs_staging2
Where total_laid_off is null
And percentage_laid_off is null;

Alter table layoffs_staging2
Drop column row_num;

Select * 
From layoffs_staging2;
