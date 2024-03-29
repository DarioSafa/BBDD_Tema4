CREATE TABLE DIRECTOR(
DNI VARCHAR (9) NOT NULL,
NOMBRE VARCHAR (40) NOT NULL,
PRAPELLIDO VARCHAR (40) NOT NULL,
SGAPELLIDO VARCHAR(40) NULL,
DOMICILIO VARCHAR(50) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
EMAIL VARCHAR(40) NULL,
CONSTRAINT PK_DIRECTOR PRIMARY KEY (DNI)
);

CREATE TABLE SUPERMERCADO(
CODSUP NUMBER(3) NOT NULL,
DIRECCION VARCHAR(50) NOT NULL,
SUPERFICIE NUMBER (4) NOT NULL,
ESALQUILER VARCHAR(1) NOT NULL,                                             -- Se deberia hacer con un number(1) y un check in 0,1
FECHA DATE NOT NULL,
DNI VARCHAR (9) NOT NULL,
CONSTRAINT PK_SUPERMERCADO PRIMARY KEY (CODSUP),
CONSTRAINT FK_DNI_DIRECTOR FOREIGN KEY (DNI) REFERENCES DIRECTOR(DNI),
CONTRAINT CK_ESALQUILER CHECK (ESALQUILER IN ('S','N','s','n'))
);

CREATE TABLE VENDEDOR(
DNI VARCHAR (9) NOT NULL,
NOMBRE VARCHAR (40) NOT NULL,
PRAPELLIDO VARCHAR (40) NOT NULL,
SGAPELLIDO VARCHAR(40) NULL,
DOMICILIO VARCHAR(50) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
EMAIL VARCHAR(40) NULL,
CODSUP NUMBER(3) NOT NULL,
CONSTRAINT PK_VENDEDOR PRIMARY KEY (DNI),
CONSTRAINT FK_CODSUP_SUPERMERCADO FOREIGN KEY (CODSUP) REFERENCES SUPERMERCADO(CODSUP)
);

CREATE TABLE CLIENTE(
DNI VARCHAR (9) NOT NULL,
NOMBRE VARCHAR (40) NOT NULL,
PRAPELLIDO VARCHAR (40) NOT NULL,
SGAPELLIDO VARCHAR(40) NULL,
DOMICILIO VARCHAR(50) NOT NULL,
TELEFONO NUMBER(9) NOT NULL,
EMAIL VARCHAR(40) NULL,
CONSTRAINT PK_CLIENTE PRIMARY KEY (DNI)
);

CREATE TABLE VENTA(
CODVENTA NUMBER (4) NOT NULL,
FECHA DATE NOT NULL,
DNIVEND VARCHAR (9) NOT NULL,
DNICL VARCHAR (9) NOT NULL,
CONSTRAINT PK_VENTA PRIMARY KEY (CODVENTA),
CONSTRAINT FK_DNIVEND_VENDEDOR FOREIGN KEY(DNIVEND) REFERENCES VENDEDOR(DNI),
CONSTRAINT FK_DNICK_CLIENTE FOREIGN KEY(DNICL) REFERENCES CLIENTE(DNI)
);

CREATE TABLE PRODUCTO(
CODPROD NUMBER (4) NOT NULL,
DESCRIPCION VARCHAR (50) NOT NULL,
FAMILIA VARCHAR (20) NOT NULL,
GENERO VARCHAR (20) NOT NULL,
DESCUENTO NUMBER (2) NULL,
IVA NUMBER (2) NOT NULL,
CONSTRAINT PK_PRODUCTO PRIMARY KEY (CODPROD)
);

CREATE TABLE PRECIO(
CODPROD NUMBER(4) NOT NULL,
FECHA DATE NOT NULL,
PRECIO NUMBER (4) NOT NULL,
CONSTRAINT PK_PRECIO PRIMARY KEY (CODPROD,FECHA),
CONSTRAINT FK_CODPROD_PRODUCTO FOREIGN KEY (CODPROD) REFERENCES PRODUCTO(CODPROD)
);

CREATE TABLE LINEAVENTA(
CODVENTA NUMBER (4) NOT NULL,
NUMLINEA NUMBER (2) NOT NULL,
CODPROD NUMBER(4) NOT NULL,
FECHA DATE NOT NULL,
FECHA_PRECIO DATE NOT NULL,
CANTIDAD NUMBER (5),
CONSTRAINT PK_LINEAVENTA PRIMARY KEY (CODVENTA,NUMLINEA),
CONSTRAINT FK_CODVENTA_VENTA FOREIGN KEY (CODVENTA) REFERENCES VENTA(CODVENTA),
CONSTRAINT FK_CODPROD_PRECIO FOREIGN KEY (CODPROD, FECHA_PRECIO) REFERENCES PRECIO(CODPROD,FECHA)
);


CREATE TABLE DEVOLUCION(
CODVENTA NUMBER(4) NOT NULL,
NUMLINEA NUMBER(2) NOT NULL,
FECHA DATE NOT NULL,
ESTADO VARCHAR(20) NOT NULL,
TIPODEV VARCHAR(20) NOT NULL,
CONSTRAINT PK_DEVOLUCION PRIMARY KEY (CODVENTA,NUMLINEA,FECHA),
CONSTRAINT FK_CODVENTA_LINEAVENTA FOREIGN KEY (CODVENTA,NUMLINEA) REFERENCES LINEAVENTA(CODVENTA,NUMLINEA)
);
