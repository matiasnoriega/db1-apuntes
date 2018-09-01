-- Table: public.padron

DROP TABLE IF EXISTS public.padron;

CREATE TABLE public.padron
(
    cuit character(11) COLLATE pg_catalog."default" NOT NULL,
    razon_social character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT padron_pkey PRIMARY KEY (cuit)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.padron
    OWNER to postgres;