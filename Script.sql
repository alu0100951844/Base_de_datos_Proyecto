
CREATE SCHEMA IF NOT EXISTS mydb;

-- CREANDO TIPOS DE DATOS

   -- POINT Lo usamos en el tipo de datos LINEA
   CREATE TYPE POINT AS (
     coordenada_x INT,
     coordenada_y INT);
     
   -- LINEA  Tipo de dato usado para el array de lineas en poligono
   CREATE TYPE LINEA AS (
     inicio POINT,
     fin POINT,
     longitud FLOAT);

-- -----------------------------------------------------
-- Table mydb.Jefe_Proyecto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Jefe_Proyecto (
  cod_JP INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  Direccion VARCHAR(45) NULL,
  Telefono INT(9) NULL,
  PRIMARY KEY (cod_JP);
  
  CREATE INDEX Nombre_UNIQUE (Nombre ASC));


-- -----------------------------------------------------
-- Table mydb.Proyecto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Proyecto (
  cod_P INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  cod_JP INT NOT NULL,
  PRIMARY KEY (cod_P),
  CONSTRAINT fk_Proyecto_Jefe_Proyecto1
    FOREIGN KEY (cod_JP)
    REFERENCES mydb.Jefe_Proyecto (cod_JP)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  CREATE INDEX fk_Proyecto_Jefe_Proyecto1_idx (cod_JP ASC);
  CREATE UNIQUE INDEX cod_JP_UNIQUE (cod_JP ASC);

-- -----------------------------------------------------
-- Table mydb.Planos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Planos (
  cod_Plano INT NOT NULL,
  F_entrega DATE NULL,
  Arquitectos VARCHAR(45) NULL,
  N_Figuras INT NULL,
  cod_P INT NOT NULL,
  PRIMARY KEY (cod_Plano, cod_P),
  CONSTRAINT fk_Planos_1
    FOREIGN KEY (cod_P)
    REFERENCES mydb.Proyecto (cod_P)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  CREATE INDEX fk_Planos_1_idx (cod_P ASC);

-- -----------------------------------------------------
-- Table mydb.Figura
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Figura (
  cod_Plano INT NOT NULL,
  cod_Figura INT NOT NULL,
  Nombre VARCHAR(45) NULL,
  Color VARCHAR(45) NULL,
  Area FLOAT NULL,
  Perimetro FLOAT NULL,
  PRIMARY KEY (cod_Plano, cod_Figura),
  CONSTRAINT fk_Figura_1
    FOREIGN KEY (cod_Plano)
    REFERENCES mydb.Planos (cod_Plano)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table mydb.Poligono
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Poligono (
  N_Lineas VARCHAR(45) NULL,
  cod_Figura INT NOT NULL,
  Lineas_figura LINEA[],
  PRIMARY KEY (cod_Figura),
  CONSTRAINT fk_Poligono_Figura1
    FOREIGN KEY (cod_Figura)
    REFERENCES mydb.Figura (cod_Figura)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  CREATE INDEX fk_Poligono_Figura1_idx (cod_Figura ASC);

-- ¡¡¡¡¡COMENTARIO IMPORTANTE!!!!!

-- Hemos decidido añadir en la tabla mydb.Poligono un array de LINEAS (LINEAS es un nuevo tipo de dato que hemos creado) en el que almacenar
-- la información de las líneas que constituyen cada figura. Por este motivo se ha decidido quitar la tabla "Linea" ya que el array cumple la misma función.

-- ¡¡¡¡¡COMENTARIO IMPORTANTE!!!!!




