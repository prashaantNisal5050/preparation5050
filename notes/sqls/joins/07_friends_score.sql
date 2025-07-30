-- type: join
-- category: complex
-- resource :ankit bansal

-- 6. WAQ to find PersonID,name,number of friends who have friends with total score > 100

drop table friend 
Create table friend (pid int, fid int)

insert into friend (pid , fid ) values ('1','2'), ('1','3'), ('2','1'), ('2','3'), ('3','5'), ('4','2'), ('4','3'), ('4','5');

insert into person(PersonID,Name ,Score) values ('1','Alice','88'), ('2','Bob','11'), ('3','Devis','27'), ('4','Tara','45'), ('5','John','63');
drop table person
create table person (PersonID int,	Name varchar(50),	Score int)

select * from person
select * from friend

  
select p.personid, p.name,  count(f.fid)  as number_of_friends, sum(pp.score) as friends_total_score
  from person p 
  right join friend f on f.pid = p.personid
  left join person pp on pp.personid = f.fid
  group by p.personid, p.name
  having sum(pp.score) > 100

-- expected 
-- personid|name|number_of_friends|friends_total_score|
-- --------+----+-----------------+-------------------+
--        2|Bob |                2|                115|
--        4|Tara|                3|                101|