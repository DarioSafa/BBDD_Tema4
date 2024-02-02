
-- 1. De la tabla DatosPersonales, el campo tipo puede tomar los valores N o D.
ALTER TABLE DATOSPERSONALES ADD CONSTRAINT CK_TIPO CHECK (TIPO IN('N','D'));


-- 2. De la tabla Departamento, el campo numProf estará en el rango 1-30 y el campo Descripcion no se puede repetir.
ALTER TABLE DEPARTAMENTO ADD CONSTRAINT CK_NUMPROF CHECK(NUMPROF BETWEEN(1 AND 30));
ALTER TABLE DEPARTAMENTO MODIFY NUMPROF UNIQUE;

-- 3. De la tabla Doctorando, la fecha de comienzo no puede ser menor que 1/1/2000 ni mayor que la fecha actual en la que se da de alta dicha información.
ALTER TABLE DOCTORANDO ADD CONSTRAINT CK_FECHA CHECK (FECHA BETWEEN ('1-1-2000' AND SYSDATE));

-- 4. De la tabla Doctor, el titulo no se puede repetir, debe tener como mínimo 10 caracteres, y la calificación es un valor natural entre 0 y 10.

ALTER TABLE DOCTOR MODIFY TITULO UNIQUE;
ALTER TABLE DOCTOR ADD CONSTRAINT CK_TITULO CHECK (LENGTH(TITULO) >= 10);
ALTER TABLE DOCTOR ADD CONSTRAINT CK_CALIFICACION CHECK (CALIFICACION BETWEEN (1 AND 10));

-- 5. De la tabla Curso, su duración está en el rango 10-500.

ALTER TABLE CURSO ADD CONSTRAINT CK_DURACION CHECK (DURACION BETWEEN (10 AND 500));
