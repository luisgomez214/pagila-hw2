/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 * /
 *
 */

SELECT f.title
FROM film f
INNER JOIN (
    SELECT film_id
    FROM film
    WHERE 'Behind the Scenes' = ANY(special_features)
) AS fs1 ON f.film_id = fs1.film_id
INNER JOIN (
    SELECT film_id
    FROM film
    WHERE 'Trailers' = ANY(special_features)
) AS fs2 ON f.film_id = fs2.film_id
order by f.title;
