SELECT :start_date "Start"
	,:end_date "End"
	,datediff(DAY,CONVERT(datetime,:start_date),convert(datetime,:end_date)) Days
	,t.serial_number Location
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		) "NumberOfStartedTransactions"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data1_flx = 'Successful'
		) "NumberOfSuccessfulTransactions"
	,(SELECT AVG(datediff(DAY,CONVERT(datetime,p.start_date),convert(datetime,p.end_date)) ) ave
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		) "AverageSalesTransactionLength"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data1_flx = 'Cancelled'
		) "NumberOfCancelledTransactions"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data1_flx = 'Incomplete'
		) "NumberOfIncompleteTransactions"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data1_flx = 'PartiallySuccessful'
		) "NumberOfPartiallySuccessfulTransactions"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data1_flx = 'Unsuccessful'
		) "NumberOfUnsuccessfulTransactions"
	,0 NumberOfTransactionsWithMultipleProducts --NO idea how TO calculate it
	,(SELECT count(1)  
	FROM (
			SELECT distinct(prod_id) 
			FROM prices p 
			WHERE p.start_date >= CONVERT(datetime,:start_date) 
			AND p.end_date <=CONVERT(datetime,:end_date)
			AND p.serial_number = t.serial_number 
			) a) TotalProductsSold	
	,(SELECT count(1)
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 		
		) "TotalNumberOfProductSelections"
	,(SELECT count(1)
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 		
		) "TotalNumberOfProductSelections"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data2_flx = 'ByScreenTouched'
		) "ProductsSelectedViaTouchScreen"
	,(SELECT count(1) 
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND data2_flx = 'ByKeypad'
		) "ProductsSelectedViaKeypad"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='CHF') a) "Total revenue CHF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='RUB') a) "Total revenue RUB"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='USD') a) "Total revenue USD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='AED') a) "Total revenue AED"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='EUR') a) "Total revenue EUR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='GBP') a) "Total revenue GBP"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='RSD') a) "Total revenue RSD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='CAD') a) "Total revenue CAD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='PLN') a) "Total revenue PLN"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='SEK') a) "Total revenue SEK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='DKK') a) "Total revenue DKK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='NOK') a) "Total revenue NOK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='SAR') a) "Total revenue SAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='AUD') a) "Total revenue AUD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='RON') a) "Total revenue RON"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='ZAR') a) "Total revenue ZAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='HUF') a) "Total revenue HUF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.serial_number = t.serial_number 
		AND p.currency='MXN') a) "Total revenue MXN"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='CHF') a) "Revenue from overpay transactions CHF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='RUB') a) "Revenue from overpay transactions RUB"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='USD') a) "Revenue from overpay transactions USD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='AED') a) "Revenue from overpay transactions AED"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='EUR') a) "Revenue from overpay transactions EUR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='GBP') a) "Revenue from overpay transactions GBP"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='RSD') a) "Revenue from overpay transactions RSD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='CAD') a) "Revenue from overpay transactions CAD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='PLN') a) "Revenue from overpay transactions PLN"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='SEK') a) "Revenue from overpay transactions SEK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='DKK') a) "Revenue from overpay transactions DKK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='NOK') a) "Revenue from overpay transactions NOK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='SAR') a) "Revenue from overpay transactions SAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='AUD') a) "Revenue from overpay transactions AUD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='RON') a) "Revenue from overpay transactions RON"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='ZAR') a) "Revenue from overpay transactions ZAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='HUF') a) "Revenue from overpay transactions HUF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number 
		AND p.currency='MXN') a) "Revenue from overpay transactions MXN"
	,0 "Revenue from products" -- it IS NOT the same AS total revenue?
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='CHF') a) "Revenue from cash CHF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='RUB') a) "Revenue from cash RUB"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='USD') a) "Revenue from cash USD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='AED') a) "Revenue from cash AED"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='EUR') a) "Revenue from cash EUR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='GBP') a) "Revenue from cash GBP"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='RSD') a) "Revenue from cash RSD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='CAD') a) "Revenue from cash CAD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='PLN') a) "Revenue from cash PLN"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='SEK') a) "Revenue from cash SEK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='DKK') a) "Revenue from cash DKK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='NOK') a) "Revenue from cash NOK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='SAR') a) "Revenue from cash SAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='AUD') a) "Revenue from cash AUD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='RON') a) "Revenue from cash RON"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='ZAR') a) "Revenue from cash ZAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='HUF') a) "Revenue from cash HUF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number 
		AND p.currency='MXN') a) "Revenue from cash MXN"
		,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='CHF') a) "Revenue from card CHF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='RUB') a) "Revenue from card RUB"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='USD') a) "Revenue from card USD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='AED') a) "Revenue from card AED"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='EUR') a) "Revenue from card  EUR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='GBP') a) "Revenue from card GBP"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='RSD') a) "Revenue from card RSD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='CAD') a) "Revenue from card CAD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='PLN') a) "Revenue from card PLN"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='SEK') a) "Revenue from card SEK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='DKK') a) "Revenue from card DKK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='NOK') a) "Revenue from card NOK"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='SAR') a) "Revenue from card SAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='AUD') a) "Revenue from card AUD"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='RON') a) "Revenue from card RON"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='ZAR') a) "Revenue from card ZAR"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='HUF') a) "Revenue from card HUF"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
		from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number 
		AND p.currency='MXN') a) "Revenue from card MXN"
FROM terminals t
,prices p 
WHERE p.serial_number = t.serial_number 
AND p.start_date >= CONVERT(datetime,:start_date) 
AND p.end_date <=CONVERT(datetime,:end_date)
ORDER BY t.serial_number ASC



SELECT distinct(currency) FROM prices


WHERE p


