USE [GD1C2026]
GO

--CREATE SCHEMA QUERY_MEVAJI;
GO

-- CREACION DE TABLAS --

CREATE TABLE QUERY_MEVAJI.Pais (                         -- cargado
    pais_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Canal_De_Venta (                  -- cargado
    canal_de_venta_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Medio_De_Pago (                 -- cargado
    medio_de_pago_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Aspecto (                    --- cargado
    aspecto_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Alianza (                -- cargado
    alianza_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Proveedor (               -- cargado
    proveedor_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    telefono nvarchar(255),
    mail nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Excursion (                -- cargado
    excursion_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    descripcion nvarchar(255),
    horario nvarchar(50),
    duracion INT,
    precio DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Estado_De_Propuesta (                 -- cargado
    estado_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Provincia (                      -- cargado
    provincia_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Ciudad (               -- cargado
    ciudad_id INT IDENTITY(1,1) PRIMARY KEY,
    pais_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Pais(pais_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Localidad (              -- cargado
    localidad_id INT IDENTITY(1,1) PRIMARY KEY,
    provincia_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Provincia(provincia_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Agencia (              -- cargado
    agencia_id INT IDENTITY(1,1) PRIMARY KEY,
    direccion nvarchar(255),
    localidad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Localidad(localidad_id),
    telefono nvarchar(255),
    mail nvarchar(255),
    nro_agencia BIGINT
);

CREATE TABLE QUERY_MEVAJI.Agente (            -- cargado
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

CREATE TABLE QUERY_MEVAJI.Cliente (             -- cargado
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

CREATE TABLE QUERY_MEVAJI.Aerolinea (            -- cargado
    aerolinea_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nvarchar(255),
    codigo nvarchar(255),
    pais_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Pais(pais_id),
    alianza_id INT FOREIGN KEY REFERENCES QUERY_MEVAJI.Alianza(alianza_id)
);

CREATE TABLE QUERY_MEVAJI.Aeropuerto (                   -- cargado
    aeropuerto_id INT IDENTITY(1,1) PRIMARY KEY,
    codigo nvarchar(10),
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    descripcion nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Vuelo (                -- cargado
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

CREATE TABLE QUERY_MEVAJI.Hospedaje (            -- cargado
    hospedaje_id INT IDENTITY(1,1) PRIMARY KEY,
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    nombre nvarchar(255),
    incluye_desayuno BIT,
    check_in TIME,
    check_out TIME
);

CREATE TABLE QUERY_MEVAJI.Habitacion (               -- cargado
    habitacion_id INT IDENTITY(1,1) PRIMARY KEY,
    hospedaje_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Hospedaje(hospedaje_id),
    nombre nvarchar(255),
    descripcion nvarchar(255),
    precio_noche DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Solicitud (            -- cargado
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

CREATE TABLE QUERY_MEVAJI.Detalle_Solicitud ( -- CARGADO
    detalle_solicitud_id INT IDENTITY(1,1) PRIMARY KEY,
    solicitud_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Solicitud(solicitud_id),
    ciudad_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Ciudad(ciudad_id),
    cant_dias_aprox INT,
    observaciones nvarchar(max)
);

CREATE TABLE QUERY_MEVAJI.Propuesta ( -- CARGADO 
    propuesta_id INT IDENTITY(1,1) PRIMARY KEY,
    solicitud_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Solicitud(solicitud_id),
    agente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Agente(agente_id),
    nro_propuesta BIGINT,
    fecha_emision DATE,
    vigencia_hasta DATE,
    fecha_desde DATE,
    fecha_hasta DATE,
    subtotal DECIMAL(18,2),
    descuento DECIMAL(18,2),
    importe_total DECIMAL(18,2),
    estado nvarchar(255)
);

CREATE TABLE QUERY_MEVAJI.Venta ( -- CARGADO
    venta_id INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Cliente(cliente_id),
    nro_venta BIGINT,
    canal_de_venta_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Canal_De_Venta(canal_de_venta_id),
    medio_de_pago_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Medio_De_Pago(medio_de_pago_id),
    fecha_venta DATE,
    subtotal DECIMAL(18,2),
    descuento DECIMAL(18,2),
    importe_total DECIMAL(18,2)
);

CREATE TABLE QUERY_MEVAJI.Propuesta_Ventas ( -- CARGADO 
    propuesta_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Propuesta(propuesta_id),
    venta_id INT NOT NULL FOREIGN KEY REFERENCES QUERY_MEVAJI.Venta(venta_id),
    PRIMARY KEY (propuesta_id, venta_id)
);

CREATE TABLE QUERY_MEVAJI.Detalle_Propuesta_Hospedaje ( --CARGADO
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

CREATE TABLE QUERY_MEVAJI.Detalle_Venta_Hospedaje (  -- CARGADO
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

CREATE TABLE QUERY_MEVAJI.Detalle_Propuesta_Vuelo ( -- CARGADO
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

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_ciudades
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Ciudad (pais_id, descripcion)
    SELECT DISTINCT p.pais_id, c.ciudad
    FROM
    (
        SELECT Aeropuerto_Salida_Ciudad AS ciudad, Aeropuerto_Salida_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION 

        SELECT Aeropuerto_Llegada_Ciudad AS ciudad, Aeropuerto_Llegada_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION 

        SELECT Hospedaje_Ciudad AS ciudad, Hospedaje_Pais AS pais
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) AS c
    JOIN QUERY_MEVAJI.Pais p
        ON p.descripcion = c.pais
    WHERE ciudad IS NOT NULL
    
END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_canal_de_venta
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Canal_De_Venta (descripcion)
    SELECT DISTINCT m.canal
    FROM
    (
        SELECT Venta_Canal_Venta as canal
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) m 
    WHERE canal IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_medio_de_pago
AS
BEGIN 

INSERT INTO QUERY_MEVAJI.Medio_De_Pago (descripcion)
    SELECT DISTINCT m.medio
    FROM
    (
        SELECT Venta_Medio_Pago as medio
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) m 
    WHERE medio IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_aspecto
AS
BEGIN 

INSERT INTO QUERY_MEVAJI.Aspecto (descripcion)
    SELECT DISTINCT a.aspecto
    FROM
    (
        SELECT Aspecto_Aspecto as aspecto
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) a
    WHERE aspecto IS NOT NULL

END
GO


CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_alianza
AS
BEGIN 

INSERT INTO QUERY_MEVAJI.Medio_De_Pago (descripcion)
    SELECT DISTINCT a.alianza
    FROM
    (
        SELECT Aerolinea_Alianza as alianza
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) a
    WHERE alianza IS NOT NULL

END
GO


CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_estado_propuesta
AS
BEGIN 

INSERT INTO QUERY_MEVAJI.Estado_De_Propuesta (descripcion)
    SELECT DISTINCT m.estado
    FROM
    (
        SELECT Propuesta_Estado as estado
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) m 
    WHERE estado IS NOT NULL

END
GO



CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_proveedor
AS
BEGIN 

INSERT INTO QUERY_MEVAJI.Proveedor (nombre, telefono, mail)
    SELECT DISTINCT p.nombre, p.telefono, p.mail
    FROM
    (
        SELECT 
            Proveedor_Nombre AS nombre, 
            Proveedor_Mail AS mail, 
            Proveedor_Telefono AS telefono
        FROM 
            GD1C2026.[gd_esquema].[Maestra]
    ) AS p
    WHERE nombre IS NOT NULL

END
GO


CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_excursiones
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Excursion (nombre, descripcion, horario, duracion, precio)
    SELECT DISTINCT e.nombre, e.descripcion, e.horario, e.duracion, e.precio
    FROM
    (
        SELECT 
            Excursion_Nombre as nombre,
            Excursion_Descripcion as descripcion,
            Excursion_Horario as horario,
            Excursion_Duracion as duracion,
            Excursion_Precio as precio
        FROM
            GD1C2026.[gd_esquema].[Maestra]
    ) AS e
    WHERE nombre IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_provincias
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Provincia (descripcion)
    SELECT DISTINCT p.provincia
    FROM
    (
        SELECT Agencia_Provincia AS provincia
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION 

        SELECT Agente_Provincia AS provincia
        FROM GD1C2026.[gd_esquema].[Maestra]

        UNION 

        SELECT Cliente_Provincia AS provincia
        FROM GD1C2026.[gd_esquema].[Maestra]
    ) AS p 
    WHERE provincia IS NOT NULL

END 
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_localidades
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Localidad (provincia_id, descripcion)
    SELECT DISTINCT p.provincia_id, l.localidad
    FROM
    (
        SELECT  Agencia_Provincia AS provincia, Agencia_Localidad AS localidad
        FROM [gd_esquema].[Maestra]

        UNION 

        SELECT  Agente_Provincia AS provincia, Agente_Localidad AS localidad
        FROM [gd_esquema].[Maestra]

        UNION 

        SELECT  Cliente_Provincia AS provincia, Cliente_Localidad AS localidad
        FROM [gd_esquema].[Maestra]
    ) AS l
    JOIN QUERY_MEVAJI.Provincia p
    ON p.descripcion = l.provincia
    WHERE localidad IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_agencias
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Agencia (direccion, localidad_id, telefono, mail, nro_agencia)
    SELECT DISTINCT a.direccion, l.localidad_id, a.telefono, a.mail, a.nro_agencia
    FROM 
    (
        SELECT 
            Agencia_Direccion AS direccion,
            Agencia_Localidad AS localidad,
            Agencia_Telefono AS telefono,
            Agencia_Mail AS mail,
            Agencia_Nro_Agencia AS nro_agencia,
            Agencia_Provincia AS provincia
        FROM 
            GD1C2026.[gd_esquema].[Maestra]
    )AS a
    JOIN QUERY_MEVAJI.Localidad l
        ON l.descripcion = a.localidad

    join QUERY_MEVAJI.Provincia p
        ON p.descripcion = a.provincia
        AND p.provincia_id = l.provincia_id

    WHERE a.nro_agencia IS NOT NULL

END 
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_agentes
AS 
BEGIN 

INSERT INTO QUERY_MEVAJI.Agente (agencia_id, legajo,nombre, apellido, dni, telefono, mail, fecha_nac, direccion, localidad_id)
    SELECT DISTINCT ag.agencia_id,a.legajo, a.nombre, a.apellido, a.dni, a.telefono, a.mail, a.fecha_nac, a.direccion, l.localidad_id
    FROM 
    (
        SELECT 
            Agente_Legajo AS legajo,
            Agente_Nombre AS nombre,
            Agente_Apellido AS apellido,
            Agente_DNI AS dni,
            Agente_Telefono AS telefono,
            Agente_Mail AS mail,
            Agente_Fecha_Nac AS fecha_nac,
            Agente_Direccion AS direccion,
            Agente_Localidad AS localidad,
            Agente_Provincia AS provincia
        FROM 
            GD1C2026.[gd_esquema].[Maestra]
    )AS a
    JOIN QUERY_MEVAJI.Localidad l
        ON l.descripcion = a.localidad

    Join QUERY_MEVAJI.Provincia p
        ON p.descripcion = a.provincia
        AND p.provincia_id = l.provincia_id

    JOIN QUERY_MEVAJI.Agencia ag
        ON ag.localidad_id = l.localidad_id
    WHERE a.dni IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_clientes
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Cliente (nombre, apellido, dni, telefono, mail, fecha_nac, direccion, localidad_id)
    SELECT c.nombre, c.apellido, c.dni, c.telefono, c.mail, c.fecha_nac, c.direccion, l.localidad_id
    FROM
    (
        SELECT 
            Cliente_Nombre AS nombre,
            Cliente_Apellido AS apellido,
            Cliente_Dni AS dni,
            Cliente_Tel AS telefono,
            Cliente_Mail AS mail,
            Cliente_Fecha_Nac AS fecha_nac,
            Cliente_Direccion AS direccion,
            Cliente_Localidad AS localidad,
            Cliente_Provincia AS provincia
        FROM
            GD1C2026.[gd_esquema].[Maestra]
    ) AS c 
    JOIN QUERY_MEVAJI.Localidad l
        ON l.descripcion = c.localidad

    JOIN QUERY_MEVAJI.Provincia p 
        ON p.descripcion = c.provincia
        AND p.provincia_id = l.provincia_id

    WHERE c.nombre IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_aerolineas
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Aerolinea (nombre, codigo, pais_id, alianza_id)
    SELECT DISTINCT a.nombre, a.codigo, p.pais_id, al.alianza_id
    FROM
    (
        SELECT 
            Aerolinea_Nombre AS nombre,
            Aerolinea_Codigo AS codigo,
            Aerolinea_Pais AS pais,
            Aerolinea_Alianza AS alianza
        FROM 
            GD1C2026.[gd_esquema].[Maestra]
    ) AS a
    JOIN QUERY_MEVAJI.Pais p
        ON p.descripcion = a.pais

    LEFT JOIN QUERY_MEVAJI.Alianza al
        ON al.descripcion = a.alianza

    WHERE a.nombre IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_aeropuertos
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Aeropuerto (codigo, ciudad_id, descripcion)
    SELECT DISTINCT a.codigo, c.ciudad_id, a.descripcion
    FROM
    (
        SELECT 
            Aeropuerto_Salida_Codigo AS codigo,
            Aeropuerto_Salida_Ciudad AS ciudad,
            Aeropuerto_Salida_Descripcion AS descripcion
        FROM 
            GD1C2026.[gd_esquema].[Maestra]

        UNION

        SELECT 
            Aeropuerto_Llegada_Codigo AS codigo,
            Aeropuerto_Llegada_Ciudad AS ciudad,
            Aeropuerto_Llegada_Descripcion AS descripcion
        FROM 
            GD1C2026.[gd_esquema].[Maestra]
    ) AS a
    JOIN QUERY_MEVAJI.Ciudad c
        ON c.descripcion = a.ciudad

    WHERE a.codigo IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_vuelos
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Vuelo (aerolinea_id,aeropuesto_origen_id, aeropuerto_destino_id, 
                                fecha_salida, horario_salida, fecha_llegada, horario_llegada,
                                duracion, precio, incluye_carry, incluye_valija)

    SELECT a.aerolinea_id, ao.aeropuerto_id, ad.aeropuerto_id, v.fecha_salida, v.horario_salida, 
           v.fecha_llegada, v.horario_llegada, v.duracion, v.precio, v.incluye_carry, v.incluye_valija
    FROM 
    (
        SELECT 
            Aerolinea_Nombre AS aerolinea,
            Aeropuerto_Salida_Descripcion AS aeropuerto_origen,
            Aeropuerto_Llegada_Descripcion AS aeropuerto_destino,
            Vuelo_Fecha_Salida AS fecha_salida,
            Vuelo_Horario_Salida AS horario_salida,
            Vuelo_Fecha_Llegada AS fecha_llegada,
            Vuelo_Horario_Llegada AS horario_llegada,
            Vuelo_Duracion AS duracion,
            Vuelo_Precio AS precio,
            Vuelo_Incluye_Carry AS incluye_carry,
            Vuelo_Incluye_Valija AS incluye_valija
        FROM
            GD1C2026.[gd_esquema].[Maestra]            
    ) AS v
    JOIN QUERY_MEVAJI.Aerolinea a
        ON a.nombre = v.aerolinea

    JOIN QUERY_MEVAJI.Aeropuerto ao 
        ON ao.descripcion = v.aeropuerto_origen

    JOIN QUERY_MEVAJI.Aeropuerto ad 
        ON ad.descripcion = v.aeropuerto_destino     

    WHERE v.aerolinea IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_hospedajes
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Hospedaje (ciudad_id, nombre, incluye_desayuno, check_in, check_out)
    SELECT DISTINCT c.ciudad_id, h.nombre, h.incluye_desayuno, h.check_in, h.check_out
    FROM
    (
        SELECT 
            Hospedaje_Ciudad AS ciudad,
            Hospedaje_Nombre AS nombre,
            Hospedaje_Incluye_Desayuno AS incluye_desayuno,
            Hospedaje_Check_In AS check_in,
            Hospedaje_Check_Out AS check_out
        FROM
            GD1C2026.[gd_esquema].[Maestra]
    ) AS h
    JOIN QUERY_MEVAJI.Ciudad c
        ON c.descripcion = h.ciudad

    WHERE h.nombre IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_habitaciones
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Habitacion (hospedaje_id, nombre, descripcion, precio_noche)
    SELECT DISTINCT h.hospedaje_id, ha.nombre, ha.descripcion, ha.precio_noche
    FROM
    (
        SELECT 
            Hospedaje_Nombre AS hospedaje,
            Habitacion_Nombre AS nombre,
            Habitacion_Descripcion AS descripcion,
            Habitacion_Precio_Noche AS precio_noche
        FROM
            GD1C2026.[gd_esquema].[Maestra]
    ) AS ha
    JOIN QUERY_MEVAJI.Hospedaje h
        ON h.nombre = ha.hospedaje

    WHERE ha.nombre IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_solicitudes
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Solicitud (cliente_id, agencia_id, nro_solicitud, fecha_solicitud, fecha_inicio_tentativa, 
                            fecha_fin_tentativa, cant_pax, observaciones, presupuesto_estimado)
    SELECT s.cliente_id, s.agencia_id, s.nro_solicitud, s.fecha_solicitud, s.fecha_inicio_tentativa,
           s.fecha_fin_tentativa, s.cant_pax, s.observaciones, s.presupuesto_estimado
    FROM
    (
        SELECT 
            Cliente_Dni AS cliente_dni,
            Cliente_Nombre AS cliente_nombre,
            Agencia_Nro_Agencia AS agencia_nro,
            Solicitud_Nro_Solicitud AS nro_solicitud,
            Solicitud_Fecha_Solicitud AS fecha_solicitud,
            Solicitud_Fecha_Inicio_Tentativa AS fecha_inicio_tentativa,
            Solicitud_Fecha_Fin_Tentativa AS fecha_fin_tentativa,
            Solicitud_Cant_Pax AS cant_pax,
            Solicitud_Observaciones AS observaciones,
            Solicitud_Presupuesto_Estimado AS presupuesto_estimado
        FROM
            GD1C2026.[gd_esquema].[Maestra]
    ) AS s
    JOIN QUERY_MEVAJI.Cliente c
        ON c.dni = s.cliente_dni
        AND c.nombre = s.cliente_nombre

    JOIN QUERY_MEVAJI.Agencia a
        ON a.nro_agencia = s.agencia_nro

    WHERE s.nro_solicitud IS NOT NULL

END
GO

CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_detalle_solicitudes
AS
BEGIN

INSERT INTO QUERY_MEVAJI.Detalle_Solicitud (solicitud_id, ciudad_id, cant_dias_aprox, observaciones)
    SELECT s.solicitud_id, c.ciudad_id, d.cant_dias_aprox, d.observaciones
    FROM 
    (   
        SELECT
            Solicitud_Nro_Solicitud AS nro_solicitud,
            Detalle_Solicitud_Ciudad AS soli_ciudad,
            Detalle_Solicitud_Cant_Dias_Aprox AS cant_dias_aprox,
            Detalle_Solicitud_Observaciones AS observaciones
        FROM
            GD1C2026.[gd_esquema].[Maestra]
    ) AS d 
    JOIN QUERY_MEVAJI.Solicitud s
        ON s.nro_solicitud = d.nro_solicitud
    
    JOIN QUERY_MEVAJI.Ciudad c
        ON c.descripcion = d.soli_ciudad
    
    WHERE d.nro_solicitud IS NOT NULL

END 



GO 
CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_propuestas 
AS  
BEGIN
insert into QUERY_MEVAJI.Propuesta (solicitud_id, agente_id, nro_propuesta, fecha_emision, vigencia_hasta, fecha_desde, fecha_hasta, subtotal, descuento, importe_total, estado)
select s.solicitud_id, a.agente_id, p.nro_propuesta, p.fecha_emision, p.vigencia_hasta, p.fecha_desde, p.fecha_hasta, p.subtotal, p.descuento, p.importe_total, p.estado
from 
(
    select 
        Solicitud_Nro_Solicitud as nro_solicitud,
        Propuesta_Nro_Propuesta as nro_propuesta,
        Agente_Dni as agente_dni,
        Agente_Nombre as agente_nombre,
        Propuesta_Fecha_Emision as fecha_emision,
        Propuesta_Vigencia_Hasta as vigencia_hasta,
        Propuesta_Fecha_Desde as fecha_desde,
        Propuesta_Fecha_Hasta as fecha_hasta,
        Propuesta_Subtotal as subtotal,
        Propuesta_Descuento as descuento,
        Propuesta_Importe_Total as importe_total,
        Propuesta_Estado as estado
    from 
    GD1C2026.[gd_esquema].[Maestra]
) as p
join QUERY_MEVAJI.Solicitud s
    on s.nro_solicitud = p.nro_solicitud
join QUERY_MEVAJI.Agente a
    on a.agente_dni = p.agente_dni
 where p.nro_solicitud is not null AND p.agente_dni is not null
END 


GO 
CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_ventas
AS  
BEGIN 
insert into QUERY_MEVAJI.Venta (cliente_id, nro_venta, canal_de_venta_id, medio_de_pago_id, fecha_venta, subtotal, descuento, importe_total)
select c.cliente_id, v.nro_venta, cv.canal_de_venta_id, mp.medio_de_pago_id, v.fecha_venta, v.subtotal, v.descuento, v.importe_total
from        
(
    select 
        Cliente_Dni as cliente_dni,
        Cliente_Nombre as cliente_nombre,
        Venta_Nro_Venta as nro_venta,
        Venta_Canal_Venta as canal_de_venta,
        Venta_Medio_Pago as medio_de_pago,
        Venta_Fecha_Venta as fecha_venta,
        Venta_Subtotal as subtotal,
        Venta_Descuento as descuento,
        Venta_Importe_Total as importe_total
    from 
    GD1C2026.[gd_esquema].[Maestra]
) as v
join QUERY_MEVAJI.Cliente c
    on c.dni = v.cliente_dni
join QUERY_MEVAJI.Canal_De_Venta cv
    on cv.descripcion = v.canal_de_venta 
join QUERY_MEVAJI.Medio_De_Pago mp
    on mp.descripcion = v.medio_de_pago
where v.nro_venta is not null AND v.cliente_dni is not null

END 


GO 
CREATE OR ALTER PROCEDURE QUERY_MEJAVI.cargar_propuesta_ventas
AS 
BEGIN 
INSERT INTO QUERY_MEJAVI.Propuesta_Ventas(propuesta_id, venta_id)
SELECT p.propuesta_id, v.venta_id
FROM 
( 
    SELECT 
        Venta_Nro_Venta as nro_venta,
        Propuesta_Nro_Propuesta as nro_propuesta
    from 
    GD1C2026.[gd_esquema].[Maestra]
)m 
join QUERY_MEVAJI.Propuesta p
    on p.nro_propuesta = m.nro_propuesta
join QUERY_MEVAJI.Venta v
    on v.nro_venta = m.nro_venta
where m.nro_propuesta is not null AND m.nro_venta is not null
END


GO 
CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_detalle_propuesta_hospedaje
AS
BEGIN
INSERT INTO QUERY_MEVAJI.Detalle_Propuesta_Hospedaje (propuesta_id, habitacion_id, fecha_desde, fecha_hasta, cant, precio, subtotal)
SELECT p.propuesta_id, h.habitacion_id, m.fecha_desde,   m.fecha_hasta, m.cant, m.precio, m.subtotal
FROM
(
    SELECT 
        Propuesta_Nro_Propuesta as nro_propuesta,
        Habitacion_Nombre as nombre_habitacion,
        Habitacion_Descripcion as descripcion_habitacion,
        Detalle_Propuesta_Hospedaje_Fecha_Desde as fecha_desde,
        Detalle_Propuesta_Hospedaje_Fecha_Hasta as fecha_hasta,
        Detalle_Propuesta_Hospedaje_Cant as cant,
        Detalle_Propuesta_Hospedaje_Precio as precio,
        Detalle_Propuesta_Hospedaje_Subtotal as subtotal
    from 
    GD1C2026.[gd_esquema].[Maestra]
) as m
Join query_mejavi.Propuesta p
    on p.nro_propuesta = m.nro_propuesta
Join QUERY_MEVAJI.Habitacion h
    on h.nombre = m.nombre_habitacion
    and h.descripcion = m.descripcion_habitacion
where m.nro_propuesta is not null AND m.nombre_habitacion is not null AND m.descripcion_habitacion is not null
END


GO
CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_detalle_venta_hospedaje
AS
BEGIN
INSERT INTO QUERY_MEVAJI.Detalle_Venta_Hospedaje (venta_id, habitacion_id, fecha_desde, fecha_hasta, cant, precio_unitario, subtotal, cod_reserva)
SELECT v.ventf.id, h.habitacion_id, m.fecha_desde, m.fecha_hasta, m.cant, m.precio_unitario, m.subtotal, m.cod_reserva
FROM
(
    SELECT 
        Venta_Nro_Venta as nro_venta,
        Habitacion_Nombre as nombre_habitacion,
        Habitacion_Descripcion as descripcion_habitacion,
        Detalle_Venta_Hospedaje_Fecha_Desde as fecha_desde,
        Detalle_Venta_Hospedaje_Fecha_Hasta as fecha_hasta,
        Detalle_Venta_Hospedaje_Cant as cant,
        Detalle_Venta_Hospedaje_Precio_Unitario as precio_unitario,
        Detalle_Venta_Hospedaje_Subtotal as subtotal,
        Detalle_Venta_Hospedaje_Cod_Reserva as cod_reserva
    from 
    GD1C2026.[gd_esquema].[Maestra]
) as m
Join QUERY_MEVAJI.Venta v
    on v.nro_venta = m.nro_venta
Join QUERY_MEVAJI.Habitacion h
    on h.nombre = m.nombre_habitacion
    and h.descripcion = m.descripcion_habitacion
where m.nro_venta is not null AND m.nombre_habitacion is not null AND m.descripcion_habitacion is not null
END

GO
CREATE OR ALTER PROCEDURE QUERY_MEVAJI.cargar_detalle_propuesta_vuelo
AS
BEGIN
INSERT INTO QUERY_MEVAJI.Detalle_Propuesta_Vuelo (propuesta_id, vuelo_id, cant_pasajes, precio, subtotal)
SELECT p.propuesta_id, v.vuelo_id, m.cant_pasajes, m.precio, m.subtotal
FROM
(
    SELECT 
        Propuesta_Nro_Propuesta as nro_propuesta,
        Aerolinea_Nombre as nombre_aerolinea,
        Aeropuerto_Salida_Descripcion as aeropuerto_origen,
        Aeropuerto_Llegada_Descripcion as aeropuerto_destino,
        Detalle_Propuesta_Vuelo_Cant_Pasajes as cant_pasajes,
        Detalle_Propuesta_Vuelo_Precio as precio,
        Detalle_Propuesta_Vuelo_Subtotal as subtotal
    from 
    GD1C2026.[gd_esquema].[Maestra]
) as m
Join query_mejavi.Propuesta p
    on p.nro_propuesta = m.nro_propuesta
Join QUERY_MEVAJI.Vuelo v
    on v.aeropuesto_origen_id = (select aeropuerto_id from QUERY_MEVAJI.Aeropuerto where descripcion = m.aeropuerto_origen)
    and v.aeropuerto_destino_id = (select aeropuerto_id from QUERY_MEVAJI.Aeropuerto where descripcion = m.aeropuerto_destino)
    and v.aerolinea_id = (select aerolinea_id from QUERY_MEVAJI.Aerolinea where nombre = m.nombre_aerolinea)
where m.nro_propuesta is not null AND m.nombre_aerolinea is not null
AND m.aeropuerto_origen is not null AND m.aeropuerto_destino is not null
END