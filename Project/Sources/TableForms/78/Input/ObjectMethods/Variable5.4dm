QUERY:C277([Customer:2]; [Customer:2]webPage:94="0")
APPLY TO SELECTION:C70([Customer:2]; [Customer:2]webPage:94:="")
REDUCE SELECTION:C351([Customer:2]; 0)

QUERY:C277([Lead:48]; [Lead:48]webPage:47="0")
APPLY TO SELECTION:C70([Lead:48]; [Lead:48]webPage:47:="")
REDUCE SELECTION:C351([Lead:48]; 0)

QUERY:C277([Employee:19]; [Employee:19]webPage:43="0")
APPLY TO SELECTION:C70([Employee:19]; [Employee:19]webPage:43:="")
REDUCE SELECTION:C351([Employee:19]; 0)

QUERY:C277([Contact:13]; [Contact:13]webPage:47="0")
APPLY TO SELECTION:C70([Contact:13]; [Contact:13]webPage:47:="")
REDUCE SELECTION:C351([Contact:13]; 0)


QUERY:C277([Item:4]; [Item:4]webPage:58="0")
APPLY TO SELECTION:C70([Item:4]; [Item:4]webPage:58:="")
REDUCE SELECTION:C351([Item:4]; 0)

QUERY:C277([Vendor:38]; [Vendor:38]webPage:80="0")
APPLY TO SELECTION:C70([Vendor:38]; [Vendor:38]webPage:80:="")
REDUCE SELECTION:C351([Vendor:38]; 0)

//  qqqqq
If (False:C215)
	ALERT:C41("Need to test")
	HTMLCleaner
End if 