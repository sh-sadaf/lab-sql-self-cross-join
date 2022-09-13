-- 1.Get all pairs of actors that worked together.
use sakila;

SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS a1_actor_name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS a2_actor_name,
    fa1.actor_id,
    fa1.film_id,
    fa2.actor_id
FROM
    film_actor AS fa1
        JOIN
    film_actor AS fa2 ON fa1.film_id = fa2.film_id
        JOIN
    actor AS a1 ON a1.actor_id = fa1.actor_id
        JOIN
    actor AS a2 ON a2.actor_id = fa2.actor_id
        AND fa1.actor_id > fa2.actor_id
ORDER BY a1.actor_id;


# 2. Get all pairs of customers that have rented the same film more than 3 times.
SELECT 
    c1 AS CUSTOMER_1, c2 AS customer_2, rentals
FROM
    (SELECT 
        A.CUSTOMER_ID AS C1,
            B.CUSTOMER_ID AS C2,
            SUM(b.rentals) AS rentals
    FROM
        (SELECT 
        r.customer_id, i.film_id, COUNT(DISTINCT rental_id) rentals
    FROM
        rental AS r
    LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
    GROUP BY r.customer_id , i.film_id) A
    LEFT JOIN (SELECT 
        r.customer_id, i.film_id, COUNT(DISTINCT rental_id) rentals
    FROM
        rental AS r
    LEFT JOIN inventory AS i ON i.inventory_id = r.inventory_id
    GROUP BY r.customer_id , i.film_id) B ON a.film_id = b.film_id
        AND a.customer_id < b.customer_id
        AND a.rentals >= b.rentals
    GROUP BY 1 , 2
    HAVING rentals > 3) AS a
ORDER BY 1;


# 3. Get all possible pairs of actors and films.
SELECT 
    *
FROM
    (SELECT DISTINCT
        first_name, last_name
    FROM
        actor) sub1
        CROSS JOIN
    (SELECT 
        title
    FROM
        film) sub2;





