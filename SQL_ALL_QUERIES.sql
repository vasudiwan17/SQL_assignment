STEP 1

mysql> SELECT c.first_name, c.last_name, a.phone, ci.city, co.country
    -> FROM customer c
    -> JOIN address a ON c.address_id = a.address_id
    -> JOIN city ci ON a.city_id = ci.city_id
    -> JOIN country co ON ci.country_id = co.country_id
    -> WHERE co.country = 'India'
    -> ORDER BY c.first_name ASC;

STEP 2

mysql> SELECT SUM(amount) AS total_payments
    -> FROM payment;
mysql> SELECT AVG(amount) AS average_payment
    -> FROM payment;

STEP 3

mysql> SELECT
    ->     c.first_name,
    ->     c.last_name,
    ->     SUM(p.amount) AS total_paid
    -> FROM customer c
    -> JOIN payment p ON c.customer_id = p.customer_id
    -> GROUP BY c.customer_id, c.first_name, c.last_name
    -> ORDER BY total_paid DESC;

STEP 4

mysql> SELECT
    ->     r.rental_id,
    ->     c.first_name,
    ->     c.last_name,
    ->     f.title AS film_title,
    ->     r.rental_date,
    ->     r.return_date
    -> FROM rental r
    -> JOIN customer c ON r.customer_id = c.customer_id
    -> JOIN inventory i ON r.inventory_id = i.inventory_id
    -> JOIN film f ON i.film_id = f.film_id
    -> ORDER BY r.rental_date DESC
    -> LIMIT 20;

STEP 5

mysql> SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
    -> FROM customer c
    -> JOIN payment p ON c.customer_id = p.customer_id
    -> GROUP BY c.customer_id, c.first_name, c.last_name
    -> HAVING SUM(p.amount) > (
    ->     SELECT AVG(total) FROM (
    ->         SELECT SUM(amount) AS total
    ->         FROM payment
    ->         GROUP BY customer_id
    ->     ) AS sub
    -> )
    -> ORDER BY total_paid DESC;

STEP 6

mysql> CREATE VIEW TopRentedFilms AS
    -> SELECT
    ->     f.title AS film_title,
    ->     COUNT(r.rental_id) AS times_rented
    -> FROM rental r
    -> JOIN inventory i ON r.inventory_id = i.inventory_id
    -> JOIN film f ON i.film_id = f.film_id
    -> GROUP BY f.film_id, f.title
    -> ORDER BY times_rented DESC;
mysql> SELECT * FROM TopRentedFilms
    -> LIMIT 10;

STEP 7

mysql> CREATE INDEX index_customer_id ON payment(customer_id);
mysql> SHOW INDEX FROM payment;