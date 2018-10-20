SELECT c.nrocli, c.nyape, count(f.nrofactura) FROM 
                facturas f INNER JOIN clientes c ON c.nrocli = f.cliente
                    INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                    INNER JOIN articulos a ON d.articulo = a.nroartic
                        WHERE f.fecha >= '01-03-2010' AND f.fecha <= '30-04-2010' AND a.rubro = 3
                        GROUP BY c.nrocli, c.nyape
                            HAVING count(f.nrofactura) > 3
                            ORDER BY c.nrocli

SELECT COUNT(DISTINCT f.nrofactura) FROM 
                    facturas f 
                    INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                    INNER JOIN articulos a ON  a.nroartic = d.articulo
                        WHERE EXISTS(SELECT 1 FROM articulos WHERE a.rubro = 3);

-- J) Listar Numero y nombre de los cliente. Además, listar la cantidad de facturas que tuvo
--    durante Marzo y Abril del 2010 considerando SOLO las facturas en las que compro articulos
--    del rubro 3, ordenado por numero de cliente. (Rsta: 7 filas)
--

SELECT c.nrocli, c.nyape, count(f.nrofactura)
                    FROM clientes c INNER JOIN facturas f ON c.nrocli = f.cliente
                        INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                        INNER JOIN articulos a ON d.articulo = a.nroartic
                            WHERE EXISTS(SELECT 1 FROM detalles d WHERE  a.rubro = 3)
                            AND f.fecha BETWEEN '01-03-2010' AND '30-04-2010'
                                GROUP BY c.nrocli
-- MAL Porque aumenta la cardinalidad de facturas, porque no correlaciono con los detalles, hay más detalles que facturas y me los cuenta a todos.
SELECT c.nrocli, c.nyape, count(f.nrofactura)
                    FROM clientes c INNER JOIN facturas f ON c.nrocli = f.cliente
                        INNER JOIN detalles d ON f.nrofactura = d.nrofactura
                        INNER JOIN articulos a ON d.articulo = a.nroartic
                            WHERE f.nrofactura IN (SELECT nrofactura FROM detalles d WHERE a.rubro = 3)
                            AND f.fecha BETWEEN '01-03-2010' AND '30-04-2010'
                                GROUP BY c.nrocli                              

SELECT cliente, COUNT(*), c.nyape FROM facturas f, clientes c
                    WHERE c.nrocli = f.cliente AND fecha BETWEEN '01-03-2010' AND '30-04-2010' GROUP BY cliente

SELECT nrofactura FROM DETALLEs d, articulos a WHERE d.articulo = a.nroartic AND a.rubro = 3;			

-- USANDO IN
SELECT f.cliente, count(*), nyape
    FROM facturas f, clientes c
        WHERE fecha BETWEEN 
            '01-03-2010' AND '30-04-2010'
            AND c.nrocli = f.cliente
            AND nrofactura IN (SELECT nrofactura FROM DETALLEs d, articulos a WHERE d.nrofactura = f.nrofactura AND d.articulo = a.nroartic AND a.rubro = 3)
                GROUP BY f.cliente, nyape
                    HAVING count(*) > 2
                    AND count(*) < 5
-- USANDO EXISTS
SELECT f.cliente, count(*), nyape
    FROM facturas f, clientes c
        WHERE fecha BETWEEN 
            '01-03-2010' AND '30-04-2010'
            AND c.nrocli = f.cliente
            AND EXISTS (SELECT nrofactura FROM DETALLEs d, articulos a WHERE d.nrofactura = f.nrofactura AND d.articulo = a.nroartic AND a.rubro = 3)
                GROUP BY f.cliente, nyape
                    HAVING count(*) > 2
                    AND count(*) < 5

----------------------
Division en Alumnos (DBFacu)

error comun en la division ---> METER ATRIBUTOS DE MAS

select id_carr, localidad from alumnos l
	WHERE id_carr IS NOT NULL AND NOT EXISTS(SELECT id_carr FROM alumnos c 
					 		WHERE id_carr IS NOT NULL AND NOT EXISTS(select localidad, id_carr FROM alumnos x
											WHERE x.localidad = l.localidad
											AND x.id_carr = c.id_carr))

-- PRACTICA 10/EJERCICIO T/a
-- T) a) Listar los clientes compraron TODOS los articulos (1 fila - cliente 109)

SELECT c.* FROM clientes c 
        WHERE NOT EXISTS(SELECT nroartic FROM articulos a WHERE NOT EXISTS(
            SELECT cliente, articulo 
                FROM detalles d INNER JOIN facturas f ON d.nrofactura = f.nrofactura
                    WHERE f.cliente = c.nrocli
                    AND d.articulo = a.nroartic
        ))

-- RESPUESTA DISTINTA, MAS COMPLICADA

SELECT * 
    FROM clientes c
        WHERE (SELECT COUNT(*) FROM articulos)
        =
        (SELECT COUNT(*) FROM articulos
            WHERE nroartic IN(SELECT fd.articulo
                FROM facturas fc, detalles fd
                    WHERE fc.nrofactura = fd.nrofactura
                    AND fc.cliente = c.nrocli))

-- NOT IN / NOT EXISTS indispensable para restas, JOINS de tablas, GROUP BY y HAVING hacer el gropy by y del resultado hacer un having || ALGO ASOCIADO A LO DIAGRAMAS, ALGO ASOCIADO A ALGEBRA RELACIONAL Y ALGO RELACIONADO A SQL

Armar Modelo Relacional 