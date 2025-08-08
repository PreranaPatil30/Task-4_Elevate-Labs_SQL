create table customer_info(
customer_id	varchar(50) ,
customer_unique_id	varchar(50) ,
customer_zip_code_prefix int NOT NULL,
customer_city	varchar(50),	
customer_state	varchar(20)
);	
drop table customer_info;

select * from customer_info;

select customer_city from customer_info where customer_city= 'franca';
select * from customer_info where customer_city= 'franca';
select distinct customer_city from customer_info;

select customer_city, count(*) as customer_count from customer_info 
group by customer_city order by customer_count;

CREATE TABLE orders (
    order_id INT,
    customer_id VARCHAR(50),
    product_name VARCHAR(100),
    order_amount FLOAT
);
select * from orders;

drop table orders;


#List customer id and their product name
SELECT c.customer_id, o.product_name
FROM customer_info c
JOIN orders o ON c.customer_id = o.customer_id;

#List order id and their city
SELECT o.order_id, c.customer_city
FROM orders o
JOIN customer_info c ON o.customer_id = c.customer_id;

#list customer city and the product
select c.customer_city,o.product_name
from customer_info c
join orders o on c.customer_id=o.customer_id;

#list of customers from sao paulo who ordered something
select c.customer_city,c.customer_id,o.product_name
from customer_info c
join orders o on c.customer_id=o.customer_id
where c.customer_city='sao paulo';

#show all customers, even if they haven’t placed any orders
SELECT 
    c.customer_id, 
    c.customer_city, 
    o.order_id, 
    o.product_name
FROM customer_info c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id;

#top 5 cities based on purchase
SELECT 
    c.customer_city, 
    SUM(o.order_amount) AS total_purchase
FROM customer_info c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_purchase DESC
LIMIT 5;

#view for otal orders per customer
CREATE VIEW total_orders_per_customer AS
SELECT 
    c.customer_id, 
    COUNT(o.order_id) AS total_orders
FROM customer_info c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

SELECT * FROM total_orders_per_customer ;

#view for customer who ordered tires
create view customer_ordered_tires as
select
c.customer_id,
o.product_name
from customer_info c
join orders o on c.customer_id=o.customer_id
where o.product_name='TireS';

select * from customer_ordered_tires;
Drop view customer_ordered_tires;

