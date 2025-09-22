SELECT * FROM clientes;
SELECT * FROM empleados;
SELECT * FROM tiendas;
SELECT * FROM prendas;

SELECT nombre_cliente FROM clientes
WHERE nombre_cliente LIKE "L%";

SELECT COUNT(id_cliente) FROM clientes;

SELECT * FROM compras
WHERE fecha_compra > '2023-05-01';

UPDATE clientes
SET email_cliente = 'miguel@nuevocorreo.com'
WHERE id_cliente = 5;

SELECT * FROM prendas
WHERE color = 'Negro';

SELECT * FROM tiendas
WHERE ciudad = 'Madrid';

SELECT COUNT(*) AS cantidad_prendas FROM prendas
WHERE precio > 50;

SELECT * FROM empleados
WHERE tienda_id = 1;

SELECT * FROM clientes
WHERE nombre_cliente LIKE '%Andrés%';

SELECT * FROM compras
WHERE id_cliente = 2;

DELETE FROM compras
WHERE monto_total <30;

SELECT * FROM prendas
WHERE precio BETWEEN 20 AND 40;

SELECT * FROM empleados
WHERE nombre_empleado LIKE '%a%';

SELECT * FROM prendas
ORDER BY precio DESC
LIMIT 5;

SELECT * FROM compras
WHERE id_cliente = 1 AND monto_total > 75;

SELECT * FROM prendas
WHERE talla = 'M';

UPDATE prendas
SET talla = 'L'  
WHERE id_prenda = 10; 

SELECT * FROM empleados
WHERE fecha_contratacion > '2022-01-01';

SELECT * FROM tiendas
WHERE ciudad = 'Barcelona';

SELECT * FROM compras
WHERE fecha_compra < '2023-07-01';

SELECT * FROM prendas
WHERE tipo_prenda LIKE '%eta';

SELECT * FROM clientes
WHERE email_cliente NOT LIKE '%hotmail%';

SELECT COUNT(*) AS compras_septiembre
FROM compras
WHERE fecha_compra >= '2023-09-01' AND fecha_compra < '2023-10-01';

UPDATE tiendas
SET direccion = 'Nueva Dirección 123'
WHERE id_tienda = 2;  

SELECT * FROM prendas
WHERE tipo_prenda LIKE '%camiseta%';

DELETE FROM prendas
WHERE precio < 20;

SELECT * FROM tiendas
ORDER BY ciudad ASC;

SELECT * FROM empleados
WHERE puesto = 'Vendedor';

SELECT COUNT(*) AS total_blanco
FROM prendas
WHERE color = 'Blanco';

SELECT * FROM clientes
WHERE LENGTH(nombre_cliente) > 10;

SELECT * FROM compras
WHERE monto_total BETWEEN 50 AND 100;

SELECT * FROM compras
ORDER BY fecha_compra DESC   
LIMIT 3;

SELECT color, COUNT(*) AS total_prendas FROM prendas
GROUP BY color;

INSERT INTO tiendas (id_tienda, nombre_tienda, ciudad, direccion)
VALUES 
(6, 'Moda Centro', 'Madrid', 'Calle Mayor 123'),
(7, 'Estilo Urbano', 'Madrid', 'Gran Vía 45');
  
UPDATE clientes
SET nombre_cliente = 'Micaela Torres',
    email_cliente='micaela.torres@ejemplo.com'
WHERE nombre_cliente = 'Miguel Torres';


  