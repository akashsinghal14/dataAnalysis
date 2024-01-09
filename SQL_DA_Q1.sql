--problem statement-
--find the total time A or B visited, which floor each(A,B) visited most and what resources they used it should not be duplicateda 

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')


select * from entries


with cte as(
select name, count(*) over(partition by name) as totalname
,floor
, count(*) over(partition by floor,name) as maxn
--,resources
from entries
)
--select name, max(totalname) as total_visits, floor as most_visited_floor--,maxn
--from cte
----where maxn=2
--group by name, floor--,maxn
--having max(maxn)=2


select firstQ.*,secondQ.resources
from(
select name, max(totalname) as total_visits, floor as most_visited_floor
from cte
where maxn=2
group by name, floor
--having max(maxn)=floor
) firstQ
inner join 
(
select  name, STRING_AGG(resources,',') as resources
from (select distinct name, resources from entries) a
group by name
) secondQ
on firstQ.name = secondQ.name
