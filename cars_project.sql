create database cars_db;

use cars_db;

create table Cars(
CarID varchar(20) primary key,
Brand varchar(50),
Manufacture_Year int,
Body_Type varchar(20),
Fuel_Type varchar(20),
Transmision varchar (20),
Engine_CC int,
Mileage_Kmpl  int,
Price_USD int, 
Manufacturing_Country varchar(30),
Car_Age int,
Efficency_Score decimal(5,2));

select * from cars;

/*CATEGORY 1 — Pricing & Market Positioning
Q1. Which brands have the highest average retail price?*/

select brand,
 round(avg(price_usd),2) as Avg_price
 from cars
 group by brand
 order by avg_price desc;
 
/*CATEGORY 2 — Engine Performance
Q2. Which body type offers the highest average engine CC?*/

select body_type, round(avg(engine_cc),2) Highest_avg_cc
from cars
group by body_type
order by highest_avg_cc;

/*CATEGORY 3 — Fuel Efficiency
Q3. Which fuel type provides the best mileage?*/

select fuel_type, round(avg(mileage_kmpl),2) as best_mileage
from cars
group by fuel_type
order by best_mileage desc;

/*CATEGORY 4 — Customer Segmentation (Price Segment)
Q4. How many cars fall into Budget, Mid-range, and Luxury categories?*/

select case
when price_usd<20000 then "Budget"
when price_usd between 20000 and 50000 then "Mid-range"
else "Luxary"
end as Price_segment,
count(*) as Total_cars
from cars
group by Price_segment
order by Total_cars desc;

/*CATEGORY 5 — Depreciation / Car Age Analysis
Q5. Does car age affect price? (Average price by age)*/

select car_age, round(avg(price_usd),2)
from cars
group by car_age
order by car_age asc;

/*CATEGORY 6 — Manufacturing Country Insights
Q6. Which countries produce the most car models?*/

select manufacturing_country, count(*) as Total_cars
from cars
group by manufacturing_country
order by manufacturing_country desc; 

/*CATEGORY 7- Category: Pricing & Market Spread Analysis
Which Brand Has the Widest Price Range?*/

select brand, max(price_usd) as max_price, min(price_usd) as min_price,
(max(price_usd)-min(price_usd)) as Price_range
from cars
group by brand
order by price_range desc;

/*Category 8: Production Trend & Time-Series Analysis
How Many Cars Were Manufactured in Each Year?*/

select manufacture_year, count(*) as Cars_produced
from cars
group by manufacture_year
order by Manufacture_year asc; 

/*CATEGORY 9 — Top Performer Analysis
Which cars have above-average mileage and above-average engine performance?*/

with averages as(select 
avg(mileage_kmpl) as avg_mileage,
avg(engine_cc) as avg_cc
from cars)

select c.car_id, c.brand, c.mileage_kmpl, c.engine_cc
from cars c cross join averages a
where c.mileage_kmpl > a.avg_mileage and
	  c.engine_cc>a.avg_cc
order by c.mileage_kmpl desc;