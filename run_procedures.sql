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

EXEC QUERY_MEVAJI.cargar_agentes;
GO
