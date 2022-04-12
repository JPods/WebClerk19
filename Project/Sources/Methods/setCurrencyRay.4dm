//%attributes = {"publishedWeb":true}
CREATE SET:C116([QQQCurrency:61]; "Current")
ARRAY TEXT:C222(<>aExchID; 0)
QUERY:C277([QQQCurrency:61]; [QQQCurrency:61]Active:2=True:C214)
SELECTION TO ARRAY:C260([QQQCurrency:61]CurrencyID:3; <>aExchID)
INSERT IN ARRAY:C227(<>aExchID; 1; 1)
<>aExchID{1}:="Exch"
USE SET:C118("Current")
CLEAR SET:C117("Current")