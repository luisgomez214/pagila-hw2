/* 
* A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */

select distinct film.title
from film
where film.film_id not in (
    select  distinct film.film_id
    from film
join inventory using (film_id)
join rental using (inventory_id)
join customer using (customer_id)
join address using (address_id)
join city using (city_id)
join country using (country_id)
where country = 'United States')
and film.film_id in (
    select inventory.film_id
    from inventory
)
order by film.title;



