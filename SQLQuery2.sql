-----------------------------------------------------------------------------------------------
------------------------------ Feature Engineering --------------------------------------------
-- Time of the day 

SELECT Time, TRY_CONVERT(TIME(7), Time) AS ConvertedTime
FROM sales;

update sales
set Time = TRY_CONVERT(TIME(7), Time)


SELECT  Time,
    CASE 
        WHEN Time  BETWEEN '00:00:00.0000000' AND '12:00:00.0000000' THEN 'Morning'
        WHEN Time BETWEEN '12:00:00.0000001' AND '16:00:00.0000000' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sales;


Alter table sales 
add time_of_day  nvarchar (30)

update sales 
set time_of_day = 
CASE 
        WHEN Time  BETWEEN '00:00:00.0000000' AND '12:00:00.0000000' THEN 'Morning'
        WHEN Time BETWEEN '12:00:00.0000001' AND '16:00:00.0000000' THEN 'Afternoon'
        ELSE 'Evening'
    END



-- Day name 

select date , DATENAME(WEEKDAY,date) as day_name 
from sales

alter table sales 
add  day_name nvarchar (30)

update sales 
set day_name = DATENAME(WEEKDAY,date)

select day_name 
from sales 


-- Month name 

select date ,DATENAME(month , date)
from sales

alter table sales 
add month_name nvarchar (30)

update sales 
set month_name = DATENAME(month , date)

select month_name 
from sales







--------------------------------------------------------------------------------------------------------
----------------------------------------- Geeneric ---------------------------------------------------
-- How many unique cities does the data have?

select count (distinct(City) )
from sales 

-- In which city is each branch?

select distinct (City),Branch 
from sales 


-- How many unique product lines does the data have?
select count ( Product_line )
from sales



-- What is the most common payment method?
select  Payment, count (Payment) as Payment_count
from sales
group by Payment 
order by 1 desc

-- What is the most selling product line?
select Product_line, count(Product_line) 
from sales
group by Product_line
order by 1 desc


-- What is the total revenue by month?
select month_name, sum(Total) as total_revenue_by_month 
from sales
group by month_name
order by 1 desc




-- What month had the largest COGS?
select distinct month_name as month, sum(Cogs) as cogs 
from sales 
group by month_name
order by cogs desc	




-- What product line had the largest revenue?
select Product_line, sum(Total) as sum_of_revenue
from sales
group by Product_line
order by 2 desc


-- What is the city with the largest revenue?
select City, sum (Total) as city_total_revenue 
from sales
group by City
order by 2



-- What product line had the largest VAT?
select Product_line, avg (Tax_5) as total_tax
from sales
group by Product_line
order by 2 desc



-- Which branch sold more products than average product sold?
select Branch,sum ( Quantity ) as qnt 
from sales
group by Branch
having sum(Quantity) > (select avg (Quantity) from sales)
order by 2 desc



-- What is the most common product line by gender?
select Product_line,Gender , count ( Gender ) as coun_gender 
from sales
group by Product_line,Gender
order by coun_gender desc



-- What is the average rating of each product line?
select Product_line, avg (Rating) as avg_rating
from sales 
group by Product_line
order by 2 desc


-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT 
    Product_line,Total, 
    CASE 
        WHEN total > (SELECT AVG(Total) FROM sales) THEN 'Good'
        ELSE 'Bad'
    END AS SalesClassification
FROM sales



----------------------------------------------------------------------------------------------------------
---------------------------------- Sales -------------------------------------------------------------


-- Number of sales made in each time of the day per weekday
select day_name, sum(Total) as day_revenue
from sales
group by day_name
order by 2 desc


-- Which of the customer types brings the most revenue?
select Customer_type, sum (Total) as customer_revenue
from sales 
group by Customer_type 
order by 2 desc 




-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, avg (Tax_5) as avg_tax ,sum  (Tax_5)/sum (Total)*100 as tax_percentage
from sales
group by city 
order by 2 desc




-- Which customer type pays the most in VAT?
select Customer_type, sum (Tax_5) as customer_tax
from sales
group by Customer_type 
order by 2 desc





-- How many unique customer types does the data have?
select count (distinct Customer_type)
from sales




-- How many unique payment methods does the data have?
select count (distinct Payment) as payments_types
from sales




-- What is the most common customer type?
select Customer_type , count ( Customer_type ) as customers_count 
from sales
group by Customer_type
order by 2 desc




-- Which customer type buys the most?
select Customer_type, sum (Quantity) customers_quantity 
from sales
group by Customer_type
order by 2 desc




-- What is the gender of most of the customers?
select Gender, Count ( Gender ) as gender_count 
from sales
group by gender 
order by 2 desc





-- What is the gender distribution per branch?
select Branch, Gender 
from sales
group by Branch, Gender 
order by 1 




-- Which time of the day do customers give most ratings?
select time_of_day,avg ( Rating ) as avg_rating 
from sales 
group by time_of_day
order by  2 desc





-- Which time of the day do customers give most ratings per branch?
select time_of_day,Branch,avg ( Rating ) as avg_rating 
from sales 
group by time_of_day, Branch
order by  2 desc


-- Which day of the week has the best avg ratings?
select day_name, avg ( Rating ) as avg_rating 
from sales 
group by day_name
order by  2 desc



-- Which day of the week has the best average ratings per branch?
select day_name, Branch, avg ( Rating ) as avg_rating 
from sales 
group by day_name, Branch
order by  3 desc





-------------------------------------- Thank you -----------------------------------------





