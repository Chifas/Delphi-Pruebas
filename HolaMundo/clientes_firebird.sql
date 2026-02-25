/* ============================================================
   Script de creacion de tabla CLIENTES en Firebird
   Base de datos: C:\Datos\Clientes.gdb
   Version: Firebird 2.5 - DIALECT 1
   Charset: WIN1252
   NOTA Dialect 1: el tipo DATE equivale a TIMESTAMP (incluye hora).
                   Usar TIMESTAMP y CURRENT_TIMESTAMP en lugar de
                   DATE y CURRENT_DATE.
   ============================================================ */

/* Crear la base de datos (ejecutar con isql o IBExpert):
   CREATE DATABASE 'C:\Datos\Clientes.gdb'
     USER 'SYSDBA' PASSWORD 'masterkey'
     DEFAULT CHARACTER SET WIN1252
     PAGE_SIZE 8192;
*/

/* Generador (secuencia) para el ID autoincrementable */
CREATE GENERATOR GEN_CLIENTES_ID;
SET GENERATOR GEN_CLIENTES_ID TO 0;

/* Tabla de clientes */
CREATE TABLE CLIENTES (
  ID_CLIENTE  INTEGER       NOT NULL,
  NOMBRE      VARCHAR(100)  NOT NULL,
  APELLIDO    VARCHAR(100)  NOT NULL,
  EMAIL       VARCHAR(150),
  TELEFONO    VARCHAR(30),
  DIRECCION   VARCHAR(200),
  FECHA_ALTA  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT PK_CLIENTES PRIMARY KEY (ID_CLIENTE)
);

/* Trigger para autoincrementar ID */
SET TERM ^ ;
CREATE TRIGGER CLIENTES_BI FOR CLIENTES
  ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.ID_CLIENTE IS NULL) THEN
    NEW.ID_CLIENTE = GEN_ID(GEN_CLIENTES_ID, 1);
END^
SET TERM ; ^

/* Indices utiles para busqueda */
CREATE INDEX IDX_CLIENTES_APELLIDO ON CLIENTES (APELLIDO);
CREATE INDEX IDX_CLIENTES_EMAIL    ON CLIENTES (EMAIL);

/* Datos de ejemplo */
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Juan',     'Garcia',     'juan.garcia@email.com',      '555-0101', 'Av. Corrientes 1234, CABA');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Maria',    'Lopez',      'maria.lopez@email.com',      '555-0202', 'Calle Florida 567, CABA');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Carlos',   'Martinez',   'carlos.martinez@gmail.com',  '555-0303', 'San Martin 890, Rosario');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Ana',      'Rodriguez',  'ana.rod@hotmail.com',        '555-0404', 'Belgrano 321, Cordoba');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Luis',     'Fernandez',  'luis.fer@gmail.com',         '555-0505', 'Rivadavia 777, Mendoza');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Sofia',    'Perez',      'sofia.perez@yahoo.com',      '555-0606', 'Mitre 100, Tucuman');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Diego',    'Gonzalez',   'diego.gonz@outlook.com',     '555-0707', 'Lavalle 2222, CABA');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Laura',    'Sanchez',    'laura.san@email.com',        '555-0808', '9 de Julio 450, Salta');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Marcos',   'Torres',     'marcos.torres@gmail.com',    '555-0909', 'San Juan 310, Mar del Plata');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Valeria',  'Romero',     'valeria.rom@hotmail.com',    '555-1010', 'Independencia 88, Neuquen');

COMMIT;
