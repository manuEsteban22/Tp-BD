-- SCRIPT PARA LIMPIAR LA BASE DE DATOS
-- Borra todas las tablas, procedimientos y el schema QUERY_MEVAJI si existen.

USE [GD1C2026]
GO

DECLARE @sql NVARCHAR(MAX) = N'';

-- Eliminar todas las foreign keys del schema QUERY_MEVAJI
SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(SCHEMA_NAME(o.schema_id)) + N'.' + QUOTENAME(o.name) + N' DROP CONSTRAINT ' + QUOTENAME(f.name) + N';' + CHAR(13)
FROM sys.foreign_keys AS f
JOIN sys.objects AS o ON f.parent_object_id = o.object_id
WHERE SCHEMA_NAME(o.schema_id) = N'QUERY_MEVAJI';

IF @sql <> N''
BEGIN
    EXEC sp_executesql @sql;
END

-- Eliminar todas las tablas del schema QUERY_MEVAJI
SET @sql = N'';
SELECT @sql = @sql + N'DROP TABLE IF EXISTS QUERY_MEVAJI.' + QUOTENAME(name) + N';' + CHAR(13)
FROM sys.tables
WHERE schema_id = SCHEMA_ID(N'QUERY_MEVAJI');

IF @sql <> N''
BEGIN
    EXEC sp_executesql @sql;
END

-- Eliminar todos los procedimientos del schema QUERY_MEVAJI
SET @sql = N'';
SELECT @sql = @sql + N'DROP PROCEDURE IF EXISTS QUERY_MEVAJI.' + QUOTENAME(name) + N';' + CHAR(13)
FROM sys.objects
WHERE type IN (N'P', N'PC')
  AND schema_id = SCHEMA_ID(N'QUERY_MEVAJI');

IF @sql <> N''
BEGIN
    EXEC sp_executesql @sql;
END

-- Eliminar el schema si está vacío
IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'QUERY_MEVAJI')
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM sys.objects o
        JOIN sys.schemas s ON o.schema_id = s.schema_id
        WHERE s.name = N'QUERY_MEVAJI'
    )
    BEGIN
        EXEC(N'DROP SCHEMA QUERY_MEVAJI');
    END
END

PRINT 'Base de datos limpiada correctamente - Schema QUERY_MEVAJI eliminado';
GO
