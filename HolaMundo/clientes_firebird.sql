/* ============================================================
   Script de creacion de tabla CLIENTES en Firebird
   Base de datos: C:\Datos\Clientes.fdb
   Charset: UTF8
   ============================================================ */

/* Crear la base de datos (ejecutar con isql o IBExpert):
   CREATE DATABASE 'C:\Datos\Clientes.fdb'
     USER 'SYSDBA' PASSWORD 'masterkey'
     DEFAULT CHARACTER SET UTF8;
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
  FECHA_ALTA  DATE          DEFAULT CURRENT_DATE NOT NULL,
  CONSTRAINT PK_CLIENTES PRIMARY KEY (ID_CLIENTE)
);

/* Trigger para autoincrementar ID */
SET TERM ^ ;
CREATE TRIGGER CLIENTES_BI FOR CLIENTES
  ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  IF (NEW.ID_CLIENTE IS NULL) THEN
    NEW.ID_CLIENTE = NEXT VALUE FOR GEN_CLIENTES_ID;
END^
SET TERM ; ^

/* Indices utiles para busqueda */
CREATE INDEX IDX_CLIENTES_APELLIDO ON CLIENTES (APELLIDO);
CREATE INDEX IDX_CLIENTES_EMAIL    ON CLIENTES (EMAIL);

/* Datos de ejemplo */
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Juan',   'Garcia',    'juan.garcia@email.com',    '555-0101', 'Av. Corrientes 1234, CABA');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Maria',  'Lopez',     'maria.lopez@email.com',    '555-0202', 'Calle Florida 567, CABA');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Carlos', 'Martinez',  'carlos.martinez@gmail.com','555-0303', 'San Martin 890, Rosario');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Ana',    'Rodriguez', 'ana.rod@hotmail.com',      '555-0404', 'Belgrano 321, Cordoba');
INSERT INTO CLIENTES (NOMBRE, APELLIDO, EMAIL, TELEFONO, DIRECCION)
  VALUES ('Luis',   'Fernandez', '',                         '555-0505', 'Rivadavia 777, Mendoza');

COMMIT;
