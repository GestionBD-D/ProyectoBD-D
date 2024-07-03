CREATE TABLE `categoria_plato` (
  `ID_CATEGORIA_PLATO` int(11) NOT NULL,
  `NOMBRE_CATEGORIA` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_CATEGORIA_PLATO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO categoria_plato VALUES (1, 'Entrantes');
INSERT INTO categoria_plato VALUES (2, 'Plato Principal');
INSERT INTO categoria_plato VALUES (3, 'Postres');

CREATE TABLE `cliente` (
  `ID_CLIENTE` int(11) NOT NULL,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `APELLIDO` varchar(50) DEFAULT NULL,
  `DIRECCION` varchar(100) DEFAULT NULL,
  `TELEFONO` int(11) DEFAULT NULL,
  `CORREO` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO cliente VALUES (1, 'Juan', 'Pérez', 'Calle Falsa 123', 5551234, 'juan.perez@example.com');
INSERT INTO cliente VALUES (2, 'Ana', 'Gómez', 'Avenida Siempreviva 456', 5555678, 'ana.gomez@example.com');
INSERT INTO cliente VALUES (3, 'Carlos', 'López', 'Boulevard de los Sueños 789', 5559012, 'carlos.lopez@example.com');

CREATE TABLE `cliente_queja` (
  `CLIENTE_ID_CLIENTE` int(11) DEFAULT NULL,
  `QUEJA_ID_QUEJA` int(11) DEFAULT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  KEY `CLIENTE_ID_CLIENTE` (`CLIENTE_ID_CLIENTE`),
  KEY `QUEJA_ID_QUEJA` (`QUEJA_ID_QUEJA`),
  CONSTRAINT `cliente_queja_ibfk_1` FOREIGN KEY (`CLIENTE_ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`),
  CONSTRAINT `cliente_queja_ibfk_2` FOREIGN KEY (`QUEJA_ID_QUEJA`) REFERENCES `queja` (`ID_QUEJA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO cliente_queja VALUES (1, 1, 'El servicio fue lento.');
INSERT INTO cliente_queja VALUES (2, 2, 'La comida llegó fría.');
INSERT INTO cliente_queja VALUES (3, 3, 'No había mesa disponible.');

CREATE TABLE `compra` (
  `ID_COMPRA` int(11) NOT NULL,
  `FECHA_COMPRA` date DEFAULT NULL,
  `MONTO_TOTAL` int(11) DEFAULT NULL,
  `DETALLE_COMPRA` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_COMPRA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO compra VALUES (1, datetime.date(2024, 5, 20), 100, 'Compra de ingredientes para ensalada');
INSERT INTO compra VALUES (2, datetime.date(2024, 5, 21), 200, 'Compra de ingredientes para pasta');
INSERT INTO compra VALUES (3, datetime.date(2024, 5, 22), 150, 'Compra de ingredientes para postres');

CREATE TABLE `detalle_factura` (
  `ID_DETALLE_FACTURA` int(11) NOT NULL,
  `FACTURA_ID_FACTURA` int(11) DEFAULT NULL,
  `CANTIDAD_PRODUCTO` int(11) DEFAULT NULL,
  `PRECIO_UNITARIO` int(11) DEFAULT NULL,
  `TOTAL` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_DETALLE_FACTURA`),
  KEY `FACTURA_ID_FACTURA` (`FACTURA_ID_FACTURA`),
  CONSTRAINT `detalle_factura_ibfk_1` FOREIGN KEY (`FACTURA_ID_FACTURA`) REFERENCES `factura` (`ID_FACTURA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO detalle_factura VALUES (1, 1, 2, 25, 50);
INSERT INTO detalle_factura VALUES (2, 2, 5, 15, 75);
INSERT INTO detalle_factura VALUES (3, 3, 10, 10, 100);

CREATE TABLE `empleado` (
  `ID_EMPLEADO` int(11) NOT NULL,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `CARGO` varchar(50) DEFAULT NULL,
  `TELEFONO` int(11) DEFAULT NULL,
  `DIRECCION` varchar(100) DEFAULT NULL,
  `CORREO` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_EMPLEADO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO empleado VALUES (1, 'María', 'Mesera', 5554321, 'Calle Verdadera 321', 'maria@example.com');
INSERT INTO empleado VALUES (2, 'Luis', 'Cocinero', 5558765, 'Avenida Real 654', 'luis@example.com');
INSERT INTO empleado VALUES (3, 'Pedro', 'Administrador', 5553456, 'Calle Principal 789', 'pedro@example.com');

CREATE TABLE `factura` (
  `ID_FACTURA` int(11) NOT NULL,
  `ORDEN_ID_ORDEN` int(11) DEFAULT NULL,
  `FECHA_FACTURA` date DEFAULT NULL,
  `ESTADO_PAGO` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID_FACTURA`),
  KEY `ORDEN_ID_ORDEN` (`ORDEN_ID_ORDEN`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`ORDEN_ID_ORDEN`) REFERENCES `orden` (`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO factura VALUES (1, 1, datetime.date(2024, 5, 21), 'Pendiente');
INSERT INTO factura VALUES (2, 2, datetime.date(2024, 5, 22), 'Pagado');
INSERT INTO factura VALUES (3, 3, datetime.date(2024, 5, 23), 'Pendiente');

CREATE TABLE `ingredientes` (
  `ID_INGREDIENTES` int(11) NOT NULL,
  `COMPRA_ID_COMPRA` int(11) DEFAULT NULL,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `TIPO` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_INGREDIENTES`),
  KEY `COMPRA_ID_COMPRA` (`COMPRA_ID_COMPRA`),
  CONSTRAINT `ingredientes_ibfk_1` FOREIGN KEY (`COMPRA_ID_COMPRA`) REFERENCES `compra` (`ID_COMPRA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO ingredientes VALUES (1, 1, 'Lechuga', 'Verdura');
INSERT INTO ingredientes VALUES (2, 2, 'Pasta', 'Grano');
INSERT INTO ingredientes VALUES (3, 3, 'Mascarpone', 'Lácteo');

CREATE TABLE `mesa` (
  `ID_MESA` int(11) NOT NULL,
  `EMPLEADO_ID_EMPLEADO` int(11) DEFAULT NULL,
  `CAPACIDAD` int(11) DEFAULT NULL,
  `DISPONIBILIDAD` int(11) DEFAULT NULL,
  `RESERVABLE` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`ID_MESA`),
  KEY `EMPLEADO_ID_EMPLEADO` (`EMPLEADO_ID_EMPLEADO`),
  CONSTRAINT `mesa_ibfk_1` FOREIGN KEY (`EMPLEADO_ID_EMPLEADO`) REFERENCES `empleado` (`ID_EMPLEADO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO mesa VALUES (1, 1, 4, 1, 'SI');
INSERT INTO mesa VALUES (2, 2, 2, 1, 'NO');
INSERT INTO mesa VALUES (3, 3, 6, 0, 'SI');

CREATE TABLE `orden` (
  `ID_ORDEN` int(11) NOT NULL,
  `EMPLEADO_ID_EMPLEADO` int(11) DEFAULT NULL,
  `MESA_ID_MESA` int(11) DEFAULT NULL,
  `CLIENTE_ID_CLIENTE` int(11) DEFAULT NULL,
  `ESTADO_ORDEN` int(11) DEFAULT NULL,
  `FECHA_ORDEN` date DEFAULT NULL,
  `TOTAL_PAGAR` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ORDEN`),
  KEY `EMPLEADO_ID_EMPLEADO` (`EMPLEADO_ID_EMPLEADO`),
  KEY `MESA_ID_MESA` (`MESA_ID_MESA`),
  KEY `CLIENTE_ID_CLIENTE` (`CLIENTE_ID_CLIENTE`),
  CONSTRAINT `orden_ibfk_1` FOREIGN KEY (`EMPLEADO_ID_EMPLEADO`) REFERENCES `empleado` (`ID_EMPLEADO`),
  CONSTRAINT `orden_ibfk_2` FOREIGN KEY (`MESA_ID_MESA`) REFERENCES `mesa` (`ID_MESA`),
  CONSTRAINT `orden_ibfk_3` FOREIGN KEY (`CLIENTE_ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO orden VALUES (1, 1, 1, 1, 1, datetime.date(2024, 5, 21), 50);
INSERT INTO orden VALUES (2, 2, 2, 2, 1, datetime.date(2024, 5, 22), 75);
INSERT INTO orden VALUES (3, 3, 3, 3, 1, datetime.date(2024, 5, 23), 100);

CREATE TABLE `pago` (
  `ID_PAGO` int(11) NOT NULL,
  `CLIENTE_ID_CLIENTE` int(11) DEFAULT NULL,
  `METODO_PAGO` varchar(50) DEFAULT NULL,
  `FECHA_PAGO` date DEFAULT NULL,
  PRIMARY KEY (`ID_PAGO`),
  KEY `CLIENTE_ID_CLIENTE` (`CLIENTE_ID_CLIENTE`),
  CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`CLIENTE_ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO pago VALUES (1, 1, 'Tarjeta de Crédito', datetime.date(2024, 5, 20));
INSERT INTO pago VALUES (2, 2, 'Efectivo', datetime.date(2024, 5, 21));
INSERT INTO pago VALUES (3, 3, 'PayPal', datetime.date(2024, 5, 22));

CREATE TABLE `plato` (
  `ID_PLATO` int(11) NOT NULL,
  `CATEGORIA_ID_CATEGORIA_PLATO` int(11) DEFAULT NULL,
  `NOMBRE_PLATO` varchar(100) DEFAULT NULL,
  `DESCRIPCION` varchar(250) DEFAULT NULL,
  `PRECIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_PLATO`),
  KEY `CATEGORIA_ID_CATEGORIA_PLATO` (`CATEGORIA_ID_CATEGORIA_PLATO`),
  CONSTRAINT `plato_ibfk_1` FOREIGN KEY (`CATEGORIA_ID_CATEGORIA_PLATO`) REFERENCES `categoria_plato` (`ID_CATEGORIA_PLATO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO plato VALUES (1, 1, 'Ensalada César', 'Ensalada con aderezo César', 10);
INSERT INTO plato VALUES (2, 2, 'Pasta Carbonara', 'Pasta con salsa Carbonara', 15);
INSERT INTO plato VALUES (3, 3, 'Tiramisú', 'Postre italiano', 7);

CREATE TABLE `plato_ingredientes` (
  `PLATO_ID_PLATO` int(11) DEFAULT NULL,
  `INGREDIENTES_ID_INGREDIENTES` int(11) DEFAULT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  KEY `PLATO_ID_PLATO` (`PLATO_ID_PLATO`),
  KEY `INGREDIENTES_ID_INGREDIENTES` (`INGREDIENTES_ID_INGREDIENTES`),
  CONSTRAINT `plato_ingredientes_ibfk_1` FOREIGN KEY (`PLATO_ID_PLATO`) REFERENCES `plato` (`ID_PLATO`),
  CONSTRAINT `plato_ingredientes_ibfk_2` FOREIGN KEY (`INGREDIENTES_ID_INGREDIENTES`) REFERENCES `ingredientes` (`ID_INGREDIENTES`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO plato_ingredientes VALUES (1, 1, 1);
INSERT INTO plato_ingredientes VALUES (2, 2, 2);
INSERT INTO plato_ingredientes VALUES (3, 3, 1);

CREATE TABLE `plato_orden` (
  `PLATO_ID_PLATO` int(11) DEFAULT NULL,
  `ORDEN_ID_ORDEN` int(11) DEFAULT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  KEY `PLATO_ID_PLATO` (`PLATO_ID_PLATO`),
  KEY `ORDEN_ID_ORDEN` (`ORDEN_ID_ORDEN`),
  CONSTRAINT `plato_orden_ibfk_1` FOREIGN KEY (`PLATO_ID_PLATO`) REFERENCES `plato` (`ID_PLATO`),
  CONSTRAINT `plato_orden_ibfk_2` FOREIGN KEY (`ORDEN_ID_ORDEN`) REFERENCES `orden` (`ID_ORDEN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO plato_orden VALUES (1, 1, 2);
INSERT INTO plato_orden VALUES (2, 2, 3);
INSERT INTO plato_orden VALUES (3, 3, 1);

CREATE TABLE `proveedor` (
  `ID_PROVEEDOR` int(11) NOT NULL,
  `COMPRA_ID_COMPRA` int(11) DEFAULT NULL,
  `NOMBRE` varchar(50) DEFAULT NULL,
  `TELEFONO` int(11) DEFAULT NULL,
  `DIRECCION` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_PROVEEDOR`),
  KEY `COMPRA_ID_COMPRA` (`COMPRA_ID_COMPRA`),
  CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`COMPRA_ID_COMPRA`) REFERENCES `compra` (`ID_COMPRA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO proveedor VALUES (1, 1, 'Proveedor S.A.', 5556789, 'Avenida Siempreviva 456');
INSERT INTO proveedor VALUES (2, 2, 'Distribuidora ABC', 5551234, 'Calle Falsa 123');
INSERT INTO proveedor VALUES (3, 3, 'Suministros XYZ', 5555678, 'Boulevard de los Sueños 789');

CREATE TABLE `queja` (
  `ID_QUEJA` int(11) NOT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`ID_QUEJA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO queja VALUES (1, datetime.date(2024, 5, 20));
INSERT INTO queja VALUES (2, datetime.date(2024, 5, 21));
INSERT INTO queja VALUES (3, datetime.date(2024, 5, 22));

CREATE TABLE `reservacion` (
  `ID_RESERVACION` int(11) NOT NULL,
  `MESA_ID_MESA` int(11) DEFAULT NULL,
  `CLIENTE_ID_CLIENTE` int(11) DEFAULT NULL,
  `COMENSALES` int(11) DEFAULT NULL,
  `FECHA_RESERVACION` date DEFAULT NULL,
  PRIMARY KEY (`ID_RESERVACION`),
  KEY `CLIENTE_ID_CLIENTE` (`CLIENTE_ID_CLIENTE`),
  KEY `MESA_ID_MESA` (`MESA_ID_MESA`),
  CONSTRAINT `reservacion_ibfk_1` FOREIGN KEY (`CLIENTE_ID_CLIENTE`) REFERENCES `cliente` (`ID_CLIENTE`),
  CONSTRAINT `reservacion_ibfk_2` FOREIGN KEY (`MESA_ID_MESA`) REFERENCES `mesa` (`ID_MESA`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO reservacion VALUES (1, 1, 1, 4, datetime.date(2024, 5, 21));
INSERT INTO reservacion VALUES (2, 2, 2, 2, datetime.date(2024, 5, 22));
INSERT INTO reservacion VALUES (3, 3, 3, 6, datetime.date(2024, 5, 23));

