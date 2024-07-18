# Invenda Date Range Transactions processor
# This code will invoke from a given date range, a wso2 api (invenda/consume/transactions). This wso2 api
# will invoke invenda api for a single day and page. This procedure will loop first on each date, and later on each
# page of that day.
from datetime import datetime, timedelta, date
import sys
import requests 
import logging

logger = logging.getLogger(__name__)
logging.basicConfig(filename='invenda.log', level=logging.INFO)
today = datetime.today()
today_str= today.strftime("%Y-%m-%d %H:%M:%S")


logger.info("Importing Transactions from Invenda API")
logger.info(f"Requested from and to dates {sys.argv[1:]}")
logger.info(f"Starting process at: {today_str}")
logger.info("____________________________________________________________________________________________________")

print("Importing Transactions from Invenda API")
print(f"Requested from and to dates {sys.argv[1:]}")
print(f"Starting process at: {today_str}")


#Calculate days and number of days between dates
date_cad1 = sys.argv[1]
date_cad2 = sys.argv[2]
date1 = datetime.strptime(date_cad1, '%Y-%m-%dT%H:%M:%S')
date2 = datetime.strptime(date_cad2, '%Y-%m-%dT%H:%M:%S')
wso2_url ='http://34.130.249.21:8290' #'http://192.168.0.176:8290'

# amount of days to loop
days= (date2 - date1).days

# let's build the different dates among the date ranges given, and invoke all pages api for each day
date_from_str = date1.isoformat()
date_to = date1

for day in range(0,days):
    date_to = date_to + timedelta(days=1)
    date_to_str = date_to.isoformat()

    logger.info(f"processsing from {date_from_str} to {date_to_str}")
    logger.info("======================================================================================================")
    #build wso2 api url and get first page for this date
    invenda_api_url = f"{wso2_url}/invenda/consume/transactions?dateFrom={date_from_str}.000Z&dateTo={date_to_str}.000Z&page="
    logger.info(f"requesting url {invenda_api_url}1")
    response =requests.get(invenda_api_url+f"1").json()
    logger.info(response)
 
    totalPages = response["totalPages"]
    logger.info(f"total pages to consume {totalPages}")

    # get from page 2 to the last page for this date, this will call Invenda api and later insert into database
    for page in range(2,int(totalPages)):
        logger.info(f"About to request page {page}")
        response =requests.get(invenda_api_url+f"{page}").json()
        logger.debug(response)

    #now the next date from is current date to
    date_from_str = date_to_str

#Finishing script
today = datetime.today()
today_str= today.strftime("%Y-%m-%d %H:%M:%S")
logger.info(f"Finishing process at: {today_str}")
print(f"Finishing process at: {today_str}")






