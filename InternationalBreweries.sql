Use capstone;
select * from international_breweries;

----------------- SESSION A (PROFIT ANALYSIS) -------------------

-- 1. Within the space of the last three years, what was the profit worth of the breweries, inclusive of the anglophone and the francophone territories? 

/* 
The total profit made within these three years of operation was approximately 105 million
*/
SELECT 
    SUM(profit) AS Total_Profit
FROM
    international_breweries;

-- 2. Compare the total profit between these two territories in order for the territory manager,
--  Mr. Stone to make a strategic decision that will aid profit maximization in 2020. 

/* 
Francophone region had the highest profit within the three years of operation
*/

    SELECT
    CASE 
        WHEN COUNTRIES in ('Ghana', 'Nigeria') THEN 'Anglophone'
        WHEN COUNTRIES in ('Togo', 'Benin', 'Senegal') Then 'Francophone'
        ELSE 'Unknown'
    END AS Territory,
    SUM(PROFIT) AS TotalProfit
FROM
    international_breweries
GROUP BY
    Territory;

-- 3. What country generated the highest profit in 2019 
/*
Senegal generated the highest profit of about 21 million, Togo generated the lowest profit of about 20 million
*/

SELECT 
    countries, SUM(profit) AS total_profit
FROM
    international_breweries
GROUP BY countries
ORDER BY total_profit DESC;

-- 4. Help him find the year with the highest profit. 
/* 
Among the three years 2017 outperformed 2018 and 2019 in terms of profit generation
*/

SELECT 
    YEARS, SUM(profit) AS total_profit
FROM
    international_breweries
GROUP BY YEARS
ORDER BY total_profit DESC;

-- 5. Which month in the three years was the least profit generated? 
/*
The month of April generated the least profit across the three years period
*/
SELECT 
    MONTHS, SUM(profit) AS total_profit
FROM
    international_breweries
GROUP BY MONTHS
ORDER BY total_profit ASC;

-- 6. What was the minimum profit in the month of December 2018? 

/*
The minimum profit made in December 2018 was 38,150
*/

SELECT 
    MONTHS, MIN(PROFIT) AS minimum_profit
FROM
    international_breweries
WHERE
    YEARS = 2018 AND MONTHS = 'December'
GROUP BY MONTHS;

-- 7. Compare the profit for each of the months in 2019 
/*
The month of July generated the highest profit in the year of 2019 while, 
february generated the least */

SELECT 
    MONTHS, SUM(PROFIT) AS total_profit
FROM
    international_breweries
WHERE
    YEARS = 2019
GROUP BY MONTHS
ORDER BY total_profit DESC;

-- 8. Which particular brand generated the highest profit in Senegal?
/*
Castle lite is the golden brand in senegal and generated the highest profit 
*/

SELECT 
    brands, SUM(profit) AS total_profit
FROM
    international_breweries
WHERE
    countries = 'Senegal'
GROUP BY brands
ORDER BY total_profit DESC;

----------------- SESSION B (BRAND ANALYSIS) ------------------- 

-- 1. Within the last two years, the brand manager wants to know the top three brands consumed in the francophone countries 
/*
In this particular order budweiser, castle lit, and eagle lager were the top three brandsin francophone countries 
*/

  SELECT 
    BRANDS,
    CASE COUNTRIES
        WHEN COUNTRIES in ('Ghana', 'Nigeria') THEN 'Anglophone'
        WHEN COUNTRIES in ('Togo', 'Benin', 'Senegal') Then 'Francophone'
        ELSE 'Unknown'
    END AS Territory,
    SUM(PROFIT) AS TotalProfit
FROM
    international_breweries
WHERE
    YEARS <> 2017
GROUP BY Territory , BRANDS
HAVING Territory = 'Francophone'
ORDER BY TotalProfit DESC
LIMIT 3;

-- 2. Find out the top two choice of consumer brands in Ghana 

/*
In Ghana, the top two choices are eagle lager and castle lite
*/

SELECT 
    BRANDS, SUM(QUANTITY) AS total_Quantity
FROM
    international_breweries
WHERE
    COUNTRIES = 'Ghana'
GROUP BY BRANDS
ORDER BY total_Quantity DESC
LIMIT 2; 

-- 3. Find out the details of beers consumed in the past three years in the most oil reached country in West Africa. 
/*
There are 7 different brands in Nigeria, budweiser had the highest UNIT_PRICE and PLANT_COST.
Castle lite generated the highest profit, and consequently had the highest unit sold
 */

SELECT 
    *
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria';

SELECT DISTINCT
    BRANDS, UNIT_PRICE, PLANT_COST
FROM
    international_breweries
GROUP BY BRANDS , UNIT_PRICE , PLANT_COST
ORDER BY PLANT_COST DESC;

SELECT 
    brands, SUM(profit), SUM(quantity)
FROM
    international_breweries
GROUP BY brands
ORDER BY SUM(profit) DESC;

-- 4. Favorites malt brand in Anglophone region between 2018 and 2019 
/*
Beta malt is the favourite brands in Anglophone region
*/

  SELECT 
    BRANDS,
    CASE COUNTRIES
        WHEN COUNTRIES in ('Ghana', 'Nigeria') THEN 'Anglophone'
        WHEN COUNTRIES in ('Togo', 'Benin', 'Senegal') Then 'Francophone'
        ELSE 'Unknown'
    END AS Territory,
    SUM(PROFIT) AS TotalProfit
FROM
    international_breweries
WHERE
    BRANDS LIKE '%malt'
        AND YEARS BETWEEN 2018 AND 2019
GROUP BY Territory , BRANDS
HAVING Territory = 'Anglophone'
ORDER BY TotalProfit DESC;

-- 5. Which brands sold the highest in 2019 in Nigeria? 
/*
Budweiser sold the highest in 2019 in Nigeria
*/

SELECT 
    BRANDS, SUM(QUANTITY) AS total_quantity
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria'
GROUP BY BRANDS
ORDER BY total_quantity DESC
LIMIT 1;

-- 6. Favorites brand in South_South region in Nigeria 
/*
In the south_south region of Nigeria eagle lager is the favourite brand
*/

SELECT 
    BRANDS, SUM(QUANTITY) AS total_quantity
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria'
        AND REGION = 'southsouth'
GROUP BY BRANDS
ORDER BY total_quantity DESC
LIMIT 1;

-- 7. Beer consumption in Nigeria 
/* 
129,260 units of beer was consumed in Nigeria with these three years
*/

SELECT 
    SUM(QUANTITY) AS total_quantity_consumed
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria'
        AND BRANDS NOT LIKE '%malt';

-- 8. Level of consumption of Budweiser in the regions in Nigeria 
/*
In Nigeria 26,153 units of budweiser was consumed within 2017, 2018 and 2019
with western region accountting for the highest amount
*/

SELECT 
    SUM(QUANTITY) AS total_quantity_consumed
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria'
        AND BRANDS = 'Budweiser';

SELECT 
    REGION, SUM(QUANTITY) AS total_quantity_consumed
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria'
        AND BRANDS = 'Budweiser'
GROUP BY REGION
ORDER BY total_quantity_consumed DESC;

-- 9. Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo)
/*
5490 units of budweiser was consumed in Nigeria in 2019 alone, southeastern region had the highest amount of 1,821
*/

SELECT 
    SUM(QUANTITY) AS total_quantity_consumed
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria' AND YEARS = 2019
        AND BRANDS = 'budweiser'
ORDER BY total_quantity_consumed DESC;

SELECT 
    REGION, SUM(QUANTITY) AS total_quantity_consumed
FROM
    international_breweries
WHERE
    COUNTRIES = 'Nigeria' AND YEARS = 2019
        AND brands = 'budweiser'
GROUP BY REGION
ORDER BY total_quantity_consumed DESC;


----------------- SESSION C (COUNTRIES ANALYSIS) -------------------

-- 1. Country with the highest consumption of beer.
/*
Senegal had the highet consumption of beer
*/

SELECT 
    COUNTRIES, SUM(QUANTITY) AS total_quantity
FROM
    international_breweries
WHERE
    brands NOT LIKE '%malt'
GROUP BY COUNTRIES
ORDER BY total_quantity DESC;

-- 2. Highest sales personnel of Budweiser in Senegal
/*
In Senegal, Jones sold the highest quantity and generated the highest profit
*/

SELECT 
    SALES_REP,
    SUM(QUANTITY) AS total_quantity,
    SUM(PROFIT) AS total_profit
FROM
    international_breweries
WHERE
    COUNTRIES = 'Senegal'
GROUP BY SALES_REP
ORDER BY total_quantity DESC;

-- 3. Country with the highest profit of the fourth quarter in 2019
/*
In the fourth quarter of 2019, Ghana generated the highest profit while, Senegal generated the least profit
*/

SELECT 
    COUNTRIES,
    SUM(PROFIT) AS total_profit
FROM
    international_breweries
WHERE
    YEARS = 2019
    AND (MONTHS = 'October' OR MONTHS = 'November' OR MONTHS = 'December')
GROUP BY
    COUNTRIES
ORDER BY
    total_profit DESC;
