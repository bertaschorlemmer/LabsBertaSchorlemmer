-- EJERCICIO 1

SELECT officeCode, phone
FROM offices;

SELECT employeeNumber, firstName, lastName, email
FROM employees
WHERE email LIKE '%.es';

SELECT customerNumber, customerName, city, country
FROM customers
WHERE state IS NULL;

SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 20000;

SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 20000 AND YEAR(paymentDate) = 2005;

SELECT DISTINCT productCode
FROM orderdetails;

SELECT country, COUNT(*) AS total_compras
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY country
ORDER BY total_compras DESC;

-- EJERCICIO 2

SELECT productLine, textDescription, LENGTH(textDescription) AS longitud
FROM productlines
ORDER BY LENGTH(textDescription) DESC
LIMIT 1;

-- numero EMPLEADOS asociados a cada oficina

SELECT e.officeCode, COUNT(c.customerNumber) AS total_clientes
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY e.officeCode;

SELECT DAYNAME(o.orderDate) AS dia_semana, COUNT(*) AS total_ventas
FROM orders o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN products p ON od.productCode = p.productCode
WHERE p.productLine = 'Classic Cars'
GROUP BY dia_semana
ORDER BY total_ventas DESC
LIMIT 1;

SELECT officeCode, city,
       CASE WHEN territory IS NULL OR territory = 'NA' THEN 'USA'
		ELSE territory
       END AS territory_corregido
FROM offices;

-- usar subconsultas

SELECT anio, mes,
       AVG(totalCarrito) AS promedioCarrito,
       SUM(totalArticulos) AS totalArticulos
FROM (SELECT YEAR(o.orderDate) AS anio,
          MONTH(o.orderDate) AS mes,
          (od.quantityOrdered * od.priceEach) AS totalCarrito,
          od.quantityOrdered AS totalArticulos
   FROM employees e
   JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
   JOIN orders o ON c.customerNumber = o.customerNumber
   JOIN orderdetails od ON o.orderNumber = od.orderNumber
   WHERE e.lastName = 'Patterson'
     AND YEAR(o.orderDate) IN (2004, 2005)
) AS sub
GROUP BY anio, mes
ORDER BY anio, mes;

SELECT DISTINCT o.officeCode, o.city, o.country
FROM offices o
JOIN employees e ON o.officeCode = e.officeCode
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE c.state IS NULL OR c.state = '';





