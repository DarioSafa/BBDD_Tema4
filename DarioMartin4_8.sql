CREATE TABLE PROFESOR(
DNI VARCHAR(9) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO1 VARCHAR(30) NOT NULL,
APELLIDO2 VARCHAR(30) NULL,
DIRECCION VARCHAR(50) NOT NULL,
CUENTA VARCHAR(20) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
CONSTRAINT PK_PROFESOR PRIMARY KEY (DNI)
);

CREATE TABLE CICLOFORM(
CODCICLO VARCHAR (3) NOT NULL,
NOMBRE VARCHAR (30) NOT NULL,
TIPO VARCHAR (10) NOT NULL,
CONSTRAINT PK_CICLOFORM PRIMARY KEY (CODCICLO)
);

CREATE TABLE ASIGNATURA(
CODASIG VARCHAR (3) NOT NULL,
NOMBRE VARCHAR (30) NOT NULL,
NUMHORAS NUMBER(3) NOT NULL,
DNI_PROFESOR VARCHAR (9) NOT NULL,
CODCICLO_CICLOFORM VARCHAR (3) NOT NULL,
CONSTRAINT PK_ASIGNATURA PRIMARY KEY (CODASIG),
CONSTRAINT FK_ASIGNATURA_DNI FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESOR(DNI),
CONSTRAINT FK_ASIGNATURA_CODCICLO FOREIGN KEY (CODCICLO_CICLOFORM) REFERENCES CICLOFORM(CODCICLO)
);

CREATE TABLE IDIOMA(
CODIDIOMA VARCHAR(2) NOT NULL,
DESCRIPCION VARCHAR(100) NOT NULL,
CONSTRAINT PK_IDIOMA PRIMARY KEY (CODIDIOMA)
);

CREATE TABLE ALUMNO(
DNI VARCHAR(9) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO1 VARCHAR(30) NOT NULL,
APELLIDO2 VARCHAR(30) NULL,
DIRECCION VARCHAR(50) NOT NULL,
EMAIL VARCHAR (40) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
CODIDIOMA_IDIOMA VARCHAR(2) NULL,
CONSTRAINT PK_ALUMNO PRIMARY KEY (DNI),
CONSTRAINT FK_ALUMNO_CODIDIOMA FOREIGN KEY (CODIDIOMA_IDIOMA) REFERENCES IDIOMA(CODIDIOMA)
);

CREATE TABLE MATRICULA(
DNI_ALUMNO VARCHAR(9) NOT NULL,
CODASIG_ASIGNATURA VARCHAR(3) NOT NULL,
CONSTRAINT PK_MATRICULA PRIMARY KEY (DNI_ALUMNO,CODASIG_ASIGNATURA),
CONSTRAINT FK_MATRICULA_DNI FOREIGN KEY (DNI_ALUMNO) REFERENCES ALUMNO(DNI),
CONSTRAINT FK_MATRICULA_CODASIG FOREIGN KEY (CODASIG_ASIGNATURA) REFERENCES ASIGNATURA(CODASIG)
);

CREATE TABLE IDIOMASPROF(
CODIDIOMA_IDIOMA VARCHAR(2) NOT NULL,
DNI_PROFESOR VARCHAR(9) NOT NULL,
CONSTRAINT PK_IDIOMASPROF PRIMARY KEY (DNI_PROFESOR,CODIDIOMA_IDIOMA),
CONSTRAINT FK_IDIOMASPROF_DNI FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESOR(DNI),
CONSTRAINT FK_IDIOMASPROF_CODIDIOMA FOREIGN KEY (CODIDIOMA_IDIOMA) REFERENCES IDIOMA(CODIDIOMA)
);

-- Se crea la nueva tabla supertipo
CREATE TABLE DATOSPERSONALES(
DNI VARCHAR(9) NOT NULL,
NOMBRE VARCHAR(30) NOT NULL,
APELLIDO1 VARCHAR(30) NOT NULL,
APELLIDO2 VARCHAR(30) NOT NULL,
DIRECCION VARCHAR(20) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
CONSTRAINT PK_DATOSPERSONALES PRIMARY KEY (DNI)
);

-- para borrar los datos de profesor que hemos creado en el supertipo
ALTER TABLE PROFESOR DROP (NOMBRE);
ALTER TABLE PROFESOR DROP (APELLIDO1);
ALTER TABLE PROFESOR DROP (APELLIDO2);
ALTER TABLE PROFESOR DROP (DIRECCION);
ALTER TABLE PROFESOR DROP (TELEFONO);

-- para borrar los datos de alumno que hemos creado en el supertipo
ALTER TABLE ALUMNO DROP (NOMBRE);
ALTER TABLE ALUMNO DROP (APELLIDO1);
ALTER TABLE ALUMNO DROP (APELLIDO2);
ALTER TABLE ALUMNO DROP (DIRECCION);
ALTER TABLE ALUMNO DROP (TELEFONO);

--Ahora vamos a crear las constraints para referenciar profesor y alumno a su supertipo
ALTER TABLE PROFESOR ADD CONSTRAINT FK_DNI_PROFESOR FOREIGN KEY(DNI) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE;
ALTER TABLE ALUMNO ADD CONSTRAINT FK_DNI_ALUMNO FOREIGN KEY(DNI) REFERENCES DATOSPERSONALES(DNI) ON DELETE CASCADE;

--Creamos el atributo discriminante tipo
ALTER TABLE DATOSPERSONALES ADD TIPO VARCHAR(8);
ALTER TABLE DATOSPERSONALES DROP CONSTRAINT CK_TIPO;    --Para poder hacer cambio de minus a mayus con la linea de abajo
ALTER TABLE DATOSPERSONALES ADD CONSTRAINT CK_TIPO CHECK(TIPO IN ('PROFESOR','ALUMNO'));

--ALTERACIONES PARA INSERTAR DATOS
ALTER TABLE CICLOFORM MODIFY CODCICLO VARCHAR(4);
ALTER TABLE CICLOFORM MODIFY TIPO VARCHAR(30);
ALTER TABLE PROFESOR MODIFY CUENTA VARCHAR(30);
ALTER TABLE DATOSPERSONALES MODIFY DIRECCION VARCHAR(50);
ALTER TABLE ASIGNATURA MODIFY CODCICLO_CICLOFORM VARCHAR(4);
ALTER TABLE ASIGNATURA DROP CONSTRAINT FK_ASIGNATURA_CODCICLO;
ALTER TABLE CICLOFORM DROP CONSTRAINT PK_CICLOFORM;
ALTER TABLE CICLOFORM DROP COLUMN CODCICLO;
ALTER TABLE CICLOFORM ADD CODCICLO NUMBER(4);
ALTER TABLE CICLOFORM ADD CONSTRAINT PK_CICLOFORM PRIMARY KEY (CODCICLO);
ALTER TABLE ASIGNATURA DROP COLUMN CODCICLO_CICLOFORM;
ALTER TABLE ASIGNATURA ADD CODCICLO_CICLOFORM NUMBER(4);
ALTER TABLE ASIGNATURA ADD CONSTRAINT FK_ASIGNATURA_CODCICLO FOREIGN KEY (CODCICLO_CICLOFORM) REFERENCES CICLOFORM(CODCICLO);

--INSERTAR DATOS PERSONALES
INSERT INTO DATOSPERSONALES(DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TELEFONO,TIPO) VALUES ('71654896M','MARTA','MARTIN','RODRIGUEZ','C/ Miravilla',983652148,'ALUMNO');
INSERT INTO DATOSPERSONALES(DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TELEFONO,TIPO) VALUES ('44103779F','JESUS','LOPEZ','ANTON','C/ Lopez Gomez',654987123,'PROFESOR');
INSERT INTO DATOSPERSONALES(DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TELEFONO,TIPO) VALUES ('11526987G','PEDRO','DIAZ','HERNANDEZ','C/ Transicion',698741236,'ALUMNO');
INSERT INTO DATOSPERSONALES(DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TELEFONO,TIPO) VALUES ('89621477A','LUIS','VILA','GOMEZ','C/ Cardenal Torquemada',654710236,'PROFESOR');
INSERT INTO DATOSPERSONALES(DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TELEFONO,TIPO) VALUES ('45986321N','ANDREA','RIVAS','ALONSO','C/ Salud',622254789,'ALUMNO');
INSERT INTO DATOSPERSONALES(DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TELEFONO,TIPO) VALUES ('71056984D','MIRIAM','ALONSO','BERODAS','Paseo Zorrilla',645897123,'ALUMNO');

--INSERTAR CICLOFORM
INSERT INTO CICLOFORM(CODCICLO,NOMBRE,TIPO) VALUES (1565,'DAM','GRADO SUPERIOR');
INSERT INTO CICLOFORM(CODCICLO,NOMBRE,TIPO) VALUES (2598,'SMR','GRADO MEDIO');
INSERT INTO CICLOFORM(CODCICLO,NOMBRE,TIPO) VALUES (1489,'ARI','GRADO SUPERIOR');

DELETE FROM CICLOFORM;

--INSERTAR PROFESOR
INSERT INTO PROFESOR(DNI,CUENTA) VALUES('44103779F','ES2002399348396092013170');
INSERT INTO PROFESOR(DNI,CUENTA) VALUES('89621477A','ES8501865417580989668301');

--INSERTAR ALUMNO
INSERT INTO ALUMNO(DNI,EMAIL) VALUES('71654896M','marta.mr@gmail.com');
INSERT INTO ALUMNO(DNI,EMAIL) VALUES('11526987G','pedro.dh@gmail.com');
INSERT INTO ALUMNO(DNI,EMAIL) VALUES('45986321N','andrea.ra@gmail.com');
INSERT INTO ALUMNO(DNI,EMAIL) VALUES('71056984D','miriam.ab@gmail.com');

--INSERTAR IDIOMA
INSERT INTO IDIOMA(CODIDIOMA,DESCRIPCION) VALUES('20','Ingles');
INSERT INTO IDIOMA(CODIDIOMA,DESCRIPCION) VALUES('30','Español');

--ASIGNATURAS
INSERT INTO ASIGNATURA(CODASIG,NOMBRE,NUMHORAS,DNI_PROFESOR,CODCICLO_CICLOFORM) VALUES('1','Empresa',128,'44103779F',1565);
INSERT INTO ASIGNATURA(CODASIG,NOMBRE,NUMHORAS,DNI_PROFESOR,CODCICLO_CICLOFORM) VALUES('2','Informática Industrial',269,'44103779F',1565);
INSERT INTO ASIGNATURA(CODASIG,NOMBRE,NUMHORAS,DNI_PROFESOR,CODCICLO_CICLOFORM) VALUES('3','Aplicaciones Web',200,'89621477A',2598);
INSERT INTO ASIGNATURA(CODASIG,NOMBRE,NUMHORAS,DNI_PROFESOR,CODCICLO_CICLOFORM) VALUES('4','Bases de datos',170,'89621477A',1489);
INSERT INTO ASIGNATURA(CODASIG,NOMBRE,NUMHORAS,DNI_PROFESOR,CODCICLO_CICLOFORM) VALUES('5','Programación',225,'89621477A',2598);

UPDATE ASIGNATURA SET CODCICLO_CICLOFORM=1565 WHERE CODASIG='1';
UPDATE ASIGNATURA SET CODCICLO_CICLOFORM=1565 WHERE CODASIG='2';
UPDATE ASIGNATURA SET CODCICLO_CICLOFORM=2598 WHERE CODASIG='3';
UPDATE ASIGNATURA SET CODCICLO_CICLOFORM=1489 WHERE CODASIG='4';
UPDATE ASIGNATURA SET CODCICLO_CICLOFORM=2598 WHERE CODASIG='5';


DELETE FROM ASIGNATURA;

--IDIOMASPROF
INSERT INTO IDIOMASPROF(CODIDIOMA_IDIOMA,DNI_PROFESOR) VALUES('30','44103779F');
INSERT INTO IDIOMASPROF(CODIDIOMA_IDIOMA,DNI_PROFESOR) VALUES('20','89621477A');
INSERT INTO IDIOMASPROF(CODIDIOMA_IDIOMA,DNI_PROFESOR) VALUES('30','89621477A');

--MATRICULA
INSERT INTO MATRICULA(DNI_ALUMNO,CODASIG_ASIGNATURA) VALUES('71654896M','1');
INSERT INTO MATRICULA(DNI_ALUMNO,CODASIG_ASIGNATURA) VALUES('11526987G','2');
INSERT INTO MATRICULA(DNI_ALUMNO,CODASIG_ASIGNATURA) VALUES('45986321N','3');
INSERT INTO MATRICULA(DNI_ALUMNO,CODASIG_ASIGNATURA) VALUES('71056984D','4');
INSERT INTO MATRICULA(DNI_ALUMNO,CODASIG_ASIGNATURA) VALUES('71654896M','5');
INSERT INTO MATRICULA(DNI_ALUMNO,CODASIG_ASIGNATURA) VALUES('11526987G','1');
