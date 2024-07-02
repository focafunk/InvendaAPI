-- invenda_t.dbo.errors definition

-- Drop table

-- DROP TABLE invenda_t.dbo.errors;

CREATE TABLE errors (
	erro_id int IDENTITY(1,1) NOT NULL,
	[TYPE] varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	number int NULL,
	state int NULL,
	severity int NULL,
	line int NULL,
	procedure_name varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	message varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL
);


-- invenda_t.dbo.logs definition

-- Drop table

-- DROP TABLE invenda_t.dbo.logs;

CREATE TABLE logs (
	log_id int IDENTITY(1,1) NOT NULL,
	[TYPE] varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	procedure_name varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	message varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL
);


-- invenda_t.dbo.raw_price_excel definition

-- Drop table

-- DROP TABLE invenda_t.dbo.raw_price_excel;

CREATE TABLE raw_price_excel (
	item_desc nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	full_item_desc nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	discount nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	price nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	price_unit nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	price_wheight nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	reviews nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	stock nvarchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	promotion nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	promotion_end_date nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- invenda_t.dbo.raw_prices definition

-- Drop table

-- DROP TABLE invenda_t.dbo.raw_prices;

CREATE TABLE raw_prices (
	rapr_id int IDENTITY(1,1) NOT NULL,
	rere_id int NOT NULL,
	upc varchar(50) COLLATE Latin1_General_CI_AS NULL,
	upc_completo varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	item_desc varchar(MAX) COLLATE Latin1_General_CI_AS NOT NULL,
	quantity decimal(10,2) NULL,
	measurement_unit varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	price decimal(10,2) NOT NULL,
	price_unit decimal(10,2) NULL,
	offer_price decimal(10,2) NULL,
	orig_price decimal(10,2) NULL,
	currency varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	country varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	serial_number varchar(100) COLLATE Latin1_General_CI_AS NULL,
	start_date varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	end_date varchar(MAX) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	stock_alert varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	tags varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	sponsored varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	stars varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	reviews varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data1_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data2_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data3_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data4_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data5_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data6_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	pric_id int NULL,
	prod_id varchar(50) COLLATE Latin1_General_CI_AS NULL,
	new_product bit DEFAULT 0 NULL,
	step varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
	desc_source_id int NULL,
	reprocess_flag bit DEFAULT 0 NULL,
	CONSTRAINT raw_prices_pk PRIMARY KEY (rapr_id)
);
 CREATE NONCLUSTERED INDEX raw_prices_insert_date_IDX ON dbo.raw_prices (  insert_date ASC  )  
	 WITH (  PAD_INDEX = OFF ,FILLFACTOR = 100  ,SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , STATISTICS_NORECOMPUTE = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON  )
	 ON [PRIMARY ] ;


-- invenda_t.dbo.raw_products definition

-- Drop table

-- DROP TABLE invenda_t.dbo.raw_products;

CREATE TABLE raw_products (
	UPC float NULL,
	UPC_Walmart nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UPC_Costco nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	UPC_RCSS nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Item Desc] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Size] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MeasurementUnit nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SuperCategory nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Category nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Subcategory nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Vendor nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Brand nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Subbrand_1 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Subrand_2 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Sizecomplete nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Subbrand Variant] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_1 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_2 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_3 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_4 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_5 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_6 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_7 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_8 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_9 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_10 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	F27 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	F28 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	F29 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- invenda_t.dbo.raw_products_excel definition

-- Drop table

-- DROP TABLE invenda_t.dbo.raw_products_excel;

CREATE TABLE raw_products_excel (
	UPC float NULL,
	[Item Desc] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_1 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_2 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_3 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_4 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_5 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_6 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_7 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_8 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_9 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	item_desc_ret_10 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Size] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	MeasurementUnit nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	SuperCategory nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Category nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Subcategory nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Vendor nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Brand nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Subbrand_1 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Subrand_2 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	Sizecomplete nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Subbrand Variant] nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_1 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_2 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_3 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_4 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_5 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_6 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_7 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_8 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_9 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	P_D_10 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	F27 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	F28 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	F29 nvarchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
);


-- invenda_t.dbo.retailers definition

-- Drop table

-- DROP TABLE invenda_t.dbo.retailers;

CREATE TABLE retailers (
	reta_id int IDENTITY(1,1) NOT NULL,
	name varchar(MAX) COLLATE Modern_Spanish_CI_AS NOT NULL,
	deleted bit DEFAULT 0 NOT NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Modern_Spanish_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Modern_Spanish_CI_AS DEFAULT original_login() NOT NULL,
	CONSTRAINT retailers_pk PRIMARY KEY (reta_id)
);


-- invenda_t.dbo.tables definition

-- Drop table

-- DROP TABLE invenda_t.dbo.tables;

CREATE TABLE tables (
	tabl_id varchar(300) COLLATE Latin1_General_CI_AS NOT NULL,
	name varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	value varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	value2 varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	value3 varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	description varchar(MAX) COLLATE Latin1_General_CI_AS NOT NULL,
	deleted bit DEFAULT 0 NOT NULL,
	parent_tabl_id varchar(300) COLLATE Latin1_General_CI_AS NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	CONSTRAINT tables_pk PRIMARY KEY (tabl_id)
);


-- invenda_t.dbo.products definition

-- Drop table

-- DROP TABLE invenda_t.dbo.products;

CREATE TABLE products (
	upc varchar(50) COLLATE Latin1_General_CI_AS NOT NULL,
	upc_completo varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	item_desc varchar(MAX) COLLATE Latin1_General_CI_AS NOT NULL,
	[size] decimal(38,0) NOT NULL,
	data1_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data2_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data3_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data4_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data5_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data6_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	deleted bit DEFAULT 0 NOT NULL,
	meun_id varchar(300) COLLATE Latin1_General_CI_AS NULL,
	subr_id varchar(300) COLLATE Latin1_General_CI_AS NOT NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	prod_id int IDENTITY(1,1) NOT NULL,
	suca_id varchar(300) COLLATE Latin1_General_CI_AS NULL,
	CONSTRAINT products_pk PRIMARY KEY (prod_id),
	CONSTRAINT products_meun_id_fk FOREIGN KEY (meun_id) REFERENCES tables(tabl_id),
	CONSTRAINT products_subr_id_fk FOREIGN KEY (subr_id) REFERENCES tables(tabl_id),
	CONSTRAINT products_suca_id_fk FOREIGN KEY (suca_id) REFERENCES tables(tabl_id)
);


-- invenda_t.dbo.products_retailers definition

-- Drop table

-- DROP TABLE invenda_t.dbo.products_retailers;

CREATE TABLE products_retailers (
	reta_id int NOT NULL,
	prod_id_retailer varchar(100) COLLATE Latin1_General_CI_AS NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	item_desc_retailer varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	prre_id int IDENTITY(1,1) NOT NULL,
	prod_id int NOT NULL,
	CONSTRAINT products_retailers_pk PRIMARY KEY (prre_id),
	CONSTRAINT products_retailers_uk UNIQUE (reta_id,prod_id),
	CONSTRAINT products_retailers_prod_id_fk FOREIGN KEY (prod_id) REFERENCES products(prod_id),
	CONSTRAINT products_retailers_reta_id_fk FOREIGN KEY (reta_id) REFERENCES retailers(reta_id)
);


-- invenda_t.dbo.products_retailers_descriptions definition

-- Drop table

-- DROP TABLE invenda_t.dbo.products_retailers_descriptions;

CREATE TABLE products_retailers_descriptions (
	prde_id int IDENTITY(1,1) NOT NULL,
	prre_id int NOT NULL,
	item_desc_retailer varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	CONSTRAINT products_retailers_descriptions_pk PRIMARY KEY (prde_id),
	CONSTRAINT products_retailers_prre_id_fk FOREIGN KEY (prre_id) REFERENCES products_retailers(prre_id)
);


-- invenda_t.dbo.raw_price_upc_matches definition

-- Drop table

-- DROP TABLE invenda_t.dbo.raw_price_upc_matches;

CREATE TABLE raw_price_upc_matches (
	rpum_id int IDENTITY(1,1) NOT NULL,
	upc varchar(50) COLLATE Latin1_General_CI_AS NULL,
	item_desc varchar(MAX) COLLATE Latin1_General_CI_AS NOT NULL,
	rapr_id int NOT NULL,
	match_rank int NOT NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	[source] varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	prod_id int NOT NULL,
	CONSTRAINT raw_price_upc_matches_pk PRIMARY KEY (rpum_id),
	CONSTRAINT raw_price_upc_matches_rapr_id_fk FOREIGN KEY (rapr_id) REFERENCES raw_prices(rapr_id)
);


-- invenda_t.dbo.retailer_regions definition

-- Drop table

-- DROP TABLE invenda_t.dbo.retailer_regions;

CREATE TABLE retailer_regions (
	rere_id int IDENTITY(1,1) NOT NULL,
	name varchar(100) COLLATE Modern_Spanish_CI_AS NULL,
	ubic_id varchar(300) COLLATE Modern_Spanish_CI_AS NULL,
	reta_id int NOT NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	CONSTRAINT retailer_regions_pk PRIMARY KEY (rere_id),
	CONSTRAINT retailer_regions_uk UNIQUE (name,reta_id),
	CONSTRAINT retailer_regions_reta_id_fk FOREIGN KEY (reta_id) REFERENCES retailers(reta_id)
);


-- invenda_t.dbo.terminals definition

-- Drop table

-- DROP TABLE invenda_t.dbo.terminals;

CREATE TABLE terminals (
	term_id int IDENTITY(1,1) NOT NULL,
	id varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	serial_number varchar(100) COLLATE Latin1_General_CI_AS NOT NULL,
	body_serial_number varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	name varchar(MAX) COLLATE Latin1_General_CI_AS NOT NULL,
	city varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	street varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	houseNumber varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	postalCode varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	location varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	locationType varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	countryCode varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data1_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data2_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data3_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data4_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data5_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data6_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	rere_id int NOT NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	CONSTRAINT terminals_pk PRIMARY KEY (term_id),
	CONSTRAINT terminals_uk UNIQUE (serial_number),
	CONSTRAINT terminals_rere_id_fk FOREIGN KEY (rere_id) REFERENCES retailer_regions(rere_id)
);


-- invenda_t.dbo.prices definition

-- Drop table

-- DROP TABLE invenda_t.dbo.prices;

CREATE TABLE prices (
	pric_id int IDENTITY(1,1) NOT NULL,
	price decimal(10,2) NOT NULL,
	price_unit decimal(10,2) NULL,
	offer_price decimal(10,2) NULL,
	orig_price decimal(10,2) NULL,
	currency varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	country varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	serial_number varchar(100) COLLATE Latin1_General_CI_AS NULL,
	start_date datetime NULL,
	end_date datetime NULL,
	stock_alert varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	sponsored varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	stars varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	reviews varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data1_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data2_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data3_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data4_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data5_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	data6_flx varchar(MAX) COLLATE Latin1_General_CI_AS NULL,
	rere_id int NOT NULL,
	insert_date datetime DEFAULT getdate() NOT NULL,
	insert_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	update_date datetime DEFAULT getdate() NULL,
	update_user varchar(50) COLLATE Latin1_General_CI_AS DEFAULT original_login() NOT NULL,
	tags varchar(MAX) COLLATE Modern_Spanish_CI_AS NULL,
	week int NULL,
	prod_id int NOT NULL,
	CONSTRAINT prices_pk PRIMARY KEY (pric_id),
	CONSTRAINT prices_uk UNIQUE (serial_number,start_date,end_date,pric_id),
	CONSTRAINT prices_prod_id_fk FOREIGN KEY (prod_id) REFERENCES products(prod_id),
	CONSTRAINT prices_rere_id_fk FOREIGN KEY (rere_id) REFERENCES retailer_regions(rere_id),
	CONSTRAINT prices_terminals_fk FOREIGN KEY (serial_number) REFERENCES terminals(serial_number)
);
