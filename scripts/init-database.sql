
/*

======================================================
CREATE DATABASE AND SCHEMAS
======================================================

This script creates a new database named 'DataWarehouse' after checking if it already exists.
If it exists, it is dropped and recreated. Also, the script sets up 3 schemas: bronze, silver and gold

WARNING:

If the database already exists, this script will DROP the entire 'DataWarehouse' and DELETE PERMANENTLY all data in it. 

*/ 

USE master
GO 

-- Drop and create the 'Datawarehouse' database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO


USE DataWarehouse; 
GO

-- Create Schemas

CREATE SCHEMA bronze; 
GO

CREATE SCHEMA silver; 
GO

CREATE SCHEMA gold; 
GO
