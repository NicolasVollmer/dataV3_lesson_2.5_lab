#### Lab | SQL Queries - Lesson 2.5

# 1. Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor
WHERE first_name = 'Scarlett'; 

# 2. How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(inventory_id) - (COUNT(rental_date) - COUNT(return_date)) AS 'Stock available to rent', 
COUNT(rental_date) - COUNT(return_date) AS 'currently rented out' FROM sakila.rental, sakila.inventory;
-- maybe I overthought this, but I assume you wanted to know the difference of movies in stock and movies that are
-- currently out for rent and tried to do this with calculations above, but it didn't work...

# 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT 
	MIN(length) AS 'min_duration',
	MAX(length) AS 'max_durtation'
FROM sakila.film;

# 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT AVG(length) FROM sakila.film; 
-- above could still use work to force to format h,mm

# 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) FROM sakila.actor;

# 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(max(last_update), min(rental_date)) AS 'days in operation' FROM sakila.rental;

# 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT rental_id, rental_date, 
	date_format(CONVERT(LEFT(rental_date,11),date), '%W') AS 'weekday', 
    date_format(CONVERT(LEFT(rental_date,11),date), '%M') AS 'month'
FROM sakila.rental LIMIT 20;

# 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT rental_id, rental_date, 
	date_format(CONVERT(LEFT(rental_date,11),date), '%W') AS 'weekday', 
	date_format(CONVERT(LEFT(rental_date,11),date), '%M') AS 'month',
	CASE
		WHEN date_format(CONVERT(LEFT(rental_date,11),date), '%W') = 'Saturday' THEN 'weekend'
		WHEN date_format(CONVERT(LEFT(rental_date,11),date), '%W') = 'Sunday' THEN 'weekend'
		ELSE 'workday'
	END AS 'day_type',
FROM sakila.rental;
-- really thought that would work...

# 9. Get release years.
SELECT title, release_year FROM sakila.film;

# 10. Get all films with ARMAGEDDON in the title.
SELECT * FROM sakila.film
WHERE title LIKE '%armageddon%';

# 11. Get all films which title ends with APOLLO.
SELECT * FROM sakila.film
WHERE title LIKE '%apollo';

# 11. Get 10 the longest films.
SELECT * FROM sakila.film
ORDER BY length desc
LIMIT 10; 

# 12. How many films include Behind the Scenes content?
SELECT COUNT(*) FROM sakila.film
WHERE special_features like '%Behind the Scenes%';