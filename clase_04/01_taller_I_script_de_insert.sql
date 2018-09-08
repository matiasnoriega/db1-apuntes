INSERT INTO public.padron(
	cuit, razon_social)
	VALUES ('55533224124', 'Keynes SRL'),
	('55533224125', 'RUTAMAR'),
	('55533224128', 'Dogui'),
	('12451332221', 'EDENOR');
INSERT INTO public.pagos_de_contribuyentes(
	cuit, anio, cuota, rubro, desc_rubro, importe)
	VALUES ('55533224124', 2018, 3, 'arba', 'hipoteca', 3000.00),
	 ('55533224125', 2018, 1, 'luz', 'deuda', 3000.00),
	 ('55533224128', 2018, 1, 'arba', 'hipoteca', 3000.00),
	 ('12451332221', 2012, 3, 'casa', 'hipoteca', 3000.00),
	 ('55533224128', 2015, 12, 'auto', 'seguro', 3000.00);
	
