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
SELECT title, COUNT(title) AS num_actors
FROM (
	SELECT actor.first_name, actor.last_name, film.title
	FROM film
	INNER JOIN film_actor
	ON film.film_id = film_actor.film_id
	INNER JOIN actor
	ON film_actor.actor_id = actor.actor_id
	ORDER BY title
) AS most_actors
GROUP BY title
ORDER BY num_actors DESC
-- Inner subquery grabs the titles and actor names. Outer query counts the number of titles, where each count is unique to an actor, therefore
-- each title count means a unique actor

-- Question 7
SELECT first_name, last_name, max_amount
FROM (
	SELECT first_name, last_name, MAX(payment.amount) AS max_amount
	FROM customer
	INNER JOIN payment
	ON customer.customer_id = payment.customer_id
	GROUP BY first_name, last_name
) AS customer_amount
WHERE max_amount > 6.99
ORDER BY first_name
-- Inner subquery grabs the customer name and finds the maximum transaction for that customer, making sure every customer only appear
-- once. The outer query grabs the maximum single payment and filters out by >$6.99

-- Question 8
SELECT category, COUNT(category)
FROM (
	SELECT title, category.name AS category
	FROM film
	INNER JOIN film_category
	ON film.film_id = film_category.film_id
	INNER JOIN category
	ON film_category.category_id = category.category_id
) AS category_count
GROUP BY category
ORDER BY COUNT(category) DESC
-- Inner subquery grabs the title and category. The outer query counts the category and orders the count in descending order, showing
-- the most prevalent category as the first row