-- Crear la BBDD

CREATE DATABASE Restaurante;

USE Restaurante;
 
-- Crear tabla de ventas

CREATE TABLE sales (

    customer_id VARCHAR(10),

    order_date DATE,

    product_id INT

);
 
INSERT INTO sales (customer_id, order_date, product_id) VALUES

('A', '2021-01-01', 1),

('A', '2021-01-01', 2),

('A', '2021-01-07', 2),

('A', '2021-01-10', 3),

('A', '2021-01-11', 3),

('A', '2021-01-11', 3),

('B', '2021-01-01', 2),

('B', '2021-01-02', 2),

('B', '2021-01-04', 1),

('B', '2021-01-11', 1),

('B', '2021-01-16', 3),

('B', '2021-02-01', 3),

('C', '2021-01-01', 3),

('C', '2021-01-01', 3),

('C', '2021-01-07', 3);
 
-- Crear tabla del menú

CREATE TABLE menu (

    product_id INT,

    product_name VARCHAR(50),

    price INT

);
 
INSERT INTO menu (product_id, product_name, price) VALUES

(1, 'sushi', 10),

(2, 'curry', 15),

(3, 'ramen', 12);
 
-- Crear tabla de miembros

CREATE TABLE members (

    customer_id VARCHAR(10),

    join_date DATE

);
 
INSERT INTO members (customer_id, join_date) VALUES

('A', '2021-01-07'),

('B', '2021-01-09');
 
----------------------------------------------------

-- 1. Total gastado por cada cliente

SELECT s.customer_id, SUM(m.price) AS total_gastado
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;
 
-- 2. Días visitados por cliente

SELECT customer_id, COUNT(DISTINCT order_date) AS dias_visitados
FROM sales
GROUP BY customer_id;
 
-- 3. Primer artículo comprado por cada cliente

SELECT s.customer_id, m.product_name, s.order_date
FROM sales s
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date = (
	SELECT MIN(order_date)
	FROM sales
	WHERE customer_id = s.customer_id
);
 
-- 4. Artículo más comprado en el menú

SELECT m.product_name, COUNT(*) AS veces_comprado
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY veces_comprado DESC
LIMIT 1;
 
-- 5. Artículo más popular por cliente

SELECT c.customer_id, c.product_name, c.veces
FROM (SELECT s.customer_id, m.product_name, COUNT(*) AS veces
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
) AS c
JOIN (SELECT customer_id, MAX(veces) AS max_veces 
FROM (SELECT s.customer_id, m.product_name, COUNT(*) AS veces
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
) AS sub
GROUP BY customer_id
) AS m ON c.customer_id = m.customer_id AND c.veces = m.max_veces; 

-- 6. Primer artículo después de ser miembro

SELECT s.customer_id, m.product_name, s.order_date
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date = (
	SELECT MIN(order_date)
    FROM sales
    WHERE customer_id = s.customer_id
      AND order_date >= mb.join_date
);

-- 7. Artículo justo antes de ser miembro

SELECT s.customer_id, m.product_name, s.order_date
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date = (
    SELECT MAX(order_date)
	FROM sales
	WHERE customer_id = s.customer_id AND order_date < mb.join_date
);
 
-- 8. Total artículos y gasto antes de ser miembro

SELECT s.customer_id, COUNT(*) AS total_articulos, SUM(m.price) AS total_gastado
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id;
 
-- 9. Puntos con regla normal (sólo miembros después de join_date)

SELECT s.customer_id,
SUM(CASE WHEN m.product_name = 'sushi' THEN m.price * 20 ELSE m.price * 10 END) AS puntos
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date >= mb.join_date
GROUP BY s.customer_id;
 
-- 10. Puntos con primera semana doble

SELECT s.customer_id,
SUM(CASE WHEN s.order_date BETWEEN mb.join_date AND DATE_ADD(mb.join_date, INTERVAL 6 DAY) THEN m.price * 20 
WHEN m.product_name = 'sushi' THEN m.price * 20 ELSE m.price * 10 END) AS puntos
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mb ON s.customer_id = mb.customer_id
WHERE s.order_date >= mb.join_date
AND s.order_date <= '2021-01-31'
GROUP BY s.customer_id;
 