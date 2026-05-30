USE [GD1C2026]
GO

-- Ejecutar procedimientos de carga en el orden recomendado
EXEC QUERY_MEVAJI.cargar_paises;
GO

EXEC QUERY_MEVAJI.cargar_provincias;
GO

EXEC QUERY_MEVAJI.cargar_ciudades;
GO

EXEC QUERY_MEVAJI.cargar_localidades;
GO

EXEC QUERY_MEVAJI.cargar_canal_de_venta;
GO

EXEC QUERY_MEVAJI.cargar_medio_de_pago;
GO

EXEC QUERY_MEVAJI.cargar_aspecto;
GO

EXEC QUERY_MEVAJI.cargar_alianza;
GO

EXEC QUERY_MEVAJI.cargar_estado_propuesta;
GO

EXEC QUERY_MEVAJI.cargar_proveedor;
GO

EXEC QUERY_MEVAJI.cargar_excursiones;
GO

EXEC QUERY_MEVAJI.cargar_agencias;
GO

EXEC QUERY_MEVAJI.cargar_clientes;
GO

EXEC QUERY_MEVAJI.cargar_agentes;
GO

EXEC QUERY_MEVAJI.cargar_aerolineas;
GO

EXEC QUERY_MEVAJI.cargar_aeropuertos;
GO

EXEC QUERY_MEVAJI.cargar_vuelos;
GO

EXEC QUERY_MEVAJI.cargar_hospedajes;
GO

EXEC QUERY_MEVAJI.cargar_habitaciones;
GO

EXEC QUERY_MEVAJI.cargar_solicitudes;
GO

EXEC QUERY_MEVAJI.cargar_detalle_solicitudes;
GO

EXEC QUERY_MEVAJI.cargar_propuestas;
GO

EXEC QUERY_MEVAJI.cargar_ventas;
GO

EXEC QUERY_MEVAJI.cargar_propuesta_ventas;
GO

EXEC QUERY_MEVAJI.cargar_detalle_propuesta_hospedaje;
GO

EXEC QUERY_MEVAJI.cargar_detalle_venta_hospedaje;
GO

EXEC QUERY_MEVAJI.cargar_detalle_propuesta_vuelo;
GO

EXEC QUERY_MEVAJI.cargar_detalle_venta_vuelo;
GO

EXEC QUERY_MEVAJI.cargar_detalle_venta_excursion;
GO
