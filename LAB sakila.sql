USE sakila;

SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;

SELECT title FROM film;

SELECT * FROM language;
SELECT DISTINCT name AS language FROM language;

SELECT COUNT(store_id) AS tiendas_totales FROM store;
SELECT COUNT(staff_id) AS empleados FROM staff;

SELECT first_name, last_name FROM staff;

SELECT first_name, last_name FROM actor
WHERE first_name = "SCARLETT";

SELECT first_name, last_name FROM actor
WHERE last_name = "Johansson";

SELECT COUNT(inventory_id) FROM inventory;

SELECT DISTINCT COUNT(inventory_id) FROM rental;

SELECT MIN(rental_duration) FROM film;
SELECT MAX(rental_duration) FROM film;

SELECT MIN(length) AS min_duration FROM film;
SELECT MAX(length) AS max_duration FROM film;

SELECT AVG(length) AS avg_duration FROM film;

SELECT AVG(length) AS avg_duration_minutos,
    FLOOR(AVG(length) / 60) AS horas,
    FLOOR(AVG(length) % 60) AS minutos
FROM film;

SELECT COUNT(length) FROM film
WHERE length> (60*3);

SELECT CONCAT(CONCAT(LEFT(first_name, 1), LOWER(SUBSTRING(first_name, 2))), ' ', UPPER(last_name), ' - ', LOWER(email)) AS output
FROM customer;

SELECT MAX(LENGTH(title)) AS max_title_length FROM film;




