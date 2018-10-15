-- +-------------------------------------------------------------------+
-- |              Base de datos de la Universidad                      |
-- +-------------------------------------------------------------------+
--
--
-- Modelo Relacional de la base de datos DBFacu:
--   - CARRERAS     (*Id,Nombre)
--   - ALUMNOS	    (*Leg, Nom, Ape, id_carr)
--   - MATERIAS	    (*Mat, Nombre) 
--   - FINALES	    (*Fec, *Mat, *Leg, Nota)
--   - Profesores   (*Prof,NyA)
--   - Cursos       (*Mat, Prof, *Anio)
--   - Inscripciones(*Mat, *Anio, *Leg)
--
-- Instrucciones:
--   -> Ejecutar: Drop database If Exists DBFacu;
--                Create database DBFacu; 
--   -> Conectarse a la base DBFacu
--   -> Ejecutar el siguiente Scrip para generar las tablas y poblarlas
--
--                                                  Version: 2018-09-25
--
------------------Inicio script -----------------------------------------
--
Set Schema 'public'; 
Show search_path;
--
-- Drops:
Drop Table If Exists Finales;
Drop Table If Exists Alumnos;
Drop Table If Exists Materias;
Drop Table If Exists Carreras;
Drop Table If Exists Inscripciones;
Drop Table If Exists Cursos;
Drop Table If Exists Profesores;
--
--
-- CREAR LA TABLA CARRERAS(*ID,NOM)
--   -> id es un char de 4 bytes y > ' '
--   -> NOM es de 40 caracteres como maximo
--
--
Create table carreras 
(id     char(4) primary key,
 nom    varchar(40),
CONSTRAINT CHK_Carreras_id CHECK (id > ' '));
--
-- CREAR LA TABLA MATERIAS(*MAT,NOMBRE)
--   -> mat > 0
--
--
Create table materias 
(mat    integer,
 nombre varchar(20),
CONSTRAINT CHK_Materias_mat CHECK (mat >  0));
--
ALTER TABLE materias ADD CONSTRAINT Pk_Materias PRIMARY KEY(mat);
--
-- 
-- CREAR LA TABLA ALUMNOS(*LEG,NOM,APE,CUOTA,MATR,ID_CARR)
--   -> legajo > 50
--   -> valor default para apellido = 'Desconocido'
--   -> Indicar FKs
--   -> ASIGNAR LAS OPCIONES ON UPDATE + ON DELETE
--      (Cascade, Set Null, Set Default ó No Action)
--
--
Create table alumnos 
(leg    int,
 nom    varchar(20),
 ape    varchar(20) not null default 'Desconocido',
 cuota  decimal(9,2),
 matr   decimal(9,2),
 id_carr char(4) );
--
ALTER TABLE Alumnos ADD CONSTRAINT Pk_Alumnos PRIMARY KEY(leg);
ALTER TABLE Alumnos ADD CONSTRAINT CHK_Alumnos_leg CHECK (leg > 50);
ALTER TABLE Alumnos ADD CONSTRAINT FK_Alumnos_id_carr FOREIGN KEY (id_carr)
            REFERENCES carreras  ON UPDATE CASCADE ON DELETE CASCADE;
--
--
--ALTER TABLE Alumnos ADD CONSTRAINT FK_Alumnos_id_carr FOREIGN KEY (id_carr)
--            REFERENCES carreras  ON UPDATE set null ON DELETE set default;
--
--
-- CREAR LA TABLA FINALES(*FEC,*MAT(FK),*LEG(FK),NOTA) 
-- CONSIDERAR:
--   -> VALIDAR NOTAS
--   -> VALIDAR FECHA >= A 1-ENE-2000
--   -> Indicar FKs
--   -> ASIGNAR LAS OPCIONES ON UPDATE + ON DELETE
--       
--
--
Create table finales 
(fec    date,
 mat    int,
 leg    int,
 nota   int,
 CONSTRAINT CHK_NOTA  CHECK (nota >=0 AND nota <= 10),
 CONSTRAINT CHK_FECHA CHECK (fec >= '2000-01-01'),
 PRIMARY KEY (fec, mat, leg),
 FOREIGN KEY (mat) REFERENCES materias ON UPDATE CASCADE ON DELETE NO ACTION,
 FOREIGN KEY (leg) REFERENCES alumnos  ON UPDATE CASCADE ON DELETE CASCADE);
--
-- ejecutar para poblar las tablas
--
BEGIN TRANSACTION;
INSERT INTO CARRERAS VALUES ('SIST','LICENCIATURA DE SISTEMAS');
INSERT INTO CARRERAS VALUES ('ADMN','LICENCIATURA DE ADMIN. DE EMPRESA');
INSERT INTO CARRERAS VALUES ('BOGA','ABOGACIA');
COMMIT;
--
--
--
BEGIN TRANSACTION;
INSERT INTO ALUMNOS VALUES (69,'Juan','Martinez',500,700,'SIST');
INSERT INTO ALUMNOS VALUES (109,'Pedro','Garcia',550,600,'SIST');
INSERT INTO ALUMNOS VALUES (138,'Pablo','Perez',550,700,'ADMN');
INSERT INTO ALUMNOS VALUES (160,'Silvana','Gomez',600,600,'ADMN');
INSERT INTO ALUMNOS VALUES (179,'Natalia','Lopez',500,550,'BOGA');
INSERT INTO ALUMNOS VALUES (194,'Pamela','Gil',550,700,'BOGA');
INSERT INTO ALUMNOS VALUES (207,'Juan Pablo','Santos',500,600,'SIST');
INSERT INTO ALUMNOS (leg, nom) VALUES (400,'Pablo');
INSERT INTO ALUMNOS (leg) VALUES (51);
COMMIT;	
--
--
--
BEGIN TRANSACTION;
INSERT INTO MATERIAS VALUES (1000,'??');
INSERT INTO MATERIAS VALUES (1001,'BD I');
INSERT INTO MATERIAS VALUES (1002,'BD II');
INSERT INTO MATERIAS VALUES (1003,'LEGALES');
INSERT INTO MATERIAS VALUES (1004,'MAE');
INSERT INTO MATERIAS VALUES (1005,'ADES');
--
-- 'Materia mal asignada'
---
INSERT INTO MATERIAS (mat) VALUES (5000);
COMMIT;	
--
BEGIN TRANSACTION;
INSERT INTO FINALES VALUES ('2008/12/10',1001,69,8);
INSERT INTO FINALES VALUES ('2008/12/13',1002,69,7);
INSERT INTO FINALES VALUES ('2008/12/15',1003,69,5);
INSERT INTO FINALES VALUES ('2009/03/21',1004,69,6);
INSERT INTO FINALES VALUES ('2008/12/10',1005,69,6);

INSERT INTO FINALES VALUES ('2008/12/10',1001,109,6);
INSERT INTO FINALES VALUES ('2008/12/13',1002,109,2);
INSERT INTO FINALES VALUES ('2008/12/15',1003,109,5);
INSERT INTO FINALES VALUES ('2009/03/21',1004,109,6);

INSERT INTO FINALES VALUES ('2008/12/10',1001,138,4);
INSERT INTO FINALES VALUES ('2008/03/22',1002,138,2);
INSERT INTO FINALES VALUES ('2008/06/11',1002,138,2);
INSERT INTO FINALES VALUES ('2008/12/13',1002,138,2);
INSERT INTO FINALES VALUES ('2009/03/21',1002,138,6);
INSERT INTO FINALES VALUES ('2008/12/15',1003,138,4);
INSERT INTO FINALES VALUES ('2009/03/21',1000,138,5);

INSERT INTO FINALES VALUES ('2008/12/10',1001,160,8);
INSERT INTO FINALES VALUES ('2008/12/13',1002,160,7);
INSERT INTO FINALES VALUES ('2008/12/15',1003,160,10);
INSERT INTO FINALES VALUES ('2009/03/21',1004,160,6);

INSERT INTO FINALES VALUES ('2008/12/10',1001,179,4);
INSERT INTO FINALES VALUES ('2009/03/21',1002,179,6);
INSERT INTO FINALES VALUES ('2008/12/13',1003,179,2);
INSERT INTO FINALES VALUES ('2009/02/11',1003,179,4);

INSERT INTO FINALES VALUES ('2008/12/10',1001,207,3);
INSERT INTO FINALES VALUES ('2008/12/13',1003,207,2);
INSERT INTO FINALES VALUES ('2009/02/11',1003,207,2);
INSERT INTO FINALES VALUES ('2009/05/11',1003,207,2);
INSERT INTO FINALES VALUES ('2009/03/21',1003,207,6);

INSERT INTO FINALES VALUES ('2008/12/13',1002,51,2);
INSERT INTO FINALES VALUES ('2008/12/13',1003,51,2);
INSERT INTO FINALES VALUES ('2009/03/21',1004,51,7);
COMMIT;	
----------------------------------------------------------------------------
--
-- Tablas adicionales
--
--
-- Crear las tablas Profesores, Cursos e Inscripciones
--
Create table Profesores (prof int, nya varchar(30));
Insert into Profesores Values (   1, 'Juan Garcia');
Insert into Profesores Values (   2, 'Jose Perez');
--
Create table Cursos(mat int, anio int, prof int);
Insert into Cursos Values (1001, 2008, 1);
Insert into Cursos Values (1001, 2009, 3);
Insert into Cursos Values (1002, 2008, 1);
Insert into Cursos Values (1002, 2009, 1);
Insert into Cursos Values (1003, 2008, 2);
Insert into Cursos Values (1003, 2009, 1);
Insert into Cursos Values (1009, 2008, 2);
--
Create table Inscripciones(mat int, anio int, leg int);
Insert into Inscripciones Values (1001, 2008,  69);
Insert into Inscripciones Values (1001, 2008, 109);
Insert into Inscripciones Values (1001, 2008, 138);
Insert into Inscripciones Values (1001, 2009, 160);
Insert into Inscripciones Values (1001, 2009, 179);
Insert into Inscripciones Values (1001, 2009, 400);
Insert into Inscripciones Values (1001, 2009, 111);
Insert into Inscripciones Values (1002, 2008,  69);
Insert into Inscripciones Values (1002, 2008, 160);
Insert into Inscripciones Values (1008, 2008,  69);
Insert into Inscripciones Values (1002, 2009, 138);
--
------------------Fin script ----------------------------------------------

