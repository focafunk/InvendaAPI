SELECT serial_number "Location", start_date "Start",end_date "End", p2.item_desc "Product", 1 "Quantity",p.currency "Moneda",p.country "Country"
FROM prices p 
,products p2 
WHERE p.prod_id =p2.prod_id 
ORDER BY 1,2,3
