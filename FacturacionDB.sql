USE master
GO

-- This section is for developing purposes
-- This kills any connection for databse "Nomina"
-- In case they exist, allowing to then drop the DB
DECLARE @kill varchar(8000) = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'
FROM master..sysprocesses 
WHERE dbid = db_id('FacturacionBD')

EXEC(@kill);
GO

--Recrea la base de datos

DROP DATABASE IF EXISTS FacturacionDB;
GO

CREATE DATABASE FacturacionBD;
GO

USE FacturacionBD;
GO

--Tablas