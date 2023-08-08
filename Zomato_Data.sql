create database Zomato_Data
use Zomato_Data

create table goldusers_signup(userid int, gold_signup_date date)
insert into goldusers_signup values(1,'09-22-2017')
insert into goldusers_signup values(3,'04-21-2017')

create table users(userid int, signup_date date)
insert into users values(1,'09-02-2014')
insert into users values(2,'01-15-2015')
insert into users values(3,'04-11-2014') 

create table sales(userid int, created_date date, product_id int)
insert into sales values(1,'04-19-2017',2)
insert into sales values(3,'12-18-2019',1)
insert into sales values(2,'07-20-2020',3)
insert into sales values(1,'10-23-2019',2)
insert into sales values(1,'03-19-2018',3)
insert into sales values(3,'12-20-2016',2)
insert into sales values(1,'11-09-2016',1)
insert into sales values(1,'05-20-2016',3)
insert into sales values(2,'09-24-2017',1)
insert into sales values(1,'03-11-2017',2)
insert into sales values(1,'03-11-2016',1)
insert into sales values(3,'11-10-2016',1)
insert into sales values(3,'12-07-2017',2)
insert into sales values(3,'12-15-2016',2)
insert into sales values(2,'11-08-2017',2)
insert into sales values(2,'09-10-2018',3)

create table product(product_id int, product_name text, price int)
insert into product values(1,'P1',980)
insert into product values(2,'P2',870)
insert into product values(3,'P3',330)

select * from sales
select * from product
select * from goldusers_signup
select * from users

-- What is the total amount each Customer Spent on Zomato ?

select a.userid, sum(b.price) from sales a inner join product b on a.product_id=b.product_id
group by a.userid

-- How many days has each customer visited zomato ?

select userid,COUNT(created_date) as distinct_date from sales group by userid

-- What was the first product purchased by the each customer ?


select * from 
(select *, RANK() over(partition by userid order by created_date) rnk from sales) a where rnk=1

-- What is the most purchased item on the menu and how many times was it purchased by all customers ?

select product_id, count(product_id) as count_product_id from sales group by product_id order by count(product_id)desc

select userid,count(product_id) cnt from sales where product_id = 
(select top 1 product_id from sales group by product_id order by count(product_id)desc)
group by userid

-- Which item was the most popular for each customer ?

select * from 
(select *,rank() over(partition by userid order by cnt desc) rnk from
(select userid,product_id, count(product_id) cnt from sales group by userid, product_id)a)b
where rnk = 1
