-- TIPODP
CREATE TABLE TIPODP(
CODTIPO NUMBER (3) NOT NULL,
DESCRIPCION VARCHAR(50) NOT NULL,
CONSTRAINT PK_TIPODP PRIMARY KEY (CODTIPO)
);

-- DATOSPERSONALES
ALTER TABLE DATOSPERSONALES ADD CONSTRAINT FK_CODTIPO_DATOSPERSONALES FOREIGN KEY(TIPO) REFERENCES TIPODP(CODTIPO) ON DELETE CASCADE;
ALTER TABLE DATOSPERSONALES MODIFY TELEFONO NOT NULL;
ALTER TABLE DATOSPERSONALES MODIFY CORREO NOT NULL;


-- DIRECTOR
ALTER TABLE DIRECTOR ADD ANIOS NUMBER(3) NOT NULL;

-- COMERCIAL
ALTER TABLE COMERCIAL DROP COLUMN COMISION;

-- OFICINA
ALTER TABLE COMERCIAL ADD COMISION NUMBER(3) NOT NULL;

-- TURNO
CREATE TABLE TURNO(
CODTURNO NUMBER(3) NOT NULL,
DESCRIPCION VARCHAR(50) NOT NULL,
CONSTRAINT PK_TURNO PRIMARY KEY (CODTURNO)
);

-- VENDEDOR
ALTER TABLE VENDEDOR ADD CONSTRAINT FK_TURNO FOREIGN KEY(TURNO) REFERENCES TURNO(CODTURNO) ON DELETE CASCADE;

-- CLIENTE

-- VENTA

-- EDITORIAL

-- TEMATICA LIBRO
CREATE TABLE TEMATICALIBRO(
CODTEM NUMBER(3) NOT NULL,
DESCRIPCION VARCHAR(50) NOT NULL.
CONSTRAINT PK_TEMATICALIBRO PRIMARY KEY (CODTEM)
);

-- LIBRO
ALTER TABLE LIBRO RENAME PRECIO TO PRECIOACTUAL;
ALTER TABLE LIBRO RENAME TEMATICA TO CODTEM;
ALTER TABLE LIBRO ADD CONSTRAINT FK_CODTIPO_TEMATICA FOREIGN KEY(CODTEM) REFERENCES TEMATICALIBRO(CODTEM) ON DELETE CASCADE;

-- LINEAVENTA
