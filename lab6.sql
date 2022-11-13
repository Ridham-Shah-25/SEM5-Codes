create database lab6;
use lab6;

#Creating tables
create table flight(
flight_id int primary key,
 airline_id int, 
 from_loc varchar(255), 
 to_loc varchar(255), 
 depart_time datetime, 
 arrival_time datetime, 
 capacity int);

create table flight_details(
flight_id int, 
dep_date datetime, 
price int, 
available_seats int, 
foreign key (flight_id) references flight(flight_id));

create table passenger(
passenger_id int primary key, 
first_name varchar(255), 
last_name varchar(255), 
phone int, 
email varchar(255), 
age int);

create table ticket(
ticket_id int primary key,
passenger_id int,
flight_id int,
depart_date datetime,
status varchar(255),
foreign key (passenger_id) references passenger(passenger_id),
foreign key (flight_id) references flight(flight_id));

#inserting values into the table
insert into flight
values
(101,986,'MUM','DEL','2022-10-31 14:30:00','2022-10-31 16:30:00',100),
(102,986,'DEL','KOLKATTA','2022-11-01 14:30:00','2022-11-01 16:30:00',200),
(103,786,'DEL','MUM','2022-11-02 10:30:00','2022-11-02 13:30:00',300);

insert into flight_details
values
(101,'2022-10-31',10000,30),
(102,'2022-11-01',20000,50),
(103,'2022-11-02',25000,70);

UPDATE flight_details
set available_seats=0
where flight_id=103;

insert into passenger
values
(11,'Ridham','Shah',666,'ridham25@gmail.com',20),
(12,'Saurav','Bhise',366,'saurav@gmail.com',21),
(13,'Vismay','Joag',566,'vismay@gmail.com',20);

insert into ticket
values
(501,11,101,'2022-10-31',''),
(502,12,102,'2022-11-01',''),
(503,13,103,'2022-11-02','');

truncate table ticket;
select * from ticket;
delimiter //
create procedure BookTicket(in _ticket_id int,in _passenger_id int, in _flight_id int, in _departure_date date)
begin
	declare get_availability int default 0;
    declare new_available_seats int default 0;
	BEGIN
	  SELECT available_seats INTO get_availability
	  FROM Flight_details
	  WHERE flight_id= _flight_id;
	END;
	set new_available_seats = get_availability-1;
    if get_availability>0 then
		insert into Ticket(ticket_id,passenger_id, flight_id, depart_date, status) values(_ticket_id,_passenger_id, _flight_id,
        _departure_date, "confirmed");
        UPDATE Flight_details SET available_seats=new_available_seats WHERE flight_id=_flight_id;
	else
		insert into Ticket(ticket_id,passenger_id, flight_id, depart_date, status) values(_ticket_id,_passenger_id, _flight_id,
        _departure_date, "waiting");
	end if;

end

//

delimiter ;
show procedure status;
call BookTicket(501,11,101,'2022-10-31');
call BookTicket(502,12,102,'2022-11-01');
call BookTicket(503,13,103,'2022-11-02');

select * from ticket;

delimiter $$
create function Check_Availability (_first_name varchar(20), _last_name varchar(20))
	
    returns varchar(10)
    deterministic
begin
	declare get_passenger_id int default 0;
    declare get_flight_status varchar(10) default "waiting";
    BEGIN
	  SELECT passenger_id INTO get_passenger_id
	  FROM Passenger
	  WHERE first_name=_first_name and last_name=_last_name;
	END;
    begin
	select status into get_flight_status from Ticket where passenger_id=get_passenger_id;
    end;
    return get_flight_status;
end
$$
delimiter ;

select passenger_id
from passenger
where Check_Availability(first_name,last_name)='waiting';
