-- Consulta 1: Obtener el nombre completo, dirección y correo electrónico de todos los clientes
-- que han realizado pedidos en los últimos 30 días.
SELECT c.nombre, c.apellido, c.direccion, c.correo_electronico
FROM clientes c
JOIN pedidos p ON c.id = p.id_cliente
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- Consulta 2: Mostrar los productos con mayor cantidad de ventas en el último mes,
-- junto con el total vendido de cada uno.
SELECT pr.nombre, SUM(v.cantidad) AS total_vendido
FROM productos pr
JOIN ventas v ON pr.id = v.id_producto
JOIN pedidos p ON v.id_pedido = p.id
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY pr.nombre
ORDER BY total_vendido DESC;

-- Consulta 3: Listar los clientes que han realizado más pedidos en el último año,
-- ordenados por mayor cantidad de pedidos.
SELECT c.nombre, c.apellido, COUNT(p.id) AS total_pedidos
FROM clientes c
JOIN pedidos p ON c.id = p.id_cliente
WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.id
ORDER BY total_pedidos DESC;

-- 3b) Actualizaciones con UPDATE:

-- Actualización 1: Aumentar el precio de todos los productos de la categoría "Camisetas" en un 10%.
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Camisetas';

-- 3c) Eliminaciones con DELETE:

-- Eliminación 2: Eliminar los pedidos que no tengan ventas asociadas.
DELETE FROM pedidos
WHERE id NOT IN (SELECT DISTINCT id_pedido FROM ventas);

-- 3d) Creación de vistas:

-- Vista 1: Crear una vista llamada "vista_clientes_pedidos" que muestre el nombre completo del cliente,
-- la fecha del pedido y el total del pedido.
CREATE VIEW vista_clientes_pedidos AS
SELECT CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo, p.fecha, p.total
FROM clientes c
JOIN pedidos p ON c.id = p.id_cliente;