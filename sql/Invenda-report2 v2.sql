SELECT :start_date "Start"
	,:end_date "End"
	,datediff(DAY,CONVERT(datetime,:start_date),convert(datetime,:end_date)) Days
	,t.serial_number Location
	,(SELECT TOP 1 p.currency
	  FROM prices p
	  WHERE p.serial_number = t.serial_number) Currency
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
		AND p.serial_number = t.serial_number) a) "Total revenue"
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data1_flx = 'Overpay'
		AND p.serial_number = t.serial_number) a) "Revenue from overpay transactions"
	,0 "Revenue from products" -- it IS NOT the same AS total revenue?
	,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cash'
		AND p.serial_number = t.serial_number) a) "Revenue from cash"
		,(SELECT sum(CONVERT(float,a.rev)) revenue
	from(
		SELECT CASE when data3_flx IS NULL OR data3_flx ='' THEN '0.0' ELSE data3_flx END rev
		FROM prices p 
		WHERE p.start_date >= CONVERT(datetime,:start_date) 
		AND p.end_date <=CONVERT(datetime,:end_date)
		AND p.data4_flx = 'Cashless'
		AND p.serial_number = t.serial_number) a) "Revenue from card"
FROM terminals t
WHERE t.serial_number in 
            (select p.serial_number
             from prices p 
             where p.start_date >= CONVERT(datetime,:start_date) 
	     AND p.end_date <=CONVERT(datetime,:end_date))
ORDER BY t.serial_number ASC



