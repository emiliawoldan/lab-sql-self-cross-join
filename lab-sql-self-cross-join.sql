/*
Instructions
1. Get all pairs of actors that worked together.
2. Get all pairs of customers that have rented the same film more than 3 times.
3. Get all possible pairs of actors and films.
*/
-- 1
SELECT a1.actor_id AS act_1, a2.actor_id AS act_2 FROM sakila.film_actor AS a1
JOIN sakila.film_actor AS a2
ON a1.actor_id > a2.actor_id
AND a1.film_id = a2.film_id;
-- order by a1.film_id;

-- 2
SELECT r1.customer_id, r2.customer_id, count(r1.rental_id) AS same_title FROM sakila.rental r1
JOIN sakila.rental AS r2
ON r1.customer_id <> r2.customer_id
AND r1.inventory_id = r2.inventory_id
GROUP BY r1.customer_id, r2.customer_id
HAVING count(r1.rental_id) > 3;

-- 3
	-- version 1
SELECT a1.actor_id AS act_1, a2.actor_id AS act_2, a1.film_id AS film_1, a2.film_id AS film_2 FROM sakila.film_actor AS a1
JOIN sakila.film_actor AS a2
ON a1.actor_id > a2.actor_id
AND a1.film_id > a2.film_id;
-- order by a1.film_id;

	-- version 2
select * from (
	select first_name, last_name from sakila.actor 
) as A
cross join 
(select title from film) as B;

-- ###
select * from (
	select first_name, last_name, title from actor a 
	join film_actor fa using(actor_id) 
	join film f using(film_id) ) as A
cross join 
(select first_name, last_name, title from actor a 
	join film_actor fa using(actor_id) 
	join film f using(film_id)) as B;