-- Punto K
SELECT c.nrocli, c.nyape, count(f.nrofactura) FROM 
                facturas f INNER JOIN clientes c ON c.nrocli = f.cliente
                    INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                    INNER JOIN articulos a ON d.articulo = a.nroartic
                        WHERE f.fecha >= '01-03-2010' AND f.fecha <= '30-04-2010' AND a.rubro = 3
                        GROUP BY c.nrocli, c.nyape
                            HAVING count(f.nrofactura) > 3
                            ORDER BY c.nrocli;

-- L) Calcular la cantidad de unidades del artículo 4040 vendidas en marzo del 2010.
--    (Rsta: 8 articulos)
SELECT SUM(d.cantidad) FROM
                    facturas f INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                        WHERE d.articulo = 4040 AND f.fecha BETWEEN '01-03-2010' AND '31-03-2010'

-- M) Calcular la cantidad de facturas en las que vendieron artículos del rubro 3
--    (Rsta: 27 facturas)

SELECT COUNT(DISTINCT f.nrofactura) FROM 
                    facturas f 
                    INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                    INNER JOIN articulos a ON  a.nroartic = d.articulo
                        WHERE EXISTS(SELECT 1 FROM articulos WHERE a.rubro = 3);

select f.nrofactura
	from facturas f join detalles d
	on f.nrofactura = d.nrofactura
	join articulos a 
	on a.nroartic = d.articulo
	group by f.nrofactura, a.rubro
	having a.rubro = 3;                        

--S) Listar los datos cabecera de las Facturas de mas de $200 y que la cantidad
--    de artículos facturados en la misma sea mayor al 5% del stock promedio
--    de los rubros "Herramienta%"
--    (Rsta: 5 FILAS)

SELECT f.* FROM facturas f 
                INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                WHERE d.cantidad > (SELECT SUM(stock)*0.05 FROM articulos a, rubros r WHERE a.rubro = r.cod_rubro AND r.descripcion LIKE 'Herramienta%') 
                GROUP BY f.nrofactura
                    HAVING SUM(d.preciouni) > 200

-------------------------------------------------------------------------
-- Hacer  I - 3 - G - H - Y - T - X

-- CLIENTES (Nrocli,     NyApe,       Domicilio, Localidad, Saldocli)
-- FACTURAS (Nrofactura, Cliente,     Fecha)
-- DETALLES (Nrofactura, Renglón,     Articulo,  Cantidad,  Preciouni)
-- ARTICULOS(Nroartic,   Descripción, Rubro,     Stock,     Pto_reposicion, precio)
-- RUBROS   (Cod_rubro,  Descripción)
--

-- I A) Averiguar los rubros con movimientos del 15 al 30 de Abril del 2010 (Rsta: 3 filas)
--

SELECT r.descripcion FROM
    facturas f INNER JOIN detalles d ON f.nrofactura = d.nrofactura
    INNER JOIN articulos a ON d.articulo = a.nroartic
    INNER JOIN rubros r ON a.rubro = r.cod_rubro
        WHERE f.fecha BETWEEN '15-04-2010' AND '30-04-2010'
            GROUP BY r.descripcion 
-- Ó

SELECT r.descripcion FROM facturas f, detalles d, articulos a, rubros r
    WHERE f.nrofactura = d.nrofactura 
    AND d.articulo = a.nroartic 
    AND a.rubro = r.cod_rubro 
    AND f.fecha BETWEEN '15-04-2010' AND '30-04-2010'
        GROUP BY r.descripcion
   

--------------------------------------------------------------------------------------
-- 3) Generar un unico Select con el o los articulos mas caros y con el o los mas baratos

SELECT * FROM ARTICULOS WHERE PRECIO = (SELECT MAX(PRECIO) FROM ARTICULOS);
SELECT MAX(precio) FROM articulos;
SELECT * FROM ARTICULOS WHERE PRECIO = (SELECT MIN(PRECIO) FROM ARTICULOS);
SELECT MIN(precio) FROM articulos;

--------------------------------------------------------------------------------------
-- G) Obtener las fechas en las que se hayan vendido m�s de $200.- (Rsta: filas 9)

SELECT f.fecha, sum(d.cantidad*d.preciouni) FROM facturas f INNER JOIN detalles d ON f.nrofactura = d.nrofactura
        GROUP BY f.fecha
            HAVING SUM(d.cantidad*d.preciouni) > 200;
--------------------------------------------------------------------------------------
-- H) Obtener las fechas en las que mas se facturo
--    (2010-03-17 - $429)

SELECT f.fecha, sum(d.cantidad*d.preciouni) as sumatoria FROM facturas f, detalles d
	WHERE f.nrofactura = d.nrofactura
    	group by f.fecha
            HAVING SUM(d.cantidad*d.preciouni) > AVG(d.cantidad*d.preciouni)
        	    order by sumatoria DESC
--------------------------------------------------------------------------------------
-- Y) Listar los clientes de 'Capital Federal' que NO compraron articulos del
--    rubro 'Articulos de Electricidad' durante mayo de a�o 2010.
--    Ordenar los datos en forma descendente por nombre y apellido.
--    (Rsta: 10 filas)

SELECT * FROM clientes
    WHERE localidad = 'Capital Federal'
    AND nrocli NOT IN (select cliente from facturas f, detalles d, articulos a, rubros r
	where f.nrofactura = d.nrofactura
    and d.articulo = a.Nroartic
    and a.rubro = r.cod_rubro
    and r.descripcion = 'Articulos de Electricidad'
    and f.fecha BETWEEN '01-05-2010' and '30-05-2010')
--------------------------------------------------------------------------------------
-- T) a) Listar los clientes compraron TODOS los articulos (1 fila - cliente 109)
--    b) Listar los clientes que en Junio compraron TODOS los articulos del rubro
--       "Tornillos". (2 filas - clientes 160 - 304)

SELECT c.* from clientes 
--------------------------------------------------------------------------------------
-- X) Generar una view con los articulos del rubro "Clavos"