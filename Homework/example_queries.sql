--a. Be able to extract total count of each entities from DB 
select count(*) from seb_api.books;
select count(*) from seb_api.characters;
select count(*) from seb_api.houses;

--b. Be able to extract list of all book names, authors, release dates and character names,
--genders and titles mentioned in the book in the best manner for human-readable format.

with agg_titles as (
	select  
		ctt.character_id,
		string_agg(distinct tit.title, ', ' order by tit.title asc) as titles
	from seb_api.character_to_title ctt
	join seb_api.titles tit on ctt.title_id = tit.title_id
	group by 
		ctt.character_id	)
select 
	boo.book_name,
	aut.author_name,
	boo.release_date::timestamp::date,
	cha.character_name,
	cha.gender,
	agt.titles
from seb_api.books boo
left join seb_api.book_to_author bta on boo.book_id = bta.book_id
left join seb_api.authors aut on bta.author_id = aut.author_id
left join seb_api.book_to_character btc on boo.book_id = btc.book_id
left join seb_api.characters cha on btc.character_id = cha.character_id
left join agg_titles agt on cha.character_id = agt.character_id
order by 1,2,4;


--c. Be able to extract list of all character names and played by actor names. 

with agg_actors as(
	select  
		cta.character_id,
		string_agg(distinct act.actor_name, ', ' order by act.actor_name asc) as actors
	from seb_api.character_to_actor cta
	join seb_api.actors act on cta.actor_id = act.actor_id
	group by 
		cta.character_id
	)
select distinct
	cha.character_name,
	aga.actors
from seb_api.characters cha
left join agg_actors aga on cha.character_id = aga.character_id
where aga.actors is not null
order by cha.character_name;


--d. Be able to extract list of all house names, regions, overlord names and sworn member names.
select 
	ove.house_name as overlord,
	hau.house_name,
	hau.region,
	cha.character_name
from seb_api.houses hau
left join seb_api.houses ove on hau.house_id = ove.overlord_id
join seb_api.sworn_member swm on hau.house_id = swm.house_id
join seb_api.characters cha on swm.character_id = cha.character_id
order by 
	ove.house_name,
	cha.character_name;