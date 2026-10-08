select *
from analytics;


SELECT
    SUM(TotalPrice) / COUNT(DISTINCT OrderID) AS Avg_Price_Per_Order
FROM analytics;

select *
from analytics
order by product;

select *
from analytics
group by product;

with duplicates as (
select *, row_number() over(partition by OrderID) as row_num
 from analytics)
 select *
 from duplicates
 where row_num>1;
 
 select *
 from analytics;

 
 -- Exploratory Data analysis
 
select max(Quantity), max(TotalPrice)
from analytics;

select Quantity, TotalPrice
from analytics
where Quantity = (
 select max(Quantity)
 from analytics);


select TotalPrice, Quantity
from analytics
where TotalPrice = (
 select max(TotalPrice)
 from analytics);





with new_man as (
select Product, sum(TotalPrice) as total
from analytics
#where year(`date`) = '2021' 
group by Product
order by 2 desc
)
select Product, round(total, 2)
from new_man
group by Product
order by total desc;






select max(`date`), min(`date`)
from analytics;



select Product, year(`date`), round(sum(TotalPrice), 2)
from analytics
where year(`date`) is not NULL
group by product, year(`date`)
order by 3 desc;


with rolling_total as (
select substring(`date`, 1,7) as `month`, sum(TotalPrice) as total1
from analytics
where substring(`date`, 1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total1, sum(total1) over(order by `month`) as rolling_total1
from rolling_total;





