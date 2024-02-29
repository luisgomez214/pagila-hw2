/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

select rank, title, revenue, "total revenue",
CASE
        WHEN (100 * "total revenue" / SUM(revenue) OVER ()) < 100
            THEN trim(to_char((100 * "total revenue" / SUM(revenue) OVER ()), '00.00'))
        ELSE trim('100.00')
    END AS "percent revenue"
from (
select rank, title, revenue, SUM(revenue) OVER (order BY rank) AS "total revenue"
from (
select RANK () OVER (
    ORDER BY COALESCE(SUM(amount), 0.00) DESC
    ) rank, title, COALESCE(SUM(amount), 0.00) as revenue
from film
left join inventory using (film_id)
left join rental using (inventory_id)
left join payment using (rental_id)
group by title
) as t
) as u
order by rank, title;
