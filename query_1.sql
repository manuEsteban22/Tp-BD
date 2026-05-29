USE [GD1C2026]
GO

--CREATE SCHEMA QUERY_MEVAJI;
--GO

-- CREACION DE TABLAS --
-- Orden: primero tablas maestras sin dependencias, luego las que dependen de ellas

CREATE TABLE QUERY_MEVAJI.Pais (
    pais_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Canal_De_Venta (
    canal_de_venta_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Medio_De_Pago (
    medio_de_pago_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Aspecto (
    aspecto_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Alianza (
    alianza_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Proveedor (
    proveedor_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    telefono nvarchar(255),
    mail nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Excursion (
    excursion_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    descripcion nvarchar(255),
    horario nvarchar(50),
    duracion INT,
    precio DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Estado_De_Propuesta (
    estado_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Provincia (
    provincia_id INT IDENTITY(1,1) PRIMARY KEY,
    pais_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Pais(pais_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Ciudad (
    ciudad_id INT IDENTITY(1,1) PRIMARY KEY,
    provincia_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Provincia(provincia_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Localidad (
    localidad_id INT IDENTITY(1,1) PRIMARY KEY,
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Agencia (
    agencia_id INT IDENTITY(1,1) PRIMARY KEY,
    direccion nvarchar(255),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Localidad(localidad_id),
    telefono nvarchar(255),
    mail nvarchar(255),
    nro_agencia BIGINT
);

CREATE TABLE QUERY_MEVAJI.Agente (
    agente_id INT IDENTITY(1,1) PRIMARY KEY,
    agencia_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Agencia(agencia_id),
    legajo BIGINT,
    nombre nvarchar(255),
    apellido nvarchar(255),
    dni BIGINT,
    telefono nvarchar(255),
    mail nvarchar(255),
    fecha_nac DATE,
    direccion nvarchar(255),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Localidad(localidad_id)
);

CREATE TABLE QUERY_MEVAJI.Cliente (
    cliente_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    apellido nvarchar(255),
    dni BIGINT,
    telefono nvarchar(255),
    mail nvarchar(255),
    fecha_nac DATE,
    direccion nvarchar(255),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Localidad(localidad_id)
);

CREATE TABLE QUERY_MEVAJI.Encuesta (
    encuesta_id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Cliente(cliente_id),
    agente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Agente(agente_id),
    fecha DATE,
    comentario nvarchar(max)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Encuesta (
    encuesta_id INT NOT NULL,
    aspecto_id INT NOT NULL,
    puntaje INT,
    PRIMARY KEY (encuesta_id, aspecto_id),
    FOREIGN KEY (encuesta_id) REFERENCES QUERY_MEVAJI.Encuesta(encuesta_id),
    FOREIGN KEY (aspecto_id) REFERENCES QUERY_MEVAJI.Aspecto(aspecto_id)
);

CREATE TABLE QUERY_MEVAJI.Aerolinea (
    aerolinea_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    codigo nvarchar(255),
    pais_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Pais(pais_id),
    alianza_id INT FOREIGN KEY REFERENCES QUERY_MEVAJI.Alianza(alianza_id)
);

CREATE TABLE QUERY_MEVAJI.Aeropuerto (
    aeropuerto_id INT IDENTITY(1,1) PRIMARY KEY,
    codigo nvarchar(10),
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Vuelo (
    vuelo_id INT IDENTITY(1,1) PRIMARY KEY,
    aerolinea_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Aerolinea(aerolinea_id),
    aeropuesto_origen_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Aeropuerto(aeropuerto_id),
    aeropuerto_destino_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Aeropuerto(aeropuerto_id),
    fecha_salida DATE,
    horario_salida NVARCHAR(50),
    fecha_llegada DATE,
    horario_llegada NVARCHAR(50),
    duracion INT,
    precio DECIMAL(18,2),
    incluye_carry BIT,
    incluye_valija BIT
);

CREATE TABLE QUERY_MEVAJI.Hospedaje (
    hospedaje_id INT IDENTITY(1,1) PRIMARY KEY,
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    nombre nvarchar(255),
    incluye_desayuno BIT,
    check_in TIME,
    check_out TIME
);

CREATE TABLE QUERY_MEVAJI.Habitacion (
    habitacion_id INT IDENTITY(1,1) PRIMARY KEY,
    hospedaje_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Hospedaje(hospedaje_id),
    nombre nvarchar(255),
    descripcion nvarchar(255),
    precio_noche DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Solicitud (
    solicitud_id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Cliente(cliente_id),
    agencia_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Agencia(agencia_id),
    nro_solicitud BIGINT,
    fecha_solicitud DATE,
    fecha_inicio_tentativa DATE,
    fecha_fin_tentativa DATE,
    cant_pax INT,
    observaciones nvarchar(max),
    presupuesto_estimado DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Solicitud (
    detalle_solicitud_id INT IDENTITY(1,1) PRIMARY KEY,
    solicitud_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Solicitud(solicitud_id),
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    cant_dias_aprox INT,
    observaciones nvarchar(max)
);

CREATE TABLE QUERY_MEVAJI.Propuesta (
    propuesta_id INT IDENTITY(1,1) PRIMARY KEY,
    solicitud_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Solicitud(solicitud_id),
    agente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Agente(agente_id),
    fecha_emision DATE,
    vigencia_hasta DATE,
    fecha_desde DATE,
    fecha_hasta DATE,
    subtotal DECIMAL(18,2),
    descuento DECIMAL(18,2),
    importe_total DECIMAL(18,2),
    estado nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Venta (
    venta_id INT IDENTITY(1,1) PRIMARY KEY,
    propuesta_id INT FOREIGN KEY REFERENCES QUERY_MEVAJI.Propuesta(propuesta_id),
    cliente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Cliente(cliente_id),
    nro_venta BIGINT,
    canal_de_venta_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Canal_De_Venta(canal_de_venta_id),
    medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Medio_De_Pago(medio_de_pago_id),
    fecha_venta DATE,
    subtotal DECIMAL(18,2),
    descuento DECIMAL(18,2),
    importe_total DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Propuesta_Hospedaje (
    propuesta_id INT NOT NULL,
    habitacion_id INT NOT NULL,
    fecha_desde DATE,
    fecha_hasta DATE,
    cant INT,
    precio DECIMAL(18,2),
    subtotal DECIMAL(18,2),
    PRIMARY KEY (propuesta_id, habitacion_id),
    FOREIGN KEY (propuesta_id) REFERENCES QUERY_MEVAJI.Propuesta(propuesta_id),
    FOREIGN KEY (habitacion_id) REFERENCES QUERY_MEVAJI.Habitacion(habitacion_id)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Venta_Hospedaje (
    venta_id INT NOT NULL,
    habitacion_id INT NOT NULL,
    fecha_desde DATE,
    fecha_hasta DATE,
    cant INT,
    precio_unitario DECIMAL(18,2),
    subtotal DECIMAL(18,2),
    cod_reserva nvarchar(255),
    PRIMARY KEY (venta_id, habitacion_id),
    FOREIGN KEY (venta_id) REFERENCES QUERY_MEVAJI.Venta(venta_id),
    FOREIGN KEY (habitacion_id) REFERENCES QUERY_MEVAJI.Habitacion(habitacion_id)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Propuesta_Vuelo (
    propuesta_id INT NOT NULL,
    vuelo_id INT NOT NULL,
    cant_pasajes INT,
    precio DECIMAL(18,2),
    subtotal DECIMAL(18,2),
    PRIMARY KEY (propuesta_id, vuelo_id),
    FOREIGN KEY (propuesta_id) REFERENCES QUERY_MEVAJI.Propuesta(propuesta_id),
    FOREIGN KEY (vuelo_id) REFERENCES QUERY_MEVAJI.Vuelo(vuelo_id)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Venta_Vuelo (
    venta_id INT NOT NULL,
    vuelo_id INT NOT NULL,
    cant_pasajes INT,
    precio_unitario DECIMAL(18,2),
    subtotal DECIMAL(18,2),
    cod_reserva nvarchar(255),
    PRIMARY KEY (venta_id, vuelo_id),
    FOREIGN KEY (venta_id) REFERENCES QUERY_MEVAJI.Venta(venta_id),
    FOREIGN KEY (vuelo_id) REFERENCES QUERY_MEVAJI.Vuelo(vuelo_id)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Venta_Excursion (
    venta_id INT NOT NULL,
    excursion_id INT NOT NULL,
    fecha_reserva DATE,
    cant INT,
    precio_unitario DECIMAL(18,2),
    subtotal DECIMAL(18,2),
    cod_reserva nvarchar(255),
    PRIMARY KEY (venta_id, excursion_id),
    FOREIGN KEY (venta_id) REFERENCES QUERY_MEVAJI.Venta(venta_id),
    FOREIGN KEY (excursion_id) REFERENCES QUERY_MEVAJI.Excursion(excursion_id)
);
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_paises
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Pais (descripcion) 
    SELECT DISTINCT p.pais
    FROM
    (
        SELECT Hospedaje_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION

        SELECT Aeropuerto_Salida_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION

        SELECT Aeropuerto_Llegada_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION

        SELECT Aerolinea_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) AS p
    WHERE p.pais IS NOT NULL

END
GO