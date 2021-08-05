-- Question 1
SELECT first_name, last_name, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district LIKE 'Texas';

-- Question 2
SELECT first_name, last_name, payment.payment_id, payment.amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;

-- Question 3
SELECT first_name, last_name, SUM(amount)
FROM (
	SELECT payment.customer_id, first_name, last_name, amount
	FROM payment
	INNER JOIN customer
	ON customer.customer_id = payment.customer_id
) AS customer_payments
GROUP BY first_name, last_name
HAVING SUM(amount) > 175;

-- Question 4
SELECT first_name, last_name, customer.address_id, address.city_id, country.country_id, country.country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Nepal';

-- Question 5
SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(payment_id) AS num_transactions
FROM payment
INNER JOIN staff
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
ORDER BY num_transactions DESC
LIMIT 1

-- Question 6
SELECT film.title, actor.first_name, actor.last_name
FROM film
INNER JOIN film_actor
ON film.film_id = film_actor.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
-- ran out of time. Will try to finish 8-9 pm or right after class.
