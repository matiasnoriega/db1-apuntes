	
DROP TABLE IF EXISTS public.padron;

CREATE TABLE public.padron
(
    cuit character(11) COLLATE pg_catalog."default" NOT NULL,
    razon_social character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT PK_padron PRIMARY KEY (cuit)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.padron
    OWNER to postgres;

-- Table: public.pagos_de_contribuyentes

DROP TABLE IF EXISTS public.pagos_de_contribuyentes;

CREATE TABLE public.pagos_de_contribuyentes
(
    cuit character(11) COLLATE pg_catalog."default" NOT NULL DEFAULT '00000000000',
    anio integer,
    cuota integer,
    rubro character varying COLLATE pg_catalog."default",
    desc_rubro text COLLATE pg_catalog."default",
    importe double precision,
    CONSTRAINT PK_pago_de_contribuyentes PRIMARY KEY (cuit, anio, cuota), 
	CONSTRAINT FK_pagos_de_contribuyentes_cuit FOREIGN KEY (cuit) REFERENCES padron ON DELETE SET DEFAULT
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.pagos_de_contribuyentes
    OWNER to postgres;
