/*Creates a new product using parameters
 *@author rruiz
 **/
CREATE PROCEDURE dbo.createProduct (@upc_number varchar(MAX),
									@product_name varchar(MAX),
									@product_retailer_name varchar(MAX),		
									@size_number varchar(MAX),
									@measurement_uni_name varchar(MAX),
									@supercategory_name varchar(MAX),
									@category_name varchar(MAX),
									@subcategory_name varchar(MAX),
									@vendor_name varchar(MAX),
									@brand_name varchar(MAX),
									@subbrand_name varchar(MAX),
									@retailers varchar(MAX),
									@prod_id int OUTPUT 
									)

AS
BEGIN
	DECLARE @PROD VARCHAR(MAX);
	DECLARE @name varchar(500);
    DECLARE @value varchar(500);
    DECLARE @parent varchar(500);
    DECLARE @step varchar(500);
    DECLARE @UPC varchar(MAX);
    DECLARE @Item_Desc  varchar(MAX);
    DECLARE @item_desc_ret_1 varchar(MAX);
    DECLARE @item_desc_ret_2 varchar(MAX);
    DECLARE @item_desc_ret_3 varchar(MAX);
    DECLARE @item_desc_ret_4 varchar(MAX);
    DECLARE @item_desc_ret_5 varchar(MAX);
    DECLARE @item_desc_ret_6 varchar(MAX);
    DECLARE @item_desc_ret_7 varchar(MAX);
    DECLARE @item_desc_ret_8 varchar(MAX);
    DECLARE @item_desc_ret_9 varchar(MAX);
    DECLARE @item_desc_ret_10 varchar(MAX);
    DECLARE @Size varchar(MAX);
    DECLARE @SizeNum decimal (38,0);
    DECLARE @Subcategory varchar(MAX);
    DECLARE @Subbrand_1 varchar(MAX);
    DECLARE @P_D_1 varchar(MAX);
    DECLARE @P_D_2 varchar(MAX);
    DECLARE @P_D_3 varchar(MAX);
    DECLARE @P_D_4 varchar(MAX);
    DECLARE @P_D_5 varchar(MAX);
    DECLARE @P_D_6 varchar(MAX);
    DECLARE @MeasurementUnit varchar(MAX);
    DECLARE @ndx int;
    DECLARE @num1 varchar(MAX);
    DECLARE @num2 varchar(MAX);
    DECLARE @sourcet varchar(MAX);
    DECLARE @retailer varchar(MAX);
    DECLARE @retnames table(pos int, name varchar(255),reta_id int);
    DECLARE @reta_id int;
    DECLARE @pos int;
	DECLARE @item_desc_ret varchar(MAX);
	declare @retis int;

	
   	set @prod_id = 0;
 
--	DECLARE category_cursor CURSOR FOR   
-- 			SELECT distinct 'supercategory' name, rp.Supercategory value,null parent_table_id
--			FROM   raw_products_excel rp
--			where rp.Supercategory is not null
--			union all
--			SELECT distinct 'category' name, rp.Category value, 'supercategory'+rp.Supercategory parent_table_id
--			FROM   raw_products_excel rp
--			where rp.Category is not null
--			union						
--			SELECT DISTINCT 'subcategory' name, rp.Subcategory value,'category'+rp.Category parent_table_id
--			FROM   raw_products_excel rp
--			where rp.Subcategory is not null;
--		
--	DECLARE vendor_cursor CURSOR FOR   
-- 			SELECT distinct 'vendor' name, rp.Vendor value,null parent_table_id
--			FROM   raw_products_excel rp
--			where rp.Vendor is not null
--			union all
--			SELECT distinct 'brand' name, rp.Brand value, 'vendor'+rp.Vendor parent_table_id
--			FROM   raw_products_excel rp
--			where rp.Brand is not null
--			union						
--			SELECT DISTINCT 'subbrand' name, rp.Subbrand_1 value,'brand'+rp.Brand  parent_table_id
--			FROM   raw_products_excel rp
--			where rp.Subbrand_1 is not null;
		
		
	DECLARE product_cursor CURSOR FOR   
 			SELECT UPC
					,[Item Desc] 
					,item_desc_ret_1 
					,item_desc_ret_2 
					,item_desc_ret_3 
					,item_desc_ret_4 
					,item_desc_ret_5 
					,item_desc_ret_6 
					,item_desc_ret_7 
					,item_desc_ret_8 
					,item_desc_ret_9 
					,item_desc_ret_10 
					,[Size]
					,Subcategory
					,Subbrand_1
					,P_D_1
					,P_D_2
					,P_D_3
					,P_D_4
					,P_D_5
					,P_D_6
					,MeasurementUnit
 			from raw_products_excel;   
 		
 		DECLARE retailers_cursor CURSOR FOR
	   	  SELECT value 
	   	  FROM STRING_SPLIT(@retailers, ',');
	 		
BEGIN try
	-- CODIGO PARA FORZAR PRICING PARA TRABAJAR CON INVENDA
	INSERT INTO raw_products_excel(UPC
							,[Item Desc]
							,item_desc_ret_1
							,Size
							,MeasurementUnit
							,SuperCategory
							,Category
							,Subcategory
							,Vendor
							,Brand
							,Subbrand_1)
	VALUES (@upc_number,
			@product_name,
			@product_retailer_name,
			@size_number,
			@measurement_uni_name,
			@supercategory_name,
			@category_name,
			@subcategory_name,
			@vendor_name,
			@brand_name,
			@subbrand_name);
		
	-- FINCODIGO PARA FORZAR PRICING PARA TRABAJAR CON INVENDA

	-- Parse values passed by parameter
	OPEN retailers_cursor;

    PRINT N'createProduct - loading retailers names';	
	EXEC logmsg 'LOG','createProduct loading retailers names con prod y rapr_id: ',@product_name,@@identity,1;

	FETCH NEXT FROM retailers_cursor
	INTO @retailer;

	set @pos=1;
	WHILE @@FETCH_STATUS = 0  
		BEGIN  
			PRINT N'createProduct - retailer read:'+@retailer;
		
			SELECT @reta_id=reta_id
			from retailers r 
			where upper(r.name) = upper(@retailer);
		
			PRINT N'createProduct - retailer id:'+convert(varchar,@reta_id);

			insert into @retnames ( pos, name,reta_id) values (@pos, @retailer,@reta_id)
			set @pos = @pos + 1;

			FETCH NEXT FROM retailers_cursor
			INTO @retailer;
	
		END;
		CLOSE retailers_cursor;  
		DEALLOCATE retailers_cursor;  
	
	--  BEGIN TRANSACTION TR_PRODUCTS;
  
--	OPEN category_cursor;
--
--    PRINT N'createProduct - processing categories';
--
--	FETCH NEXT FROM category_cursor
--	INTO @name,@value,@parent;
--
--	WHILE @@FETCH_STATUS = 0  
--		BEGIN  
--			PRINT N'createProduct - category read:'+@name+' '+@value+' '+@parent;
--
--			BEGIN TRY
--
--				INSERT INTO dbo.tables (name, value, value2,parent_tabl_id)
--					VALUES ( @name
--				           , @value
--				           ,1
--				          ,@parent);
----				   
--				PRINT N'createProduct - inserting category:'+@name+' '+@value+' parent '+@parent;
--
--			END TRY
--			BEGIN CATCH
----						UPDATE tables 
----						SET parent_tabl_id = @parent
----						where name = @name
----						and value = @value;
--					 	PRINT N'createProduct - category already exists :'+@name+' '+@value+' parent '+@parent;
--
--			END CATCH
--					
--			FETCH NEXT FROM category_cursor
--			INTO @name,@value,@parent;
--
--	
--		END;
--		CLOSE category_cursor;  
--		DEALLOCATE category_cursor;  
--	
	
--	/** now let's insert vendors brands and subbrands **/
--	OPEN vendor_cursor;
--
--    PRINT N'createProduct - processing vendors';
--
--	FETCH NEXT FROM vendor_cursor
--	INTO @name,@value,@parent;
--
--	WHILE @@FETCH_STATUS = 0  
--		BEGIN  
--			PRINT N'createProduct - read vendors:'+@name+' '+@value+' '+@parent;
--
--			BEGIN TRY
--
--				INSERT INTO dbo.tables (name, value, parent_tabl_id)
--					VALUES ( @name
--				           , @value
--				          ,@parent);
--				        
--					PRINT N'createProduct - inserted vendor:'+@name+' '+@value;
--
--				END TRY
--				BEGIN CATCH
--						UPDATE tables 
--						SET parent_tabl_id = @parent
--						where name = @name
--						and value = @value;
--					 	PRINT N'createProduct - vendor already exist:'+@name+' '+@value+' parent '+@parent;
--
--					 END CATCH
--					
--			FETCH NEXT FROM vendor_cursor
--			INTO @name,@value,@parent;
--
--	
--		END;
--		CLOSE vendor_cursor;  
--		DEALLOCATE vendor_cursor; 
 	/** One more step, let's insert or update products **/
	/** now let's insert vendors brands and subbrands **/
	OPEN product_cursor;

    PRINT N'createProduct - processing products';

	FETCH NEXT FROM product_cursor
	INTO @UPC
			,@Item_Desc 
			,@item_desc_ret_1
			,@item_desc_ret_2
			,@item_desc_ret_3
			,@item_desc_ret_4
			,@item_desc_ret_5
			,@item_desc_ret_6
			,@item_desc_ret_7
			,@item_desc_ret_8
			,@item_desc_ret_9
			,@item_desc_ret_10
			,@Size
			,@Subcategory
			,@Subbrand_1
			,@P_D_1
			,@P_D_2
			,@P_D_3
			,@P_D_4
			,@P_D_5
			,@P_D_6
			,@MeasurementUnit;

	WHILE @@FETCH_STATUS = 0  
		BEGIN  
				PRINT N'createProduct - read product:'+@UPC+' '+@Item_Desc;

				/* Let's calculate the measurement unit*/

				-- I try to insert into tables in case the measurement does not exist yet
				BEGIN TRY
					INSERT INTO dbo.tables (name, value)
						VALUES ( 'measurement_units'
					    , @MeasurementUnit);
					         
						PRINT N'createProduct - inserted meun:'+@MeasurementUnit;
				END TRY
				BEGIN CATCH
					 	PRINT N'createProduct - meun id already exist:'+@MeasurementUnit;
				END CATCH
				
				--let's calculate the size
				PRINT N'createProduct - using size:|'+@Size+'|';

				-- find x characters
				set @Size = rtrim(ltrim(@Size));
				set @ndx = charindex('x',@Size);
				if @ndx = 0 set @ndx = charindex('×',@Size);
				if @ndx = 0 set @ndx = charindex('X',@Size);
				
				
				if @ndx != 0
					begin
							PRINT N'size ndx !=0 :'+cast(@ndx as varchar);

							set @num1 = substring(@size,0,@ndx);
							set @num2 = substring(@size,@ndx+1,len(@size));
							PRINT N'createProduct - size with x :'+cast(@num1 as varchar) +' '+ cast(@num2 as varchar);
							set @SizeNum = cast (@num1 as decimal ) * cast (@num2 as decimal);
					end
				else
					begin
						PRINT N'size ndx=0 :'+cast(@ndx as varchar);
						if @Size = '' or @Size is NULL 
							begin
								PRINT N'createProduct - size null';
								set @SizeNum=0;
							end;
						else	
							begin
								PRINT N'createProduct - size <> null';
								set @SizeNum = convert (decimal(20,2),replace(replace(rtrim(ltrim(@Size)), ',', ''),' ',''));

							end;
					end;
				
				PRINT N'createProduct - post size ';
				PRINT N'createProduct - size :'+ cast (@SizeNum as varchar);

				/** now it is time to find if the product already exist**/	
				PRINT N'createProduct - finding product with desc '+@item_desc;
				select @retis=reta_id from @retnames r where r.pos=1
				PRINT N'createProduct - RETIS pos 1:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_1;		
				select @retis=reta_id from @retnames r where r.pos=2
				PRINT N'createProduct - RETIS pos 2:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_2;				
				select @retis=reta_id from @retnames r where r.pos=3
				PRINT N'createProduct - RETIS pos 3:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_3;
				select @retis=reta_id from @retnames r where r.pos=4
				PRINT N'createProduct - RETIS pos 4:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_4;
				select @retis=reta_id from @retnames r where r.pos=5
				PRINT N'createProduct - RETIS pos 5:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_5;
				select @retis=reta_id from @retnames r where r.pos=6
				PRINT N'createProduct - RETIS pos 6:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_6;
				select @retis=reta_id from @retnames r where r.pos=7
				PRINT N'createProduct - RETIS pos 7:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_7;
				select @retis=reta_id from @retnames r where r.pos=8
				PRINT N'createProduct - RETIS pos 8:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_8;
				select @retis=reta_id from @retnames r where r.pos=9
				PRINT N'createProduct - RETIS pos 9:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_9;
				select @retis=reta_id from @retnames r where r.pos=10
				PRINT N'createProduct - RETIS pos 10:'+convert(varchar,@retis) + 'desc '+@item_desc_ret_10;
				
				set @prod_id=0;
				
				--first, let's try to match exact product description
				SELECT @prod_id = p.prod_id
				from products p 
				where upper(p.item_desc) = rtrim(ltrim(upper(@Item_desc)));
				--or (upper(p.upc) = rtrim(ltrim(upper(@UPC))) and @UPC is not null);
				
				-- if not exact match with item_desc or upc then try to match by retailer descripction
				IF @prod_id = 0 
				begin
				
					SELECT @prod_id = pr.prod_id
					from products_retailers_descriptions prde 
						 ,products_retailers pr 
					where pr.prre_id = prde.prre_id 
					and (
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_1)))
								and (pr.reta_id = (COALESCE ((select reta_id from @retnames where pos=1),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_2)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=2),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_3)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=3),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_4)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=4),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_5)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=5),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_6)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=6),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_7)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=7),0))))
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_8)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=8),0))))					
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_9)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=9),0))))				
						or
							( upper(prde.item_desc_retailer) = rtrim(ltrim(upper(@item_desc_ret_10)))
								and (pr.reta_id = (COALESCE((select reta_id from @retnames where pos=10),0))))
							
							);
				end;				
			
				IF @prod_id = 0 
				begin
					PRINT N'createProduct - product does not exist';
				end;
				PRINT N'createProduct - prod id :'+cast(@prod_id as varchar);

			
				if @prod_id != 0
						begin
							--product exists, let's update its contents
							PRINT N'createProduct - updating product :'+cast(@prod_id as varchar);
							
							SET @PROD=cast(@prod_id as varchar);	
							EXEC logmsg 'LOG','createProduct',' updating prod_id:',@PROD,1;
							
							UPDATE dbo.products 
							set upc= @UPC
								,item_desc = @Item_desc
								,[size]=@SizeNum
								,meun_id='measurement_units'+@MeasurementUnit
								,suca_id = 'subcategory'+@Subcategory
								,subr_id = 'subbrand'+@Subbrand_1
								,data1_flx = @P_D_1
								,data2_flx = @P_D_2
								,data3_flx = @P_D_3
								,data4_flx = @P_D_4
								,data5_flx = @P_D_5
								,data6_flx = @P_D_6
							where prod_id = @prod_id;
						end		
				else
					begin
							PRINT CONCAT('createProduct - inserting product:', @UPC,' '
									,@Item_Desc,' '
									,@SizeNum,' '
									,'measurement_units'+@MeasurementUnit,' '
									,'subcategory'+@Subcategory,' '
									,'subbrand'+@Subbrand_1,' '
									,@P_D_1,' '
									,@P_D_2,' '
									,@P_D_3,' '
									,@P_D_4,' '
									,@P_D_5,' '
									,@P_D_6);
								
						INSERT INTO dbo.products (upc
								,item_desc
								,[size]
								,meun_id 
								,suca_id 
								,subr_id 
								,data1_flx
								,data2_flx
								,data3_flx
								,data4_flx
								,data5_flx
								,data6_flx)
							VALUES (  @UPC
									,@Item_Desc
									,@SizeNum
									,'measurement_units'+@MeasurementUnit
									,'subcategory'+@Subcategory
									,'subbrand'+@Subbrand_1
									,@P_D_1
									,@P_D_2
									,@P_D_3
									,@P_D_4
									,@P_D_5
									,@P_D_6);
						     		
							--get the last generated id
							set @prod_id = @@identity;
							
							PRINT CONCAT('createProduct - inserted product:', @UPC,' '
									,@Item_Desc,' '
									,@SizeNum,' '
									,'measurement_units'+@MeasurementUnit,' '
									,'subcategory'+@Subcategory,' '
									,'subbrand'+@Subbrand_1,' '
									,@P_D_1,' '
									,@P_D_2,' '
									,@P_D_3,' '
									,@P_D_4,' '
									,@P_D_5,' '
									,@P_D_6,' prod_id:',cast(@prod_id as varchar));
								
							SET @PROD=cast(@prod_id as varchar);
							EXEC logmsg 'LOG','createProduct - inserted product:','prod_id',@PROD,1;
						end;

					   	 
   	 				/** Finally, lets insert product_retailers_descriptions **/
					-- first let's insert records for each retailer y product_retailers
				 	DECLARE retnames_cursor CURSOR FOR
					  SELECT pos,name,reta_id 
					  FROM @retnames
					  order by pos asc;

					 PRINT N'createProduct - opening retnames';

					OPEN retnames_cursor;
		
		    		PRINT N'createProduct - loading retailers names table';
				
					FETCH NEXT FROM retnames_cursor
					INTO @pos,@retailer,@reta_id;
					PRINT N'createProduct - retname leido pos:'+cast(@pos as varchar)+' name:'+@retailer+' reta id:'+cast(@reta_id as varchar);

		
					WHILE @@FETCH_STATUS = 0  
					BEGIN  
							if @pos=1 set @item_desc_ret = @item_desc_ret_1
				    		else if @pos=2 set @item_desc_ret = @item_desc_ret_2
				    		else if @pos=3 set @item_desc_ret = @item_desc_ret_3
				    		else if @pos=4 set @item_desc_ret = @item_desc_ret_4
				    		else if @pos=5 set @item_desc_ret = @item_desc_ret_5
				    		else if @pos=6 set @item_desc_ret = @item_desc_ret_6
				    		else if @pos=7 set @item_desc_ret = @item_desc_ret_7
				    		else if @pos=7 set @item_desc_ret = @item_desc_ret_8
				    		else if @pos=9 set @item_desc_ret = @item_desc_ret_9
				    		else if @pos=10 set @item_desc_ret = @item_desc_ret_10;
		
							PRINT N'createProduct - upserting retailer description in :'+@retailer+' prod id '+cast(@prod_id as varchar)+ ' desc '+@item_desc_ret+' reta '+convert(varchar,@reta_id);

							merge products_retailers pr
							using (select @reta_id reta_id) rewa
							on rewa.reta_id = pr.reta_id and pr.prod_id = @prod_id
							when not matched then 
								insert (prod_id, reta_id)
								values (@prod_id, rewa.reta_id);
							
							if (@item_desc_ret is not null) --if description is not informed, do not insert or update
							begin
								merge products_retailers_descriptions prde
								using (select prre_id, pr.prod_id 
									   from products_retailers pr
										where pr.reta_id = @reta_id 
										and pr.prod_id = @prod_id) rewa
								on rewa.prre_id = prde.prre_id 
								and upper(rtrim(ltrim(prde.item_desc_retailer))) = upper(rtrim(ltrim(@item_desc_ret)))
								when not matched then 
									insert (prre_id, item_desc_retailer)
									values (rewa.prre_id, @item_desc_ret);
							end
							
							FETCH NEXT FROM retnames_cursor
							INTO @pos,@retailer,@reta_id;
						
						END;
						CLOSE retnames_cursor;  
						DEALLOCATE retnames_cursor;  
			
				
						/** Now add new descriptions **/
					 	PRINT N'createProduct - fetching next product';
		
						FETCH NEXT FROM product_cursor
						INTO @UPC
								,@Item_Desc 
								,@item_desc_ret_1
								,@item_desc_ret_2
								,@item_desc_ret_3
								,@item_desc_ret_4
								,@item_desc_ret_5
								,@item_desc_ret_6
								,@item_desc_ret_7
								,@item_desc_ret_8
								,@item_desc_ret_9
								,@item_desc_ret_10
								,@Size
								,@Subcategory
								,@Subbrand_1
								,@P_D_1
								,@P_D_2
								,@P_D_3
								,@P_D_4
								,@P_D_5
								,@P_D_6
								,@MeasurementUnit;
										
		END;
	
	 	PRINT N'createProduct - closing gracefully';
		
	 	--finally empty raw_price_excel
		DELETE FROM raw_products_excel;
	
		CLOSE product_cursor;  
		DEALLOCATE product_cursor;   
		
  		
	end try
	
 	
	BEGIN CATCH
--		IF (XACT_STATE()) = -1
--			ROLLBACK TRANSACTION TR_PRODUCTS;
		--finally empty raw_price_excel
		DELETE FROM raw_products_excel;

	 	PRINT N'createProduct - Errors Catch:'+error_message();
	
--	 	if CURSOR_STATUS('global','category_cursor') >=0
--	 	begin
--			DEALLOCATE category_cursor;
--		end
--	 	if CURSOR_STATUS('global','vendor_cursor') >=0
--	 	begin
--			DEALLOCATE vendor_cursor;
--		end
	 	if CURSOR_STATUS('global','product_cursor') >=0
	 	begin
			DEALLOCATE product_cursor;
		end
		if CURSOR_STATUS('global','retailers_cursor') >=0
	 	begin
			DEALLOCATE retailers_cursor;
		end
		if CURSOR_STATUS('global','retnames_cursor') >=0
	 	begin
			DEALLOCATE retnames_cursor;
		end
		
		/* on any possible exception, a log record is generated on errors table*/
	 	INSERT INTO errors
			([TYPE], number, state, severity, line, procedure_name, message)
	    VALUES
		  ('createProduct',
		   ERROR_NUMBER(),
		   ERROR_STATE(),
		   ERROR_SEVERITY(),
		   ERROR_LINE(),
		   ERROR_PROCEDURE(),
		   ERROR_MESSAGE());
 	END CATCH
END;

/* Creates a new terminal with the received params, if already exists it does nothing
 * @author rruiz
 */
CREATE PROCEDURE dbo.createTerminal
(@id varchar(MAX),
@serial_number varchar(MAX),
@body_serial_number varchar(MAX),
@name varchar(MAX),
@city varchar(MAX),
@street varchar(MAX),
@houseNumber varchar(MAX),
@postalCode varchar(MAX),
@location varchar(MAX),
@locationType varchar(MAX),
@countryCode varchar(MAX),
@data1_flx varchar(MAX),
@data2_flx varchar(MAX), 
@data3_flx varchar(MAX),
@data4_flx varchar(MAX),
@data5_flx varchar(MAX),
@data6_flx varchar(MAX),
@rere_id int)

AS
BEGIN
	
	 		
BEGIN TRY
	-- CODIGO PARA FORZAR PRICING PARA TRABAJAR CON INVENDA
	INSERT INTO terminals (id
							,serial_number
							,body_serial_number
							,name
							,city
							,street
							,houseNumber
							,postalCode
							,location
							,locationType
							,countryCode
							,data1_flx
							,data2_flx
							,data3_flx
							,data4_flx
							,data5_flx
							,data6_flx
							,rere_id)
	VALUES (@id
			,@serial_number
			,@body_serial_number
			,@name
			,@city
			,@street
			,@houseNumber
			,@postalCode
			,@location
			,@locationType
			,@countryCode
			,@data1_flx
			,@data2_flx
			,@data3_flx
			,@data4_flx
			,@data5_flx
			,@data6_flx
			,@rere_id);
	
		
  		
	END TRY
	BEGIN CATCH
		PRINT N'createTerminal - terminal already exists :'+@serial_number;
 	END CATCH
END;

/*Procedure which selects the corresponding prod_id based on Raw Price Item Description
 *If there is no match, several records are inserted on raw_price_upc_matches
 *@author rruiz
 *@param rapr_id raw_prices table id
 *@param prod_id OUTPUT with selected  prod_id (NOT_FOUND if there is no match)
 *@param desc_id OUTPUT with selected description id (depending on source)
 *@param step permits save the method used to match the upc with the price for traceability reasons
 **/
CREATE PROCEDURE dbo.findProductForPrice(@rapr_id int, @prod_id int OUTPUT,  @desc_id int OUTPUT, @step varchar(10) OUTPUT)
AS
BEGIN
 BEGIN TRY
    DECLARE @item_desc varchar(500)
    
   	SET @step = 'START';

    PRINT N'findProductForPrice - processing rapr_id:'+CONVERT(varchar(10),@rapr_id);
   

	-- first try to match with exact product description among the
	-- gathered retailer products description
		SELECT top 1 @prod_id = pr.prod_id, @desc_id = prd.prde_id 
		FROM dbo.products_retailers_descriptions prd 
			,dbo.products_retailers pr  
			,dbo.retailer_regions rr 
			,dbo.raw_prices rp
		WHERE rtrim (ltrim(upper(prd.item_desc_retailer))) = rtrim(ltrim(upper(rp.item_desc)) )
		AND rp.rere_id = rr.rere_id 
		AND pr.reta_id = rr.reta_id 
		AND prd.prre_id = pr.prre_id 
		AND rp.rapr_id = @rapr_id;
	
		IF @@ROWCOUNT = 0 
		begin
			set @prod_id=0;
		end
		
	PRINT N'findProductForPrice - DESC-RET:'+cast(@prod_id as varchar);
	SET @step = 'DESC-RET';

	-- if no data found then try to match with exact product description of the catalog
	IF @prod_id= 0
	BEGIN
		PRINT N'findProductForPrice - no item_desc_retailer match';

		SELECT top 1 @prod_id=p.prod_id, @desc_id=p.prod_id
		FROM dbo.products p
			,dbo.raw_prices rp
		WHERE upper(p.item_desc) = upper(rp.item_desc) 
		AND rp.rapr_id = @rapr_id;
	
		IF @@ROWCOUNT = 0 
		BEGIN 
			set @prod_id=0;
		END
		
		
	    PRINT N'findProductForPrice - DESC-CAT:'+cast(@prod_id as varchar);
		SET @step = 'DESC-CAT';

		-- if no data found then try to match with similar product descriptions based on its
		-- fulltextsearch score
		IF @prod_id= 0 
		BEGIN
			
			SELECT TOP 1 @item_desc = rp.item_desc 
			FROM dbo.raw_prices rp
			WHERE rp.rapr_id = @rapr_id;
			
			PRINT N'findProductForPrice - no catalog item_desc match, using similar item_desc:'+@item_desc+ 'with products_retailers';

			/*If there is no match, let's insert possible mateches based on products retailers*/ 
			INSERT INTO raw_price_upc_matches (prod_id, item_desc, rapr_id, match_rank, [source])
			SELECT pr.prod_id , FT_TBL.item_desc_retailer, @rapr_id,KEY_TBL.RANK ,'products_retailers'
			FROM dbo.products_retailers_descriptions  AS FT_TBL,   
	        	FREETEXTTABLE(dbo.products_retailers_descriptions  , item_desc_retailer,  @item_desc)  KEY_TBL
			     ,dbo.tables t
			     ,dbo.products_retailers pr
			WHERE KEY_tbl.RANK > t.value2
			AND FT_TBL.prre_id = pr.prre_id
			AND FT_TBL.prde_id  = KEY_TBL.[KEY]  
			AND t.name = 'configurations'
			AND t.value = 'min_match_rank'
			ORDER BY KEY_TBL.RANK DESC;
			
			-- now let's select the first one with higher rank as the correct one,
			-- if there exists one with rank higher than min_match_rank
			SELECT TOP 1 @prod_id= rpum.prod_id, @desc_id = rpum.rpum_id  
			FROM raw_price_upc_matches rpum 
			WHERE rpum.rapr_id =@rapr_id
			ORDER BY match_rank DESC; 
			    
		    PRINT N'findProductForPrice - FREE-PRRE:'+ cast (@prod_id as varchar);
			SET @step = 'FREE-PRRE';

			-- if no data found then returns try to find similar desc con catalog
			IF @@ROWCOUNT = 0 
			BEGIN
					
				/*If there is no match, let's insert possible mateches based on products table (catalog)*/ 
				INSERT INTO raw_price_upc_matches (prod_id, item_desc, rapr_id, match_rank,[source])
				SELECT FT_TBL.prod_id , FT_TBL.item_desc, @rapr_id,KEY_TBL.RANK,'products' 
				FROM dbo.products AS FT_TBL,   
		        	FREETEXTTABLE(dbo.products, item_desc,  @item_desc)  KEY_TBL
				     ,dbo.tables t
				WHERE KEY_tbl.RANK > t.value2
				AND FT_TBL.prod_id = KEY_TBL.[KEY]  
				AND t.name = 'configurations'
				AND t.value = 'min_match_rank'
				ORDER BY KEY_TBL.RANK DESC;
				
				-- now let's select the first one with higher rank as the correct one,
				-- if there exists one with rank higher than min_match_rank
				SELECT TOP 1 @prod_id= rpum.prod_id , @desc_id = rpum.rpum_id  
				FROM raw_price_upc_matches rpum 
				WHERE rpum.rapr_id =@rapr_id
				ORDER BY match_rank ASC; 
				    
			    PRINT N'findProductForPrice - FREE-CAT:'+cast ( @prod_id as varchar);
				SET @step = 'FREE-CAT'
				
				
				IF @@ROWCOUNT = 0 
				BEGIN
					PRINT N'findProductForPrice - no fulltext search found';
					SET @step = 'NDF';
					SET @prod_id= 0;
					SET @desc_id=0;
				END;
			END;
		END;

	
	END;
	PRINT N'findProductForPrice - ending with upc:'+cast (@prod_id as varchar);
 END TRY
 BEGIN CATCH
 	PRINT N'findProductForPrice - Errors:'+error_message();

 	/* on any possible exception, a log record is generated on errors table*/
 	INSERT INTO errors
		([TYPE], number, state, severity, line, procedure_name, message)
    VALUES
	  ('findProductForPrice',
	   ERROR_NUMBER(),
	   ERROR_STATE(),
	   ERROR_SEVERITY(),
	   ERROR_LINE(),
	   ERROR_PROCEDURE(),
	   ERROR_MESSAGE());
 END CATCH;
END;

/* Log a message into logs table
 *@author rruiz
 **/
CREATE PROCEDURE dbo.logmsg (@type VARCHAR(MAX)
								,@procedure varchar(MAX)
								,@message varchar(MAX)
								,@intvar1 int
								,@intvar2 int
								)

AS
BEGIN

declare @intvar1txt varchar(max);
declare @intvar2txt varchar(max);


BEGIN TRY
	 		
	BEGIN TRAN LogTrn
		
		IF @intvar1 IS NOT NULL SET @intvar1txt=convert(varchar(100),@intvar1);
		IF @intvar2 IS NOT NULL SET @intvar2txt=convert(varchar(100),@intvar2);

		PRINT N'['+@type+']'+' '+@procedure + ' '+ @message+ ' var1:'+ @intvar1txt+ ' var2:'+@intvar2txt;

		-- CODIGO PARA FORZAR PRICING PARA TRABAJAR CON INVENDA
		INSERT INTO logs ([TYPE]
						   ,procedure_name
						   , message)
		VALUES (@type,
				@procedure,
				@message+' var1:'+ @intvar1txt+ ' var2:'+@intvar2txt);
	COMMIT TRAN LogTrn
	
END TRY
BEGIN CATCH
		ROLLBACK TRAN LogTrn;
	 	PRINT N'logmsg - Errors Catch:'+error_message();
	
	 	/* on any possible exception, a log record is generated on errors table*/
	 	INSERT INTO errors
			([TYPE], number, state, severity, line, procedure_name, message)
	    VALUES
		  ('logmsg',
		   ERROR_NUMBER(),
		   ERROR_STATE(),
		   ERROR_SEVERITY(),
		   ERROR_LINE(),
		   ERROR_PROCEDURE(),
		   ERROR_MESSAGE());
END CATCH
END;

/* This triggers wakes up after an insertion on raw prices
 * trying to insert the received information in Pricing App relational model
 * For this purpose, first calculates a match in the informed product information
 * with pricing.products table.
 * If there is no match, it calculates possible matches to help an operator perform
 * the manual task of associating the price with a product
 * @author rruiz
 * */
CREATE PROCEDURE  processRawPrice  (@upc_orig varchar(MAX)
									,@item_desc varchar(MAX)	
									,@quantity varchar(MAX)	
									,@measurement_unit varchar(MAX)
									,@price varchar(MAX)
									,@price_unit varchar(MAX)
									,@offer_price varchar(MAX)
									,@orig_price  varchar(MAX)
									,@currency varchar(MAX)
									,@country varchar(MAX)
									,@serial_number varchar(MAX)
									,@start_date varchar(MAX)
									,@end_date varchar(MAX)
									,@stock_alert  varchar(MAX)
									,@sponsored varchar(MAX)
									,@stars  varchar(MAX)
									,@reviews varchar(MAX)
									,@tags varchar(MAX)
									,@data1_flx varchar(MAX)
									,@data2_flx varchar(MAX)
									,@data3_flx varchar(MAX)
									,@data4_flx varchar(MAX)
									,@data5_flx varchar(MAX)
									,@data6_flx varchar(MAX)
									,@rere_id varchar(MAX))

AS
BEGIN 
 BEGIN TRY
	DECLARE @prod_id int;
	DECLARE @desc_id int;
	DECLARE	@reta_id int; 
	DECLARE @reta_name varchar(200);
	DECLARE @rapr_id int;
	DECLARE	@step varchar(10);
	DECLARE @insert_date datetime; 

			SET @insert_date=GetDate();
		 
			--get retailer info
			SELECT @reta_id=rr.reta_id,
					@reta_name=r.name 
		 	FROM retailer_regions rr 
		 	,retailers r
		 	WHERE rr.rere_id =CONVERT(int,@rere_id)
		 	AND rr.reta_id =r.reta_id ;
				 
			INSERT INTO raw_prices (item_desc
									,quantity
									,measurement_unit
									,price 
									,price_unit
									,offer_price
									,orig_price 
									,currency
									,country
									,serial_number
									,start_date
									,end_date
									,stock_alert 
									,sponsored
									,stars 
									,reviews
									,tags
									,data1_flx
									,data2_flx
									,data3_flx
									,data4_flx
									,data5_flx
									,data6_flx
									,rere_id)
					values				
									(@item_desc
									,@quantity
									,@measurement_unit
									,@price 
									,@price_unit
									,@offer_price
									,@orig_price 
									,@currency
									,@country
									,@serial_number
									,@start_date
									,@end_date
									,@stock_alert 
									,@sponsored
									,@stars 
									,@reviews
									,@tags
									,@data1_flx
									,@data2_flx
									,@data3_flx
									,@data4_flx
									,@data5_flx
									,@data6_flx
									,@rere_id);
		
		SET @rapr_id=@@identity;
	
	 	PRINT N'processRawPrice - raw price inserted rapr_id:'+CONVERT(varchar(10),@rapr_id)+' item_desc:'+@item_desc;
 
 END TRY
 
 BEGIN CATCH
 	PRINT N'processRawPrice - Error:'+error_message();
	
 	/* on any possible exception, a log record is generated on errors table*/
 	INSERT INTO errors
		([TYPE], number, state, severity, line, procedure_name, message)
    VALUES
	  ('processRawPrice',
	   ERROR_NUMBER(),
	   ERROR_STATE(),
	  ERROR_SEVERITY(),
	   ERROR_LINE(),
	   ERROR_PROCEDURE(),
	   ERROR_MESSAGE());
 END CATCH;
END;

/* The purpose of this procedure is reprocessing raw_prices that on previous trigger of this procedure
 * run did not get a upc match to let it be inserted in prices, and might be correct by hand
 * inserting a prod_id
 * */
CREATE PROCEDURE processPrices
AS 
BEGIN TRY

DECLARE @rapr_id int;
DECLARE @prod_id int;
DECLARE @new_product bit;
DECLARE @upc_orig varchar;
DECLARE @reta_id int;
DECLARE @reta_name varchar(200);
DECLARE @desc_id int;
DECLARE @step varchar;

DECLARE @item_desc varchar(MAX);
DECLARE @quantity varchar(MAX);
DECLARE @measurement_unit varchar(MAX);
DECLARE @price varchar(MAX);
DECLARE @price_unit varchar(MAX);
DECLARE @offer_price varchar(MAX);
DECLARE @orig_price  varchar(MAX);
DECLARE @currency varchar(MAX);
DECLARE @country varchar(MAX);
DECLARE @serial_number varchar(MAX);
DECLARE @start_date varchar(MAX);
DECLARE @start_date_dt datetime;
DECLARE @end_date varchar(MAX);
DECLARE @end_date_dt datetime;
DECLARE @stock_alert  varchar(MAX);
DECLARE @sponsored varchar(MAX);
DECLARE @stars  varchar(MAX);
DECLARE @reviews varchar(MAX);
DECLARE @tags varchar(MAX);
DECLARE @data1_flx varchar(MAX);
DECLARE @data2_flx varchar(MAX);
DECLARE @data3_flx varchar(MAX);
DECLARE @data4_flx varchar(MAX);
DECLARE @data5_flx varchar(MAX);
DECLARE @data6_flx varchar(MAX);
DECLARE @rere_id varchar(MAX);
DECLARE @insert_date datetime;
			     

DECLARE raw_prices_cursor CURSOR FOR   
		SELECT r.item_desc,
			r.price,
			r.offer_price,
			r.orig_price,
			r.currency,
			r.country,
			r.serial_number,
			r.start_date,
			r.end_date,
			r.stock_alert,
			r.sponsored,
			r.stars,
			r.reviews,
			r.tags,
			r.prod_id,
			r.data1_flx,
			r.data2_flx,
			r.data3_flx,
			r.data4_flx,
			r.data5_flx,
			r.data6_flx,
			r.rere_id,
			r.insert_date,
			r.upc,
			r.rapr_id
		FROM raw_prices r
		INNER JOIN retailer_regions rr ON rr.rere_id = r.rere_id 
		WHERE r.pric_id IS NULL
		OR r.reprocess_flag = 1
		ORDER BY r.insert_date asc;
  
OPEN raw_prices_cursor  
  
FETCH NEXT FROM raw_prices_cursor   
INTO @item_desc
	,@price,
	@offer_price,
	@orig_price,
	@currency,
	@country,
	@serial_number,
	@start_date,
	@end_date,
	@stock_alert,
	@sponsored,
	@stars,
	@reviews,
	@tags,
	@prod_id,
	@data1_flx,
	@data2_flx,
	@data3_flx,
	@data4_flx,
	@data5_flx,
	@data6_flx,
	@rere_id,
	@insert_date,
	@upc_orig,
	@rapr_id;
  
WHILE @@FETCH_STATUS = 0  
	BEGIN  
		-- convert start and end date from string to datetime, and set to null if it is empty
		IF @start_date = 'NaN-NaN-NaN' 
		BEGIN 
			SET @start_date = NULL;
			SET @start_date_dt = NULL; 
		END
		ELSE SET @start_date_dt = convert(datetime,@start_date,103); -- dd-mm-yyyy format IS 103
	
		IF @end_date = 'NaN-NaN-NaN' 
		BEGIN 
			SET @end_date = NULL;
			SET @end_date_dt = NULL;
		END
		ELSE SET @end_date_dt = convert(datetime,@end_date,103); -- dd-mm-yyyy format IS 103


		PRINT N'reprocessRawPrices - processing  upc:'+@upc_orig+ ' rapr_id:'+CONVERT(varchar(10),@rapr_id)+' item_desc:'+@item_desc;
    	
		--get retailer info
		SELECT @reta_id=rr.reta_id,
				@reta_name=r.name 
	 	FROM retailer_regions rr 
	 	,retailers r
	 	WHERE rr.rere_id =CONVERT(int,@rere_id)
	 	AND rr.reta_id =r.reta_id ;
	
		/*Find a match and get prod_id*/
		EXEC findProductforPrice @rapr_id,@prod_id OUTPUT, @desc_id OUTPUT, @step OUTPUT;
    
		PRINT N'reprocessRawPrices - after findProd - prod_id:'+convert(varchar(10),@prod_id);

		/* if product does not exist, create it */
		IF @prod_id = 0
			EXEC createProduct @upc_orig,
								@item_desc, 
								@item_desc,		
								@quantity,
								 @measurement_unit,
								'na',--@supercategory_name,
								'na',--@category_name,
								'na',--@subcategory_name,
								'na',--@vendor_name,
								'na',--@brand_name,
								'na',--@subbrand_name,
								@reta_name,
								@prod_id output;
							
		EXEC createTerminal
							''
							,@serial_number
							,''
							,@serial_number --- CAMBIAR ESTO ESTA MAL
							,''--@city varchar(MAX),
							,''--@street varchar(MAX),
							,''--@houseNumber varchar(MAX),
							,''--@postalCode varchar(MAX),
							,''--@location varchar(MAX),
							,''--@locationType varchar(MAX),
							,@country
							,''--@data1_flx varchar(MAX),
							,''--@data2_flx varchar(MAX), 
							,''--@data3_flx varchar(MAX),
							,''--@data4_flx varchar(MAX),
							,''--@data5_flx varchar(MAX),
							,''
							,@rere_id;--@data6_flx varc							
				
		/* If there is a match, we should insert the price in the prices table*/
--				PRINT N'reprocessRawPrices - about to insert price with prod id '+CONVERT(varchar(10),@prod_id);
		EXEC logmsg 'LOG','reprocessRawPrices - about to insert price','rapr id',@rapr_id,1;

		MERGE prices p
		USING (VALUES( @prod_id,@serial_number,@start_date_dt,@end_date_dt)) AS pr (prod_id,serial_number,start_date,end_date)		
		ON p.prod_id = pr.prod_id
		AND p.serial_number = pr.serial_number
		AND p.end_date=pr.end_date
		AND p.start_date=pr.start_date
		WHEN MATCHED THEN 
			UPDATE SET
					price=@price,
					offer_price=@offer_price,
					orig_price=@orig_price,
					currency=@currency,
					country=@country,
					serial_number=@serial_number,
					start_date=@start_date_dt,
					end_date=@end_date_dt,
					stock_alert=@stock_alert,
					sponsored=@sponsored,
					stars=@stars,
					reviews=@reviews,
					tags=@tags,
					data1_flx=@data1_flx,
					data2_flx=@data2_flx,
					data3_flx=@data3_flx,
					data4_flx=@data4_flx,
					data5_flx=@data5_flx,
					data6_flx=@data6_flx,
					rere_id=@rere_id,
					insert_date=@insert_date
		when not matched then 
			INSERT
				(price,
				offer_price,
				orig_price,
				currency,
				country,
				serial_number,
				start_date,
				end_date,
				stock_alert,
				sponsored,
				stars,
				reviews,
				tags,
				prod_id,
				data1_flx,
				data2_flx,
				data3_flx,
				data4_flx,
				data5_flx,
				data6_flx,
				rere_id,
				insert_date)	
				values(@price,
					@offer_price,
					@orig_price,
					@currency,
					@country,
					@serial_number,
					@start_date_dt,
					@end_date_dt,
					@stock_alert,
					@sponsored,
					@stars,
					@reviews,
					@tags,
					@prod_id,
					@data1_flx,
					@data2_flx,
					@data3_flx,
					@data4_flx,
					@data5_flx,
					@data6_flx,
					@rere_id,
					@insert_date);
			
			PRINT N'reprocessRawPrices - price inserted with id '+CONVERT(varchar(10),@@identity);

			/* After insert, update the raw price identifiers for traceability purposes*/
			UPDATE raw_prices  
			SET prod_id=@prod_id
				   ,pric_id=@@IDENTITY
				   ,step=@step
				   ,desc_source_id = @desc_id
		 	WHERE rapr_id = @rapr_id;
		 	
		 	PRINT N'reprocessRawPrices - prod_id updated';

		 	IF @upc_orig='' set @upc_orig='NONE';
			 	
			 
			 
		 	-- UPSERT product_retailers to feed database with retailers descriptions
			MERGE INTO products_retailers pr
			USING (VALUES( @reta_id,@prod_id,@upc_orig)) AS orig ( reta_id, prod_id,upc_orig)
			ON pr.prod_id = orig.prod_id AND pr.reta_id = orig.reta_id
			WHEN MATCHED THEN
			     UPDATE SET prod_id_retailer=orig.upc_orig
			WHEN NOT MATCHED THEN
			     INSERT(reta_id, prod_id, prod_id_retailer)
			     VALUES (orig.reta_id , orig.prod_id , orig.upc_orig);
 			
			merge products_retailers_descriptions prde
			using (select prre_id
					   from products_retailers pr
						where pr.reta_id= @reta_id
						and pr.prod_id = @prod_id) prre
			on prre.prre_id = prde.prre_id 
			and upper(rtrim(ltrim(prde.item_desc_retailer))) = upper(rtrim(ltrim(@item_desc)))
			when not matched then 
				insert (prre_id, item_desc_retailer)
				values (prre.prre_id, @item_desc);
				
			PRINT N'reprocessRawPrices - product_retailers updated';
			FETCH NEXT FROM raw_prices_cursor   
			INTO @item_desc
				,@price,
				@offer_price,
				@orig_price,
				@currency,
				@country,
				@serial_number,
				@start_date,
				@end_date,
				@stock_alert,
				@sponsored,
				@stars,
				@reviews,
				@tags,
				@prod_id,
				@data1_flx,
				@data2_flx,
				@data3_flx,
				@data4_flx,
				@data5_flx,
				@data6_flx,
				@rere_id,
				@insert_date,
				@upc_orig,
				@rapr_id;
	END   
CLOSE raw_prices_cursor;  
DEALLOCATE raw_prices_cursor;   
	
END TRY
BEGIN CATCH

	/* on any possible exception, a log record is generated on errors table*/
 	INSERT INTO errors
		([TYPE], number, state, severity, line, procedure_name, message)
    VALUES
	  ('reprocessRawPrices',
	   ERROR_NUMBER(),
	   ERROR_STATE(),
	   ERROR_SEVERITY(),
	   ERROR_LINE(),
	   ERROR_PROCEDURE(),
	   ERROR_MESSAGE() + 'rapr_id' +CONVERT(varchar(19),@rapr_id)+' item_desc:'+@item_desc);
	 
	 if CURSOR_STATUS('global','raw_prices_cursor') >=0
	 	begin
			DEALLOCATE raw_prices_cursor;
		end
END CATCH;
