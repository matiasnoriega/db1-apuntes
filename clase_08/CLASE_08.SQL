SELECT a.* FROM alumnos a
    WHERE (SELECT count(*) FROM finales f 
		   			WHERE date_part('year', fec) = 2008 
		   				AND f.leg = a.leg) >= 4;