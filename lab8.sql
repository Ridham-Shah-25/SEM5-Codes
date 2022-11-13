create database lab8;
use lab8;

create table sales_tax_rate(
state varchar(255) primary key,
tax_rate decimal);

alter table sales_tax_rate
modify column tax_rate decimal(6,2);

create table customer(
c_name varchar(255),
product_purchased varchar(255),
price_of_product int,
city varchar(255),
state varchar(255));

insert into sales_tax_rate values
('California',6.1),
('Washington',5.3),
('Utah',4.5);

select * from sales_tax_rate;

insert into customer values
('Ridham','soap',30,'city A','Utah'),
('Ishan','cookies',20,'city B','Washington'),
('Anuj','towel',40,'city C','California');

alter table customer
add sales_tax_paid decimal(6,2) default 0;

select * from customer;

create table customer_copy as select * from customer;

delimiter $$
create procedure get_sales_tax()
begin
	declare done int default 0;
    declare cname varchar(255);
    declare price decimal(6,2);
    declare cstate varchar(255);
    declare new_cursor cursor for select c_name,price_of_product,state from customer;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    open new_cursor;
    repeat
		fetch new_cursor into cname,price,cstate;
        update customer
        set sales_tax_paid=price_of_product*(select tax_rate from sales_tax_rate
        where state=cstate)
        where c_name=cname;
		
        until done
        end repeat;
        close new_cursor;
end$$

delimiter ;


drop procedure get_sales_tax;
call get_sales_tax();

select * from customer;

insert into customer values
('Mayank','books',20,'city D','Washington',0);