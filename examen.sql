DROP DATABASE examen;
DROP TRIGGER consumo_u;
CREATE DATABASE examen;
USE examen;

CREATE TABLE cliente (
    rfc VARCHAR(13),
    nombre VARCHAR(50),
    consumo DOUBLE(7,2),
    PRIMARY KEY(rfc)
) ENGINE = INNODB;

INSERT INTO cliente VALUES("VECJ880326XXX", "pepe",0);
INSERT INTO cliente VALUES("PORD880326XXX", "pepe1",0);
INSERT INTO cliente VALUES("SERT880326XXX", "pepe2",0);
INSERT INTO cliente VALUES("CVBO880326XXX", "pepe3",0);
INSERT INTO cliente VALUES("EYRT880326XXX", "pepe4",0);

CREATE TABLE facturas (
    folio VARCHAR(50),
    rfc VARCHAR(13),
    monto DOUBLE(7,2),
    fechaExpedicion DATE,
    iva int,
    PRIMARY KEY (folio),
    FOREIGN KEY(rfc) REFERENCES cliente(rfc)
) ENGINE = INNODB;

CREATE TRIGGER consumo_u 
AFTER INSERT on facturas
FOR EACH ROW
UPDATE cliente SET consumo=consumo + 1 where rfc = new.rfc ;

INSERT INTO  facturas VALUES("prod1", "VECJ880326XXX", 270.50, "2021-04-01", 16);
INSERT INTO  facturas VALUES("prod12", "PORD880326XXX", 360.50, "2021-04-01", 16);
INSERT INTO  facturas VALUES("prod13", "SERT880326XXX", 570.50, "2021-01-01", 16);
INSERT INTO  facturas VALUES("prod21", "CVBO880326XXX", 654.50, "2022-01-01", 16);
INSERT INTO  facturas VALUES("prod22", "EYRT880326XXX", 960.50, "2022-09-01", 16);
INSERT INTO  facturas VALUES("prod123", "EYRT880326XXX", 960.50, "2022-09-01", 16);

SELECT SUM(monto) FROM facturas WHERE MONTH(fechaExpedicion) = 1 AND YEAR(fechaExpedicion) = '2022';

Select MAX( consumo ), rfc from cliente;

SELECT folio FROM facturas WHERE  YEAR(fechaExpedicion) = '2021';