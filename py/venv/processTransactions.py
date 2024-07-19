# Invenda Date Range Transactions processor
# This code will invoke from a given date range, a wso2 api (invenda/consume/transactions). This wso2 api
# will invoke invenda api for a single day and page. This procedure will loop first on each date, and later on each
# page of that day.
from datetime import datetime, timedelta, date
import sys
import requests 
import logging
import time

logger = logging.getLogger(__name__)
logging.basicConfig(format='%(asctime)s: %(message)s ',filename='invenda.log', level=logging.INFO)

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
try: 
    from_page_param = sys.argv[3] 
    print(f"Starting from page: {from_page_param}")

except IndexError: 
    from_page_param='1'

date1 = datetime.strptime(date_cad1, '%Y-%m-%dT%H:%M:%S')
date2 = datetime.strptime(date_cad2, '%Y-%m-%dT%H:%M:%S')
wso2_url ='http://192.168.0.176:8290' #'http://34.130.249.21:8290' 
c_retrys = 3 #amount of retrys
c_sleeptime = 25 #300

# amount of days to loop
days= (date2 - date1).days

# if a start page is informed, it will be used in the first request, it will be used in case there were problems while
# processing info and only a certain amount of pages was successfully processed
if from_page_param: 
    from_page = int(from_page_param)
else: 
    from_page = 1

# let's build the different dates among the date ranges given, and invoke all pages api for each day
date_from_str = date1.isoformat()
date_to = date1

for day in range(0,days):
    date_to = date_to + timedelta(days=1)
    date_to_str = date_to.isoformat()
    sys.stdout.write(".")
    logger.info(f"processsing from {date_from_str} to {date_to_str} from page {from_page}" )
    logger.info("======================================================================================================")

    #build wso2 api url and get first page for this date
    invenda_api_url = f"{wso2_url}/invenda/consume/transactions?dateFrom={date_from_str}.000Z&dateTo={date_to_str}.000Z&page="
    logger.info(f"requesting url {invenda_api_url}{from_page}")
    try:
        response_raw =requests.get(invenda_api_url+str(from_page))
        try: logger.info(response_raw.json()) 
        except Exception: logger.info(response_raw)        
        response_raw.raise_for_status()
    except requests.HTTPError as e:
        logger.info(f"Error {e}")

        for counter in range(1,int(c_retrys+1)):
            logger.info(f"There was an error {response_raw}, sleeping for {str(c_sleeptime)} seconds...")
            time.sleep(c_sleeptime)
            logger.info(f"Retrying page {from_page}, try # {str(counter)}")
            try:
                response_raw =requests.get(invenda_api_url+f"{from_page}")
                try: logger.info(response_raw.json()) 
                except Exception: logger.info(response_raw) 
                response_raw.raise_for_status()
                break
            except requests.HTTPError as e:
                logger.info(f"Error {e}")
                if counter == c_retrys: # last loop, raise Exception and stop processing
                    logger.info("ABORTING: Maximum retry limit reached")
                    raise Exception("ABORTING: Seem that service is down, please check the log file")

    response = response_raw.json()
    totalPages = response["totalPages"]
    logger.info(f"total pages to consume {totalPages}")

    # get from page 2 to the last page for this date, this will call Invenda api and later insert into database
    for page in range(from_page+1,int(totalPages)):
        logger.info(f"About to request page {page}")
        try:
            response_raw =requests.get(invenda_api_url+f"{page}")
            try: logger.info(response_raw.json()) 
            except Exception: logger.info(response_raw)
            response_raw.raise_for_status()
        except requests.HTTPError as e:
            logger.info(f"Error {e}")

            for counter in range(1,int(c_retrys+1)):
                logger.info(f"There was an error {response_raw}, sleeping for {str(c_sleeptime)} seconds...")
                time.sleep(c_sleeptime)
                logger.info(f"Retrying page {str(page)}, try # {str(counter)}")
                try:
                    response_raw =requests.get(invenda_api_url+f"{page}")
                    try: logger.info(response_raw.json()) 
                    except Exception: logger.info(response_raw)
                    response_raw.raise_for_status()
                    break
                except requests.HTTPError as e:
                    logger.info(f"Error {e}")
                if counter == c_retrys: # last loop, raise Exception and stop processing
                    logger.info("ABORTING: Maximum retry limit reached")
                    raise Exception("ABORTING: Seem that service is down, please check the log file")
        sys.stdout.write(".")

    #reset from page counter for next day, in case from_page parameter was informed for first day in range
    from_page = 1

    #now the next date from is current date to
    date_from_str = date_to_str

#Finishing script
today = datetime.today()
today_str= today.strftime("%Y-%m-%d %H:%M:%S")
logger.info(f"Finishing process at: {today_str}")
print(f"Finishing process at: {today_str}")






