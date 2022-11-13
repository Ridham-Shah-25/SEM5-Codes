#Using Database created in lab4
use lab4;

#Functions-Single Row:Concatenate name and department colums in course table
SELECT CONCAT (name,' - ' ,department) as concatenate
FROM course;

#Aggregate Functions:Display the room having maximum capacity
SELECT *
from room
where capacity=(select max(capacity) from room);

#Data Sorting:Using Order By Keyword
SELECT * from room
order by
capacity;

#SubQuery
select * from room
where
capacity=(select max(capacity) from room);

#Group by-Having
select *
from section
group by s_number
having s_number>5;

#Set Operations
select * from section
union
select * from course;

#View
CREATE VIEW View_1 AS
SELECT name,department
FROM Course
WHERE department = 'ECE';

SELECT * FROM View_1;

#TCL Commands:using commit,rollback command
commit;
start transaction;
savepoint first;
update room
set capacity=250
where r_number=101;

select * from room;
rollback to first;
select * from room;