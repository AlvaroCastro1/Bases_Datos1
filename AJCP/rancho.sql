CREATE DATABASE Rancho;
USE Rancho;

  create table Proveedores(
    idProveedor int auto_increment,
    razonSocial varchar (50),
    estado varchar (50),
    municipio varchar (50),
    colonia varchar (50),
    calle varchar (50),
    numExt int,
    numInt int,
    CP int,
    telefono varchar (12),
    correo varchar (50),
    primary key(idProveedor)
  )ENGINE = InnoDB;

  create table Insumos(
    idInsumo int auto_increment,
    nombre varchar (50),
    descripcion varchar(60),
    tipoInsumo varchar(50),
    primary key(idInsumo)
  )ENGINE=InnoDB;

  create table Compra(
    idCompra int auto_increment,
    fecha date,
    subtotal decimal(9,2),
    primary key(idCompra)
  )ENGINE=InnoDB;

  create table DetalleCompra(
    idDetalleCompras int,
    idCompra1 int,
    idProveedor1 int,
    idInsumo1 int,
    cantidadInsumo int,
    precioUnitario decimal(8,2),
    primary key(idDetalleCompras),
    foreign key(idCompra1) references Compra(idCompra),
    foreign key(idProveedor1) references Proveedores(idProveedor),
    foreign key(idInsumo1) references Insumos(idInsumo)
  )ENGINE=InnoDB;


  create table FacturaCompras(
    idFacturaCompra int,
    idDetalleCompras2 int,
    fechaEmision date,
    fechaVencimiento date,
    lugarEmision varchar(50),
    lugarVencimiento varchar(50),
    primary key(idFacturaCompra),
    foreign key(idDetalleCompras2) references DetalleCompra(idDetalleCompras)

  )ENGINE=InnoDB;

  create table Proceso(
    idProceso int auto_increment,
    tipoProceso varchar(50),
    descripcionProceso varchar(25),
    primary key(idProceso)
  )ENGINE=InnoDB;

  create table DetalleProceso(
    idDetalleProceso int,
    idProceso int,
    idInsumo1 int,
    cantidadInsumo int,
    primary key(idDetalleProceso),
    foreign key(idProceso) references Proceso(idProceso),
    FOREIGN KEY (idInsumo1)REFERENCES Insumos(idInsumo)
  )ENGINE=InnoDB;

  create table Lote(
    idLote int auto_increment,
    fechaEmpaquetado date,
    fechaCaducidad date,
    tipoAmbiente varchar(50),
    primary key(idLote)

  )ENGINE=InnoDB;

  CREATE TABLE Bodega(
    idBodega int auto_increment,
    cantidadB int,
    fechaActualizadaB date,
    PRIMARY KEY(idBodega)
  )ENGINE=InnoDB;

  create table Stock(
    idStock int auto_increment,
    idBodega1 int,
    cantidadStock int,
    actualizacionStock date,
    primary key(idStock),
    foreign key(idBodega1) references Bodega(idBodega)
  )ENGINE=InnoDB;

  create table Producto(
    idProducto int auto_increment,
    idStock1 int,
    nombreProducto varchar(50),
    precioProducto decimal(7,2),
    tipoUnidad varchar(50),
    cantidad decimal(6,2),
    descripcion varchar(60),
    primary key(idProducto),
    FOREIGN KEY(idStock1)REFERENCES Stock(idStock)
  )ENGINE=InnoDB;

  create table Produccion(
    idProduccion int,
    fechaInicio datetime,
    fechaFinal datetime,
    idLote int,
    idProducto int,
    primary key(idProduccion),
    foreign key(idLote) references Lote(idLote),
    foreign key(idProducto) references Producto(idProducto)

  )ENGINE=InnoDB;

  create table DetalleProduccion(
    idDetalleProduccion int auto_increment,
    idProduccion int,
    idProceso int,
    primary key(idDetalleProduccion),
    foreign key(idProduccion) references Produccion(idProduccion),
    foreign key(idProceso) references Proceso(idProceso)
  )ENGINE=InnoDB;

  CREATE TABLE Ofertas(
    idOferta int auto_increment,
    idLote1 int,
    precioOferta decimal(7,2),
    PRIMARY KEY(idOferta),
    FOREIGN KEY(idLote1)REFERENCES Lote(idLote)
  )ENGINE=InnoDB;

  CREATE TABLE Venta(
    idVenta int auto_increment,
    fechaVenta date,
    iva decimal(4,2),
    total decimal(10,2),
    PRIMARY KEY(idVenta)
  )ENGINE=InnoDB;

  CREATE TABLE DetalleVentas(
    idDetalleVentas int auto_increment,
    idVenta1 int,
    idProducto1 int,
    cantidadNR decimal(6,2),
    subtotal decimal(6,2),
    PRIMARY KEY(idDetalleVentas),
    FOREIGN KEY(idVenta1)REFERENCES Venta(idVenta),
    FOREIGN KEY(idProducto1)REFERENCES Producto(idProducto)
  )ENGINE=InnoDB;

  CREATE TABLE FacturaVenta(
    idFacturaVenta int auto_increment,
    idDetalleVentas1 int,
    fechaEmisionV date,
    lugarEmisionV varchar(200),
    PRIMARY KEY(idFacturaVenta),
    FOREIGN KEY(idDetalleVentas1)REFERENCES DetalleVentas(idDetalleVentas)
  )ENGINE=InnoDB;

  CREATE TABLE Jornada(
    idJornada int,
    turno varchar(20),
    horaEnt time,
    horaSal time,
    horaSalCom time,
    horaEntCom time,
    diasDescanso varchar(10),
    PRIMARY KEY(idJornada)
  )ENGINE=InnoDB;

  CREATE TABLE Cargo(
    idCargo int auto_increment,
    idJornada1 int,
    nombreCargo varchar(50),
    descripcion varchar(50),
    PRIMARY KEY(idCargo),
    FOREIGN KEY(idJornada1) REFERENCES Jornada(idJornada)
  )ENGINE=InnoDB;

  CREATE TABLE Departamento(
    idDepartamento int,
    nombreDepartanmento varchar(100),
    numEmpleados int,
    PRIMARY KEY(idDepartamento)
  )ENGINE=InnoDB;

  CREATE TABLE Contrato(
    idContrato int,
    idDepartamento1 int,
    idCargo1 int,
    sueldo decimal(6,2),
    inicioContrato date,
    finalContrato date,
    PRIMARY KEY(idContrato),
    FOREIGN KEY(idDepartamento1)REFERENCES Departamento(idDepartamento),
    FOREIGN KEY(idCargo1)REFERENCES Cargo(idCargo)
  )ENGINE=InnoDB;

  CREATE TABLE Empleado(
    idEmpleado int auto_increment,
    idContrato1 int,
    nombreEmpleado varchar(100),
    RFC varchar (13),
    NSS varchar (11),
    correoE varchar (50),
    telefono varchar (10),
    direccion varchar (200),
    noCuentaBancaria varchar(20),
    PRIMARY KEY(idEmpleado),
    FOREIGN KEY(idContrato1)REFERENCES Contrato(idContrato)
  )ENGINE=InnoDB;

  CREATE TABLE Periodo(
    idPeriodo int,
    inicioPeriodo date,
    finalPeriodo date,
    PRIMARY KEY(idPeriodo)
  )ENGINE=InnoDB;

  CREATE TABLE Asistencia(
    idAsistencia int auto_increment,
    idEmpleado1 int,
    falta boolean,
    asistencia boolean,
    horasExtra int,
    fechaA date,
    PRIMARY KEY(idAsistencia),
    FOREIGN KEY(idEmpleado1)REFERENCES Empleado(idEmpleado)
  )ENGINE=InnoDB;

  CREATE TABLE DetallePeriodo(
    idDetallePeriodo int,
    idAsistencia1 int,
    idPeriodo1 int,
    faltasT int,
    horasExtraT int,
    PRIMARY KEY(idDetallePeriodo),
    FOREIGN KEY(idAsistencia1)REFERENCES Asistencia(idAsistencia),
    FOREIGN KEY(idPeriodo1)REFERENCES Periodo(idPeriodo)
  )ENGINE=InnoDB;

  CREATE TABLE Pago(
    idPago int,
    idAsistencia1 int,
    extraP decimal(6,2),
    descuentoP decimal(6,2),
    tolaP decimal(6,2),
    PRIMARY KEY(idPago),
    FOREIGN KEY(idAsistencia1)REFERENCES Asistencia(idAsistencia)
  )ENGINE=InnoDB;

  CREATE TABLE Nomina(
    idNomina int,
    idPago1 int,
    numCunetaNomina int,
    banco varchar(50),
    montoDisponible decimal(6,2),
    fechaActualizacionN date,
    PRIMARY KEY(idNomina),
    FOREIGN KEY(idPago1)REFERENCES Pago(idPago)
  )ENGINE=InnoDB;

  CREATE TABLE Servicio(
    idServicio int auto_increment,
    nombreServidor varchar(50),
    especialidadS varchar(50),
    telefonoS varchar(10),
    correoS varchar(50),
    PRIMARY KEY(idServicio)
  )ENGINE=InnoDB;

  CREATE TABLE Visitas(
    idVisitas int,
    idServicio1 int,
    servicio varchar(50),
    fechaServicioI datetime,
    fechaServicioF datetime,
    pagoServicio decimal(6,2),
    PRIMARY KEY(idVisitas),
    FOREIGN KEY(idServicio1)REFERENCES Servicio(idServicio)
  )ENGINE=InnoDB;

  CREATE TABLE Honorarios(
    idHonorarios int auto_increment,
    idVisitas1 int,
    idPeriodo2 int,
    cantidadTP decimal(6,2),
    PRIMARY KEY(idHonorarios),
    FOREIGN KEY(idVisitas1)REFERENCES Visitas(idVisitas),
    FOREIGN KEY(idPeriodo2)REFERENCES Periodo(idPeriodo)
  )ENGINE=InnoDB;

  CREATE TABLE FacturaHonorarios(
    idFacturaH int auto_increment,
    idVisitas2 int,
    fechaEmisionH datetime,
    fechaVencimientoH datetime,
    lugarEmisionH varchar(100),
    lugarVencimientoH varchar(100),
    PRIMARY KEY(idFacturaH),
    FOREIGN KEY(idVisitas2)REFERENCES Visitas(idVisitas)
  )ENGINE=InnoDB;

  CREATE TABLE Ingresos(
    idIngresos int,
    idDetalleVentas2 int,
    idPeriodo3 int,
    PRIMARY KEY(idIngresos),
    FOREIGN KEY(idDetalleVentas2)REFERENCES DetalleVentas(idDetalleVentas),
    FOREIGN KEY(idPeriodo3)REFERENCES Periodo(idPeriodo)
  )ENGINE=InnoDB;

  CREATE TABLE ComprasTotales(
    idComprasTotales int auto_increment,
    idDetalleCompras1 int,
    idPeriodo4 int,
    PRIMARY KEY(idComprasTotales),
    FOREIGN KEY(idDetalleCompras1)REFERENCES DetalleCompra(idDetalleCompras),
    FOREIGN KEY(idPeriodo4)REFERENCES Periodo(idPeriodo)
  )ENGINE=InnoDB;

  CREATE TABLE Egresos(
    idEgresos int auto_increment,
    idHonorarios1 int,
    idNomina1 int,
    idComprasTotales1 int,
    PRIMARY KEY(idEgresos),
    FOREIGN KEY(idHonorarios1)REFERENCES Honorarios(idHonorarios),
    FOREIGN KEY(idNomina1)REFERENCES Nomina(idNomina),
    FOREIGN KEY(idComprasTotales1)REFERENCES ComprasTotales(idComprasTotales)
  )ENGINE=InnoDB;

INSERT INTO `insumos` (`idInsumo`, `nombre`, `descripcion`, `tipoInsumo`) VALUES ('1', 'alimento de animales', 
	'para vaca', 'alimento');

INSERT INTO `insumos` (`idInsumo`, `nombre`, `descripcion`, `tipoInsumo`) VALUES ('2', 'leche', 'natural', 'lacteos');

INSERT INTO `proveedores` (`idProveedor`, `razonSocial`, `estado`, `municipio`, `colonia`, `calle`, `numExt`, `numInt`, 
	`CP`, `telefono`, `correo`) VALUES ('1', 'prov1', 'de mexico', 'zumpango', 'roma', 'principal', '78', '209', '55647', 
	'55647382', 'correo@gmail.com');

INSERT INTO `compra` (`idCompra`, `fecha`, `subtotal`) VALUES ('1', '2022/09/10', '3000');

INSERT INTO `detallecompra` (`idDetalleCompras`, `idCompra1`, `idProveedor1`, `idInsumo1`, `cantidadInsumo`, `precioUnitario`) 
VALUES ('1', '1', '1', '1', '2', '100');

INSERT INTO `detallecompra` (`idDetalleCompras`, `idCompra1`, `idProveedor1`, `idInsumo1`, `cantidadInsumo`, `precioUnitario`) VALUES 
('2', '1', '1', '1', '1', '100');

INSERT INTO `facturacompras` (`idFacturaCompra`, `idDetalleCompras2`, `fechaEmision`, `fechaVencimiento`, `lugarEmision`, `lugarVencimiento`) VALUES
 ('1', '1', '2022-11-01', '2022-11-30', 'zumpango', 'mexico');

 INSERT INTO `proceso` (`idProceso`, `tipoProceso`, `descripcionProceso`) VALUES ('1', 'hacer queso ', 'usar leche ');

 INSERT INTO `detalleproceso` (`idDetalleProceso`, `idProceso`, `idInsumo1`, `cantidadInsumo`) VALUES ('1', '1', '2', '10');

 INSERT INTO `lote` (`idLote`, `fechaEmpaquetado`, `fechaCaducidad`, `tipoAmbiente`) VALUES ('1', '2022-11-02', '2022-12-14', 'Frio');

 INSERT INTO `bodega` (`idBodega`, `cantidadB`, `fechaActualizadaB`) VALUES ('1', '8', '2022-11-09');

 INSERT INTO `stock` (`idStock`, `idBodega1`, `cantidadStock`, `actualizacionStock`) VALUES ('1', '1', '10', '2022-11-24');

 INSERT INTO `producto` (`idProducto`, `idStock1`, `nombreProducto`, `precioProducto`, `tipoUnidad`, `cantidad`, `descripcion`) VALUES
  ('1', '1', 'Queso canasto', '200', 'kilos', '2', 'Hecho con leche de vacas felices');

 INSERT INTO `produccion` (`idProduccion`, `fechaInicio`, `fechaFinal`, `idLote`, `idProducto`) VALUES ('1', '2022-10-31 22:12:34', 
  	'2022-11-02 22:12:34', '1', '1');

INSERT INTO `detalleproduccion` (`idDetalleProduccion`, `idProduccion`, `idProceso`) VALUES ('1', '1', '1');

INSERT INTO `ofertas` (`idOferta`, `idLote1`, `precioOferta`) VALUES ('1', '1', '150');

INSERT INTO `venta` (`idVenta`, `fechaVenta`, `iva`, `total`) VALUES ('1', '2022-12-01', '32', '168');

INSERT INTO `detalleventas` (`idDetalleVentas`, `idVenta1`, `idProducto1`, `cantidadNR`, `subtotal`) VALUES ('1', '1', '1', '18.9', '200');

INSERT INTO `facturaventa` (`idFacturaVenta`, `idDetalleVentas1`, `fechaEmisionV`, `lugarEmisionV`) VALUES ('1', '1', '2022-11-24', 
	'Zumpango, estado de mexico');

INSERT INTO `jornada` (`idJornada`, `turno`, `horaEnt`, `horaSal`, `horaSalCom`, `horaEntCom`, `diasDescanso`) VALUES ('1',
 'matutino', '06:30:00', '1:30:00', '10:00:00', '11:00:00', 'sabado');

INSERT INTO `cargo` (`idCargo`, `idJornada1`, `nombreCargo`, `descripcion`) VALUES ('1', '1', 'Supervisor', 'Asegurarse que los
 demas hagan bien su trabajo');

INSERT INTO `departamento` (`idDepartamento`, `nombreDepartanmento`, `numEmpleados`) VALUES ('1', 'Produccion', '40');

INSERT INTO `contrato` (`idContrato`, `idDepartamento1`, `idCargo1`, `sueldo`, `inicioContrato`, `finalContrato`) VALUES ('1', '1', 
	'1', '5000', '2022-08-02', '2023-01-02');
INSERT INTO `empleado` (`idEmpleado`, `idContrato1`, `nombreEmpleado`, `RFC`, `NSS`, `correoE`, `telefono`, `direccion`, 
	`noCuentaBancaria`) VALUES ('1', '1', 'Adrian Silva Lopez', 'AFDR3728', '62718197', 'adrian@gmail.com', '55674892', 'Zumpango, 
	estado de mexico. Barrio de Santiago calle Manzanillo ', '1234567');

INSERT INTO `periodo` (`idPeriodo`, `inicioPeriodo`, `finalPeriodo`) VALUES ('1', '2022-11-01', '2022-11-15');

INSERT INTO `asistencia` (`idAsistencia`, `idEmpleado1`, `falta`, `asistencia`, `horasExtra`, `fechaA`) VALUES ('1', '1', '0', '1', 
	'3', '2022-11-15');

INSERT INTO `detalleperiodo` (`idDetallePeriodo`, `idAsistencia1`, `idPeriodo1`, `faltasT`, `horasExtraT`) VALUES ('1', '1', '1',
 '0', '3');

INSERT INTO `pago` (`idPago`, `idAsistencia1`, `extraP`, `descuentoP`, `tolaP`) VALUES ('1', '1', '300', '0', '300');

INSERT INTO `nomina` (`idNomina`, `idPago1`, `numCunetaNomina`, `banco`, `montoDisponible`, `fechaActualizacionN`) VALUES ('1', 
	'1', '8888', 'bbva', '5000', '2022-11-15');

INSERT INTO `servicio` (`idServicio`, `nombreServidor`, `especialidadS`, `telefonoS`, `correoS`) VALUES ('1', 'no se', 'contador?', 
	'5567435', 'contador@gmail.com');

INSERT INTO `visitas` (`idVisitas`, `idServicio1`, `servicio`, `fechaServicioI`, `fechaServicioF`, `pagoServicio`) VALUES ('1',
 '1', 'contador???', '2022-11-01 22:34:07', '2022-11-03 22:34:07', '2000');

INSERT INTO `honorarios` (`idHonorarios`, `idVisitas1`, `idPeriodo2`, `cantidadTP`) VALUES ('2', '1', '1', '400.5');

INSERT INTO `facturahonorarios` (`idFacturaH`, `idVisitas2`, `fechaEmisionH`, `fechaVencimientoH`, `lugarEmisionH`,
 `lugarVencimientoH`) VALUES ('1', '1', '2022-11-08 22:37:07', '2022-12-01 22:37:07', 'zumpango', 'mexico');

INSERT INTO `ingresos` (`idIngresos`, `idDetalleVentas2`, `idPeriodo3`) VALUES ('1', '1', '1');

INSERT INTO `comprastotales` (`idComprasTotales`, `idDetalleCompras1`, `idPeriodo4`) VALUES ('1', '2', '1');

INSERT INTO `egresos` (`idEgresos`, `idHonorarios1`, `idNomina1`, `idComprasTotales1`) VALUES ('1', '2', '1', '1');



