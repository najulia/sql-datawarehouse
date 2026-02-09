/*
===========================================================================
DDL Script: Create Bronze Tables
===========================================================================

This script creates table in 'bronze' schema, dropping tables if it already existss
It re-define the DDL structure of 'bronze' Tables 

===========================================================================

*/


IF  OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL 
    DROP TABLE bronze.crm_cust_info; 

CREATE TABLE bronze.crm_cust_info (

    cst_id INT PRIMARY KEY,  -- Id da empresa

    cst_cnpj NVARCHAR(18) NOT NULL,
    cst_razao_social NVARCHAR(255) NOT NULL,
    cst_setor NVARCHAR(100),
    cst_num_funcionarios INT,

    cst_responsavel NVARCHAR(100),
    cst_responsavel_cs NVARCHAR(100),

    -- Últimos produtos ativos
    cst_ultimo_produto_ij NVARCHAR(150),
    cst_ultimo_produto_pp NVARCHAR(150),
    cst_ultimo_produto_catho NVARCHAR(150),

    -- Datas de vencimento
    cst_vencimento_ij DATE,
    cst_vencimento_pp DATE,
    cst_vencimento_catho DATE,

    -- Valores atuais (podem incluir avulsos)
    cst_preco_ij DECIMAL(18,2),
    cst_preco_pp DECIMAL(18,2),
    cst_valor_produto_catho DECIMAL(18,2)

);
GO

IF  OBJECT_ID('bronze.crm_sales', 'U') IS NOT NULL 
    DROP TABLE bronze.crm_sales; 


CREATE TABLE bronze.crm_sales (

    account_id INT NOT NULL,                 -- Id único da conta no SF
    cst_id INT NOT NULL,                  -- Id da empresa

    cst_cnpj NVARCHAR(18) NOT NULL,
    cst_razao_social NVARCHAR(255) NOT NULL,
    cst_setor NVARCHAR(100),
    cst_num_funcionarios INT,

    cst_responsavel NVARCHAR(100),
    cst_responsavel_cs NVARCHAR(100),

    product_name NVARCHAR(150) NOT NULL,

    activation_date DATE,
    expiration_date DATE,

    valor_liquido DECIMAL(18,2),
    valor_produto_catho DECIMAL(18,2),
    final_produto_catho DATE,

    etapa NVARCHAR(50),

    data_aceite DATE,
    data_producao DATE

);
GO

IF  OBJECT_ID('bronze.crm_products', 'U') IS NOT NULL 
    DROP TABLE bronze.crm_products; 


CREATE TABLE bronze.crm_products (

    product_code INT PRIMARY KEY,   -- Código do produto
    product_name NVARCHAR(150) NOT NULL,
    preco_lista DECIMAL(18,2) NOT NULL,
    tipo NVARCHAR(50) NOT NULL,     -- Ativo / Avulso
    familia NVARCHAR(50) NOT NULL  -- InfoJobs / PandaPé / Catho

);
GO

