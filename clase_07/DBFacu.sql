CREATE TABLE carreras(
	id_carr CHAR(4) PRIMARY KEY CHECK (id_carr > ''),
	nombre VARCHAR(40)
);

CREATE TABLE materias(
	mat INTEGER PRIMARY KEY,
	nombre VARCHAR(20),
	CONSTRAINT CHL_Materias_mat CHECK (mat > 0)
);	

CREATE TABLE alumnos (
	leg INTEGER,
	nom VARCHAR(20),
	ape VARCHAR(20) NOT NULL DEFAULT 'Desconocido',
	cuota DECIMAL(9,2),
	matr DECIMAL(9,2),
	id_carr char(4)
);

ALTER TABLE alumnos ADD CONSTRAINT PK_Alumnos PRIMARY KEY(leg);
ALTER TABLE alumnos ADD CONSTRAINT FK_Alumnos_id_carr FOREIGN KEY (id_carr) REFERENCES carreras ON UPDATE cascade ON DELETE cascade;
ALTER TABLE alumnos ADD CONSTRAINT CHK_Alumnos_leg CHECK (leg > 50);

CREATE TABLE finales(
	fec DATE,
	mat INTEGER,
	leg INTEGER,
	nota INTEGER CHECK (nota >= 0 AND nota <= 10),
	CONSTRAINT CHK_Fecha CHECK (fec >= '2000-01-01')
);

ALTER TABLE finales ADD CONSTRAINT PK_Finales PRIMARY KEY(fec, mat, leg);
ALTER TABLE finales ADD CONSTRAINT FK_Finales_mat FOREIGN KEY (mat)
										REFERENCES materias ON UPDATE CASCADE ON DELETE NO ACTION;
ALTER TABLE finales ADD CONSTRAINT FK_Finales_leg FOREIGN KEY (leg) 
										REFERENCES alumnos ON UPDATE CASCADE ON DELETE CASCADE;
										
										
										SELECT f1.leg, f1.mat, f1. nota, f2.leg, f2.mat, f2.nota
    FROM finales f1, finales f2
        ORDER BY f1.leg;

SELECT f1.leg, f1.mat, f1. nota, f2.leg, f2.mat, f2.nota
    FROM finales f1, finales f2
        WHERE f1.leg = f2.leg
        AND f1.nota > f2.nota
        AND f1.nota >= 4
        AND f2.nota >= 4
        ORDER BY f1.leg;

SELECT f.*, m.* FROM finales f, Materias m, Alumnos acciones
    WHERE f.mat = m.mat
    AND f.leg = a.leg
    AND fec BETWEEN '2008-12-01' AND '2009-03-30';

--(Es lo mismo que el producto CARTESIANO)
SELECT f.*, m.* FROM finales f INNER JOIN Materias m ON f.mat = m.mat
    WHERE FEC BETWEEN '2008-12-01' AND '2009-03-30'
        ORDER BY f.leg;

SELECT f.*, nombre, nom, aparezca
    FROM finales f INNER JOIN materias m ON f.mat = m.mat
        INNER JOIN alumnos a ON f.leg = a.leg
            WHERE fec BETWEEN '2008-12-01' AND '2009-03-30';