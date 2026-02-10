/*
===========================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===========================================================================

This script loads data into the 'bronze' schemas from external CSV files.

Steps:

	- Truncates the bronze tables before loading data
	- Uses BULK INSERT command to load data from csv filess 

 >> This stored procedure does not accept any parameters or return any valuess

 How to use:
	EXEC bronze.load_bronze; 

===========================================================================

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
	BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME;
		BEGIN TRY

		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';

		PRINT '----------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE(); 
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Naju\Downloads\DWH-SQL\git-repo\datasets\crm_contas.csv'
		WITH (

		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		PRINT '>> Truncating Table:  bronze.crm_sales';
		TRUNCATE TABLE bronze.crm_sales;

		PRINT '>> Inserting Data Into Table: bronze.crm_sales';
		BULK INSERT bronze.crm_sales
		FROM 'C:\Users\Naju\Downloads\DWH-SQL\git-repo\datasets\crm_vendas.csv'
		WITH (

		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		PRINT '>> Truncating Table:  bronze.crm_products';
		TRUNCATE TABLE bronze.crm_products;

		PRINT '>> Inserting Data Into Table: bronze.crm_products';
		BULK INSERT bronze.crm_products
		FROM 'C:\Users\Naju\Downloads\DWH-SQL\git-repo\datasets\crm_produtos.csv'
		WITH (

		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		
		SET @end_time = GETDATE(); 
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> ----------------------------'

		END TRY

			BEGIN CATCH
			PRINT '===============================================';
			PRINT 'WARNING:' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR OCURRED COULD CAUSE DATA ISSUES IN FUTURE' + ERROR_MESSAGE();
			PRINT 'ERROR STATE' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '===============================================';

			END CATCH
	END
