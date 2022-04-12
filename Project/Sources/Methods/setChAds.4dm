//%attributes = {"publishedWeb":true}
CREATE SET:C116([QQQAdSource:35]; "Current")
READ ONLY:C145([QQQAdSource:35])
QUERY:C277([QQQAdSource:35]; [QQQAdSource:35]Active:7=True:C214)
SELECTION TO ARRAY:C260([QQQAdSource:35]MarketEffort:2; <>aAdSources)  //;[Marketing]AdCode;aAdCodes)
SORT ARRAY:C229(<>aAdSources; >)
INSERT IN ARRAY:C227(<>aAdSources; 1; 1)
<>aAdSources{1}:="Sources"
<>aAdSources:=1
READ WRITE:C146([QQQAdSource:35])
USE SET:C118("Current")
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([QQQAdSource:35])