alter table user_gameplay_data 
add column month_name VARCHAR(20)
add column only_date DATE,
add column only_time TIME,
add column time_slot VARCHAR(2);

update
	user_gameplay_data ugd
set
	only_date = date(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')),
	only_time = TIME(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')),
	time_slot = case
		when hour(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')) < 12 then 'S1'
		else 'S2'
	end;

alter table withdrawal_data  
add column month_name VARCHAR(20)
add column only_date DATE,
add column only_time TIME,
add column time_slot VARCHAR(2);

update
	withdrawal_data wd
set
	only_date = date(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')),
	only_time = TIME(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')),
	time_slot = case
		when hour(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')) < 12 then 'S1'
		else 'S2'
	end;

alter table deposit_data 
add column month_name VARCHAR(20)
add column only_date DATE,
add column only_time TIME,
add column time_slot VARCHAR(2);

update
	deposit_data dd
set
	only_date = date(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')),
	only_time = TIME(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')),
	time_slot = case
		when hour(STR_TO_DATE(`Datetime`, '%d-%m-%Y %H:%i:%s')) < 12 then 'S1'
		else 'S2'
	end;

update
	deposit_data dd
set
	month_name = MONTHNAME(only_date);

update
	user_gameplay_data ugd
set
	month_name = MONTHNAME(only_date);

update
	withdrawal_data wd
set
	month_name = MONTHNAME(only_date);

#same query can be used for the question 1
#not considering month as the data is of one month only
select
	dd.user_id, dd.only_date,
	(0.01 * sum(dd.amount) + 
	   0.005 * sum(wd.amount) + 
	   0.001 * GREATEST(count(dd.amount) - count(wd.amount), 0) + 
	   0.2 * sum(ugd.games_played)) as loyalty
from
	deposit_data as dd
inner join user_gameplay_data as ugd on
	dd.user_id = ugd.user_id
inner join withdrawal_data as wd on
	ugd.user_id = wd.User_Id
where day(dd.only_date) = 16 and dd.time_slot = 's2' 
group by
	dd.User_Id, dd.only_date 
order by loyalty desc
limit 10

#to find the total number of users
select
	count(dd.user_id)
from
	deposit_data as dd
inner join user_gameplay_data as ugd on
	dd.user_id = ugd.user_id
inner join withdrawal_data as wd on
	ugd.user_id = wd.User_Id
where day(dd.only_date) = 26 and dd.time_slot = 's2' 


#RANKING USERS

select
	dd.user_id,
	sum(dd.amount) as total_dd,
	sum(wd.amount) as total_wd,
	sum(ugd.games_played) as total_games,
	(0.01 * sum(dd.amount) + 
	   0.005 * sum(wd.amount) + 
	   0.001 * GREATEST(count(dd.amount) - count(wd.amount), 0) + 
	   0.2 * sum(ugd.games_played)) as loyalty,
	rank() over (
order by
	(
        0.01 * SUM(dd.amount) +
        0.005 * SUM(wd.amount) +
        0.001 * GREATEST(SUM(dd.amount) - SUM(wd.amount), 0) +
        0.2 * SUM(ugd.games_played)
      ) desc,
	SUM(ugd.games_played) desc
  ) as loyalty_rank
from
	deposit_data as dd
inner join user_gameplay_data as ugd on
	dd.user_id = ugd.user_id
inner join withdrawal_data as wd on
	ugd.user_id = wd.User_Id
group by
	dd.User_Id
order by
	loyalty desc
limit 50



#AVG DEPOSit

select avg(amount)
from deposit_data dd 

#avg deposit per user per month (there is only oct data given)

select avg(user_total) as avg_deposit_per_user
from (
select user_id, sum(amount) as user_total
     from deposit_data 
     group by user_id) as users_total

     
select avg(total_game)
from ( select user_id , sum(games_played) as total_game
       from user_gameplay_data 
       group by user_id ) as total_user_games