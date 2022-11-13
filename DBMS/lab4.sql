#Ridham Shah
#PG 41

drop database lab4;
create database lab4;
use lab4;

#creating tables and adding values
create table room(
r_number int primary key,
capacity numeric(19,0),
building varchar(255)
);

create table course(
c_number int primary key,
name varchar(255),
department varchar(255)
);

  

create table section(
c_number int,
s_number int primary key,
department varchar(255),
foreign key(c_number) references course(c_number)
);

ALTER TABLE section    
MODIFY department int;

ALTER TABLE section
RENAME COLUMN department TO enrollment;

create table exam(
c_number int,
s_number int,
r_number int,
foreign key(c_number) references course(c_number),
foreign key(s_number) references section(s_number),
foreign key(r_number) references room(r_number)
);

ALTER TABLE exam
ADD timing timestamp;

insert into room
values
(101,60,'A'),
(102,50,'A'),
(103,70,'B'),
(104,100,'B');

insert into course
values
(401,'DBMS','CET'),
(402,'FSD','CET'),
(403,'ESD','ECE'),
(404,'Electronics','ECE');

insert into section
values
(402,3,400),
(403,8,620),
(404,4,500),
(401,6,420);

insert into exam
values
(401,6,101,'2022-10-22 10:00:00'),
(402,3,103,'2022-10-22 14:00:00'),
(403,8,102,'2022-10-23 10:00:00'),
(404,4,104,'2022-10-23 14:00:00');

#List the course and no. of sections in each Course.
select course.name,section.s_number
from course inner join section
on course.c_number=section.c_number;

#List the course and no. of sections in each Course in CET department.
select course.name,section.s_number
from course inner join section
on course.c_number=section.c_number
where course.department='CET';

#Display the course number and no of sections in each course in CET department where no of sections are more than 5;
select course.name,section.s_number
from course inner join section
on course.c_number=section.c_number
where course.department='CET' and s_number>5;

#Display c-number, name ,department of such courses whose exam is conducted in ‘A’ building.
select * 
from course
where course.c_number in
(select exam.c_number 
from exam inner join room
on exam.r_number=room.r_number
where room.building='A');

#Get exam details of course ‘DBMS’;
select *
from exam inner join course
on exam.c_number=course.c_number
where course.name='DBMS';

#Display the exam room number, its capacity and building for course ‘DBMS’
select exam.r_number,room.capacity,room.building
from exam inner join room
on exam.r_number=room.r_number
where exam.r_number in
(select exam.r_number 
from exam inner join course
on exam.c_number=course.c_number
where course.name='DBMS');

#Display all the courses whose total enrollment is greater than total enrollment of course ’DBMS’.
select course.name
from course inner join section
on course.c_number=section.c_number
where section.enrollment>
(select section.enrollment 
from section inner join course
on section.c_number=course.c_number
where course.name='DBMS');

#Display all the courses whose total enrollment is greater than total enrollment of every course in CET department.
select course.name
from course inner join section
on course.c_number=section.c_number
where section.enrollment>
(select max(section.enrollment) 
from section inner join course
on section.c_number=course.c_number
where course.department='CET');

#Display course no, name, department , section and enrollment of each course.
select course.c_number,course.name,course.department,section.s_number,section.enrollment
from course inner join section
on course.c_number=section.c_number;

#Create one view
CREATE VIEW First_View AS
SELECT name,department
FROM Course
WHERE department = 'ECE';

SELECT * FROM First_View;