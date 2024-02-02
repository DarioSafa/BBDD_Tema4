CREATE TABLE DIRECTOR(
    DNI VARCHAR(9) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30) NULL,
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30) NULL,
    CONSTRAINT PK_DIRECTOR PRIMARY KEY(DNI)
);

CREATE TABLE SUPERMERCADO(
    CODSUP NUMBER (2) NOT NULL,
    DIRECCION VARCHAR (30) NOT NULL,
    SUPERFICIE NUMBER (4) NOT NULL,
    ESALQUILER VARCHAR (1) NOT NULL,
    FECHA DATE NOT NULL,
    DNI VARCHAR (9) NOT NULL,
    CONSTRAINT PK_SUPERMERCADO PRIMARY KEY(CODSUP),
    CONSTRAINT FK_DNI FOREIGN KEY (DNI) REFERENCES DIRECTOR(DNI),
    CONSTRAINT CK_ESALQUILER CHECK (ESALQUILER IN ('s','S','n','N')),
    CONSTRAINT CK_SUPERFICIE CHECK (SUPERFICIE > 0)
);

CREATE TABLE VENDEDOR(
    DNI VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(30) NOT NULL,
    PRAPELLIDO VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30) NULL,
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30) NULL,
    CODSUP NUMBER (2) NOT NULL,
    CONSTRAINT PK_VENDEDOR PRIMARY KEY(DNI),
    CONSTRAINT FK_VENDEDOR FOREIGN KEY (CODSUP) REFERENCES SUPERMERCADO(CODSUP) ON DELETE CASCADE
);

CREATE TABLE CLIENTE(
    DNI VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(30) NOT NULL,
    SGAPELLIDO VARCHAR(30) NULL,
    DOMICILIO VARCHAR(30) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    EMAIL VARCHAR(30) NULL,
    CONSTRAINT PK_CLIENTE PRIMARY KEY(DNI)
);

CREATE TABLE VENTA(
    CODVENTA NUMBER(4) NOT NULL,
    FECHA DATE NOT NULL,
    DNIVEND VARCHAR(9) NOT NULL,
    DNICL VARCHAR(9) NOT NULL,
    CONSTRAINT PK_VENTA PRIMARY KEY (CODVENTA),
    CONSTRAINT FK_VENTA_VENDEDOR FOREIGN KEY (DNIVEND) REFERENCES VENDEDOR(DNI) ON DELETE CASCADE,
    CONSTRAINT FK_VENTA_CLIENTE FOREIGN KEY (DNICL) REFERENCES CLIENTE(DNI) ON DELETE CASCADE
);

CREATE TABLE PRODUCTO(
    CODPRODUCTO NUMBER(4) NOT NULL,
    DESCRIPCION VARCHAR(30) NOT NULL,
    FAMILIA VARCHAR(30) NOT NULL,
    GENERO VARCHAR(30) NOT NULL,
    DESCUENTO NUMBER(3) DEFAULT 0 NULL,
    IVA NUMBER(2) NOT NULL,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY (CODPRODUCTO),
    CONSTRAINT CK_DESCUENTO CHECK (DESCUENTO BETWEEN 0 AND 100),
    CONSTRAINT CK_IVA CHECK (IVA IN (4,10,21))
);

CREATE TABLE LINEAVENTA(
    CODVENTA NUMBER(4) NOT NULL,
    NUMLINEA NUMBER(3) NOT NULL,
    CANTIDAD NUMBER(3) NOT NULL,
    CONSTRAINT PK_LINEAVENTA PRIMARY KEY(CODVENTA,NUMLINEA),
    CONSTRAINT FK_CODVENTA FOREIGN KEY(CODVENTA) REFERENCES VENTA(CODVENTA),
    CONSTRAINT CK_CANTIDAD CHECK (CANTIDAD BETWEEN 1 AND 249)
);


CREATE TABLE DEVOLUCION(
    CODVENTA NUMBER(4) NOT NULL, 
    NUMLINEA NUMBER(3) NOT NULL,
    FECHA DATE NOT NULL,
    ESTADO VARCHAR(1) NOT NULL,
    TIPODEV VARCHAR(30) NOT NULL,
    CONSTRAINT CK_ESTADO CHECK (ESTADO IN ('B','M','F')),
    CONSTRAINT PK_DEVOLUCION PRIMARY KEY(FECHA,CODVENTA,NUMLINEA),
    CONSTRAINT FK_LINEAVENTA FOREIGN KEY(CODVENTA,NUMLINEA) REFERENCES LINEAVENTA(CODVENTA,NUMLINEA),
    CONSTRAINT CK_TIPODEV CHECK (TIPODEV BETWEEN 1  AND 5)
);
    

CREATE TABLE PRECIO(
    CODPROD NUMBER(4) NOT NULL,
    FECHA DATE NOT NULL,
    PRECIO NUMBER(6,2) NOT NULL,
    CONSTRAINT PK_PRECIO PRIMARY KEY(CODPROD),
    CONSTRAINT FK_PRECIO FOREIGN KEY(CODPROD) REFERENCES PRODUCTO(CODPRODUCTO),
    CONSTRAINT CK_PRECIO CHECK (PRECIO BETWEEN 0.01 AND 9999.99)
);