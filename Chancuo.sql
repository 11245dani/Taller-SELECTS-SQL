CREATE TABLE ubicaciones (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE
);

CREATE TABLE proveedores (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE,
    telefono VARCHAR(15) NULL,
    correo VARCHAR(100) NULL
);

CREATE TABLE tipos (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE
);
CREATE TABLE extintores (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    capacidad INT UNSIGNED,
    fechafabricacion DATE,
    estado VARCHAR(50),
    idubicacion INT UNSIGNED,
    idproveedor INT UNSIGNED,
    FOREIGN KEY (idubicacion) REFERENCES ubicaciones(id),
    FOREIGN KEY (idproveedor) REFERENCES proveedores(id)
);

CREATE TABLE inspecciones (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idextintor INT UNSIGNED,
    fecha DATE,
    proximainspeccion DATE,
    FOREIGN KEY (idextintor) REFERENCES extintores(id)
);

CREATE TABLE recargas (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    idextintor INT UNSIGNED,
    fecha DATE,
    proximarecarga DATE,
    FOREIGN KEY (idextintor) REFERENCES extintores(id)
);


-- Datos para la tabla 'ubicaciones'
INSERT INTO ubicaciones (nombre) VALUES
('Oficina 1'),
('Oficina 2'),
('Almacén A'),
('Almacén B'),
('Sala de Servidores'),
('Sala de Reuniones'),
('Piso 1 - Pasillo A'),
('Piso 1 - Pasillo B'),
('Piso 2 - Pasillo A'),
('Piso 2 - Pasillo B');

-- Datos para la tabla 'proveedores'
INSERT INTO proveedores (nombre, telefono, correo) VALUES
('Proveedor A', '123456789', 'proveedora@example.com'),
('Proveedor B', '987654321', 'proveedorb@example.com'),
('Proveedor C', '111222333', 'proveedorc@example.com'),
('Proveedor D', '444555666', 'proveedord@example.com'),
('Proveedor E', '777888999', 'proveedore@example.com'),
('Proveedor F', '222333444', 'proveedorf@example.com'),
('Proveedor G', '555666777', 'proveedorg@example.com'),
('Proveedor H', '888999000', 'proveedorh@example.com'),
('Proveedor I', '333444555', 'proveedori@example.com'),
('Proveedor J', '666777888', 'proveedorj@example.com');

-- Datos para la tabla 'tipos'
INSERT INTO tipos (nombre) VALUES
('CO2'),
('Polvo químico seco'),
('Agua'),
('Espuma'),
('Halon'),
('Polvo ABC'),
('Bromuro de metilo'),
('Dioxido de carbono'),
('Halon 1211'),
('Agua salina');

-- Datos para la tabla 'extintores'
INSERT INTO extintores (capacidad, fechafabricacion, estado, idubicacion, idproveedor) VALUES
(5, '2023-01-15', 'Bueno', 1, 1),
(10, '2022-08-20', 'Regular', 2, 2),
(2, '2024-03-10', 'Bueno', 3, 3),
(3, '2023-11-05', 'Regular', 4, 4),
(7, '2022-06-30', 'Bueno', 5, 5),
(4, '2024-02-20', 'Regular', 6, 6),
(6, '2023-05-12', 'Bueno', 7, 7),
(8, '2023-08-25', 'Bueno', 8, 8),
(9, '2022-11-30', 'Regular', 9, 9),
(12, '2022-04-15', 'Bueno', 10, 10);

-- Datos para la tabla 'inspecciones'
INSERT INTO inspecciones (idextintor, fecha, proximainspeccion) VALUES
(1, '2024-04-15', '2025-04-15'),
(2, '2024-03-20', '2025-03-20'),
(3, '2024-02-10', '2025-02-10'),
(4, '2024-01-05', '2025-01-05'),
(5, '2023-12-20', '2024-12-20'),
(6, '2023-11-15', '2024-11-15'),
(7, '2023-10-10', '2024-10-10'),
(8, '2023-09-05', '2024-09-05'),
(9, '2023-08-20', '2024-08-20'),
(10, '2023-07-15', '2024-07-15');

-- Datos para la tabla 'recargas'
INSERT INTO recargas (idextintor, fecha, proximarecarga) VALUES
(1, '2024-04-20', '2025-04-20'),
(2, '2024-03-25', '2025-03-25'),
(3, '2024-02-15', '2025-02-15'),
(4, '2024-01-10', '2025-01-10'),
(5, '2023-12-25', '2024-12-25'),
(6, '2023-11-20', '2024-11-20'),
(7, '2023-10-15', '2024-10-15'),
(8, '2023-09-10', '2024-09-10'),
(9, '2023-08-25', '2024-08-25'),
(10, '2023-07-20', '2024-07-20');




--SELECT ubicacion.nombre, COUNT(extintor.id)
--FROM extintores
--JOIN ubicaciones ON extintor.idubicacion = ubicacion.id
--JOIN tipo t ON extintor.idtipo = tipo.id
--WHERE ubicacion.nombre = 'nombre' AND tipo.nombre = 'ubicacion'
--GROUP BY ubicacion.nombre;

--Punto 1
CREATE VIEW cantidad_ubicaciones AS
SELECT ubicaciones.nombre AS ubicacion, COUNT(extintores.id) AS cantidad_extintores
FROM ubicaciones
JOIN extintores ON ubicaciones.id = extintores.idubicacion
GROUP BY ubicaciones.nombre;

--Punto 3
SELECT tipos.nombre AS tipo_extintor, MAX(extintores.fechafabricacion) AS fecha_reciente
FROM tipos
JOIN extintores ON tipos.id = extintores.id
GROUP BY tipos.nombre;

--punto 4
SELECT idextintor, COUNT(*) AS numero_inspecciones
FROM inspecciones
GROUP BY idextintor;

--punto 10
SELECT COUNT(*) AS cantidad_recargas
FROM recargas
JOIN inspecciones ON recargas.idextintor = inspecciones.idextintor
WHERE inspecciones.fecha BETWEEN '2024-01-01' AND '2024-05-01';


--punto 6
SELECT COUNT(*) AS cantidad_recargas
FROM recargas
JOIN extintores ON recargas.idextintor = extintores.id
JOIN ubicaciones ON extintores.idubicacion = ubicaciones.id
JOIN tipos ON tipos.id = extintores.id
WHERE ubicaciones.nombre = 'Almacen A' AND tipos.nombre = 'CO2';

--punto 9
SELECT AVG(extintores.capacidad) AS promedio_capacidades
FROM extintores
JOIN recargas ON extintores.id = recargas.idextintor
GROUP BY extintores.id
HAVING COUNT(*) > 3;

--punto 7
SELECT COUNT(*) AS numero_recargas
FROM recargas
JOIN inspecciones ON recargas.idextintor = inspecciones.idextintor
WHERE DATEDIFF(CURDATE(), (SELECT MAX(fecha) FROM inspecciones WHERE inspecciones.idextintor = recargas.idextintor)) > 180;

--punto 2
SELECT tipos.nombre, SUM(extintores.capacidad) AS suma_capacidades
FROM tipos
JOIN extintores ON tipos.id = extintores.id
GROUP BY tipos.id;




