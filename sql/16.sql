/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */

SELECT
    RANK() OVER (ORDER BY COALESCE(SUM(payment.amount), 0.00) DESC) AS rank,
    film.title AS title,
    COALESCE(SUM(payment.amount), 0.00) AS revenue
FROM
    film
LEFT JOIN
    inventory ON film.film_id = inventory.film_id
LEFT JOIN
    rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN
    payment ON rental.rental_id = payment.rental_id
GROUP BY
    film.title
ORDER BY
    rank, revenue DESC;

