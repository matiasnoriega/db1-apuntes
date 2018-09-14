SELECT NyApe FROM clientes WHERE saldocli < 0 ORDER BY NyApe ASC;
SELECT * FROM CLIENTES;
SELECT descripcion FROM articulos WHERE stock <= pto_reposicion;

SELECT NYAPE, localidad, saldocli FROM CLIENTES WHERE (localidad = 'Capital Federal' OR localidad ILIKE 'Mor_n') AND SALDOCLI >= 0;

SELECT count(NyApe) FROM clientes WHERE saldocli < 0;

SELECT localidad, SUM(saldocli*1,21) as "Saldo Deudor", count(*) as "Cantidad de Clientes" 
FROM clientes 
WHERE saldocli < 0 
GROUP BY localidad 
HAVING (


