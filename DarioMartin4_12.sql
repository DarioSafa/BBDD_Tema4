-- I. Un curso se puede impartir en diferentes aulas.
ALTER TABLE AULA ADD CONSTRAINT FK_CURSO (CODCURSO) REFERENCES CURSO(CODCURSO);

-- II. Un doctorando puede recibir el mismo curso más de una vez.
-- SIGNIFICA QUE SE CREA UNA TABLA N:M DONDE LOS PRIMARYS DE DOCTORANDO, CURSO Y FECHA SERIAN PRINCIPALES

ALTER TABLE DOCTORANDO_CURSO MODIFY CONSTRAINT PK_DOCTORANDO_CURSO(CODCURSO,DNIDOCTORANDO,FECHA);


--III. Se quiere conocer el tipo de aula: aula de prácticas, aula audiovisual, aula grupos pequeños, aula normal y aula magna. Codifica dichos valores.
ALTER TABLE AULA ADD CONSTRAINT TIPO CHECK (IN ('Aula de prácticas','aula audiovisual','aula grupos pequeños','aula normal','aula magna'));

