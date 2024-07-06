function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [day, month, year].join('-');
}
            
function transform(mc) {
  try {
    var log = mc.getServiceLog();
    var inputroot = mc.getPayloadJSON();
	var outputmsg = {_post_rawprice_batch_req :  {_post_rawprice:[]}};
	
	for(var i_data in inputroot.result.data){
		
		log.info("procesando data "+i_data.toString());

    	for(var i_productSelectionHistory in inputroot.result.data[i_data].productSelectionHistory){
    		var productSelectionHistory = inputroot.result.data[i_data].productSelectionHistory[i_productSelectionHistory];
			
			log.info("procesando select "+productSelectionHistory.name);
			const start_date = new Date(inputroot.result.data[i_data].startedAt);
			const end_date = new Date(inputroot.result.data[i_data].endedAt);

			if (inputroot.result.data[i_data].transactionMetrics.revenueInfo.revenue !== undefined) {
 				 var revenue = inputroot.result.data[i_data].transactionMetrics.revenueInfo.revenue;
  			}else { var revenue = "" }
  			
  			if (inputroot.result.data[i_data].paymentDetails.paymentMethod !== undefined) {
 				 var paymentMethod = inputroot.result.data[i_data].paymentDetails.paymentMethod;
  			}else { var paymentMethod = "" }
  			
    		outputmsg._post_rawprice_batch_req._post_rawprice.push({
      			rere_id : "1",
    			upc : productSelectionHistory.productId,
				upc_completo:"",
    			item_desc : productSelectionHistory.name,
    			quantity : "1",
    			measurement_unit : "UN",
    			price : productSelectionHistory.price.toString(),
				price_unit : "0",
				offer_price : "0",
				orig_price : "0",
    			currency : inputroot.result.data[i_data].transactionMetrics.currencyInfo.code,
    			country : inputroot.result.data[i_data].terminalInfo.locationInfo.countryCode,
    			serial_number : inputroot.result.data[i_data].terminalInfo.serialNumber,
    			start_date : formatDate(start_date),
    			end_date : formatDate(end_date),
				stock_alert : "",
				tags : "",
				sponsored : "",
				stars : "",
				reviews : "",
				data1_flx : inputroot.result.data[i_data].transactionState,
				data2_flx : inputroot.result.data[i_data].startMethod,
				data3_flx : revenue,
				data4_flx : paymentMethod,
				data5_flx : "",
    			data6_flx : inputroot.result.data[i_data].id,
    		});
        }
	}
	
	var newPayload = JSON.stringify(outputmsg);
	log.info("json armado "+newPayload);

    mc.setProperty("newPayload", newPayload);
    return true;
  } catch (error) {
    log.info("transactionInv2Rto ERROR: " + error);
    return false;
  }
}