create database lab7;
use lab7;

create table product(
code varchar(255) primary key,
name varchar(255),
description varchar(255),
superproduct varchar(255),
level int);

create table new_product(
code varchar(255) primary key,
name varchar(255),
description varchar(255),
superproduct varchar(255),
level int);

insert into product
values
('P1','Person1','First Person',null,0),
('P2','Person2','Second Person','P1',1),
('P3','Person3','Third Person','P1',1),
('P4','Person4','Fourth Person','P1',1),
('P5','Person5','Fifth Person','P1',1),
('P6','Person6','Sixth Person','P2',2),
('P7','Person7','Seventh Person','P2',2),
('P8','Person8','Eigth Person','P5',2),
('P9','Person9','Ninth Person','P5',2);

insert into product
values
('P1','Person1','First Person',null,0);

create table new_product;
INSERT INTO new_product SELECT * FROM product;
truncate table new_product;
select * from new_product;


create trigger DeleteProduct
after delete on Product
for each row
delete from product
where SuperProduct = old.Code;


drop trigger deleteproduct;

delete from product
where
code='P1';

select * from new_product;