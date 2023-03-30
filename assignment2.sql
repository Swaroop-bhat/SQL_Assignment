create database assign2;
use assign2;

create table customer(
customer_id int primary key,
customer_name varchar(25));
desc customer;

insert into customer values(1,'John');
insert into customer values(2,'Smith');
insert into customer values(3,'Ricky');
insert into customer values(4,'Walsh');
insert into customer values(5,'Stefen');
insert into customer values(6,'Fleming');
insert into customer values(7,'Thomson');
insert into customer values(8,'David');

select *from customer;

create table product(
product_id int primary key,
product_name varchar(25),
product_price int);
desc product;

insert into product values(1,'Television',19000);
insert into product values(2,'DVD',3600);
insert into product values(3,'Washing Machine',7600);
insert into product values(4,'Computer',35900);
insert into product values(5,'Ipod',3210);
insert into product values(6,'Panasonic Phone',2100);
insert into product values(7,'Chair',360);
insert into product values(8,'Table',490);
insert into product values(9,'Sound System',12050);
insert into product values(10,'Home Theatre',19350);

select *from product;

create table orders(
order_id int primary key,
customer_id int,
ordered_date date,
foreign key(customer_id) references customer(customer_id));

desc orders;

insert into orders values(1,4,'2005-01-10');
insert into orders values(2,2,'2006-02-10');
insert into orders values(3,3,'2005-03-20');
insert into orders values(4,3,'2006-03-10');
insert into orders values(5,1,'2007-04-05');
insert into orders values(6,7,'2006-12-13');
insert into orders values(7,6,'2008-03-13');
insert into orders values(8,6,'2004-11-29');
insert into orders values(9,5,'2005-01-13');
insert into orders values(10,1,'2007-12-12');

select *from orders;

create table order_details(
order_detail_id int primary key,
order_id int,
product_id int,
quantity int,
foreign key(order_id) references orders(order_id),
foreign key (product_id) references product(product_id));

desc order_details;

insert into order_details values(1,1,3,1);
insert into order_details values(2,1,2,3);
insert into order_details values(3,2,10,2);
insert into order_details values(4,3,7,10);
insert into order_details values(5,3,4,2);
insert into order_details values(6,3,5,4);
insert into order_details values(7,4,3,1);
insert into order_details values(8,5,1,2);
insert into order_details values(9,5,2,1);
insert into order_details values(10,6,5,1);
insert into order_details values(11,7,6,1);
insert into order_details values(12,8,10,2);
insert into order_details values(13,8,3,1);
insert into order_details values(14,9,10,3);
insert into order_details values(15,10,1,1);


select *from order_details;
use assign2;
select*from customer;
desc customer;

/*1)*/ SELECT customer.customer_id, customer.customer_name,  product.product_name 
FROM customer
JOIN orders ON customer.customer_iD = orders.customer_id
JOIN order_details ON orders.order_id = order_details.order_id
JOIN product ON order_details.product_id = product.product_id;


/*2)*/ select orders.order_id,orders.ordered_date,sum(order_details.quantity*product.product_price)as totalprice 
from orders 
join order_details on orders.order_id=order_details.order_id
join product on order_details.product_id=product.product_id
group by orders.order_id,orders.ordered_date;

/*3)*/ select customer.customer_name from customer
left join orders on orders.order_id=customer.customer_id where orders.order_id is null;

/*4)*/ select *from product left join order_details on order_details.order_id=product.product_id where order_details.order_id is null; 



/*5)*/ select customer.customer_name,sum(order_details.quantity * product.product_price) as totalpurchaseamount
from customer
join orders on customer.customer_id=orders.customer_id
join order_details on orders.order_id=order_details.order_id
join product on order_details.product_id=product.product_id
group by customer.customer_id;

/*6)*/SELECT C.* FROM customer C , orders O
	WHERE C.customer_ID = O.customer_ID
	ORDER BY O.ordered_Date ASC
	LIMIT 1;
    
	SELECT C.* FROM customer C , orders O
	WHERE C.customer_ID = O.customer_ID
	ORDER BY O.ordered_Date DESC
	LIMIT 1;


/*7)*/
SELECT c.* FROM customer c
	JOIN (
  		SELECT customer_id, COUNT(*) AS orders
  		FROM orders  GROUP BY customer_id ORDER BY orders DESC LIMIT 1
		)  o ON c.customer_id= o.customer_id;
        
select *from orders;
desc customer;

/*8)*/ select c.customer_id ,c.customer_name,count(distinct year(o.ordered_date)) as years
from custpmer c
join orders o on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having count(distinct year(o.ordered_date))>1;



/*9*/ SELECT date_format(ordered_date,'%M') AS Month_name, COUNT(order_id) AS orders
FROM orders 
group by Month_name
order by orders desc
limit 1;


/*10)*/ select p.product_id,p.product_name,max(p.product_price*od.quantity) as maxprice
from product p join order_details od
on p.product_id=od.product_id
group by p.product_id,p.product_name 
order by maxprice desc
limit 1;









 







