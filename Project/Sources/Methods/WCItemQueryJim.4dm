//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-07T00:00:00, 17:20:45
// ----------------------------------------------------
// Method: WCItemQueryJim
// Description
// Modified: 05/07/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------




// Script Custom Keywords Search 20150506
// James W Medlen
// Modified by: Bill James (2023-01-14T06:00:00Z)
// ; ", "; ";")

vtLogic:="and"
vText:="pb-rib, pb-esr"
vText:=Replace string:C233(vText; ", "; ";")
vText:=Replace string:C233(vText; "; "; ";")
vText:=Replace string:C233(vText; ","; ";")
vText:=Replace string:C233(vText; " "; ";")
ARRAY TEXT:C222(aText1; 0)
TextToArray(vText; ->aText1; ";"; True:C214)
QUERY WITH ARRAY:C644([zzzWord:99]wordCombined:5; aText1)
ARRAY TEXT:C222(atItemNum; 0)
DISTINCT VALUES:C339([zzzWord:99]relatedAlpha:8; atItemNum)
QUERY WITH ARRAY:C644([Item:4]itemNum:1; atItemNum)
QUERY SELECTION:C341([Item:4];  & [Item:4]retired:64=False:C215; *)
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60>0; *)
//QUERY Selection([Item]; & [Item]Publish<=viEndUserSecurityLevel;*)
QUERY SELECTION:C341([Item:4])

vText:="ribmn, spdt, 15a"
vText:=Replace string:C233(vText; ", "; ";")
vText:=Replace string:C233(vText; ","; ";")
vText:=Replace string:C233(vText; "; "; ";")
vText:=Replace string:C233(vText; " "; ";")
ARRAY TEXT:C222(aText1; 0)
TextToArray(vText; ->aText1; ";"; True:C214)

// Begins with Query ***
For (x; 1; Size of array:C274(aText1))
	aText1{x}:="@"+aText1{x}+"@"
End for 

If (vtLogic="OR")
	QUERY WITH ARRAY:C644([zzzWord:99]wordCombined:5; aText1)
	ARRAY TEXT:C222(atItemNum; 0)
	DISTINCT VALUES:C339([zzzWord:99]relatedAlpha:8; atItemNum)
	QUERY SELECTION WITH ARRAY:C1050([Item:4]itemNum:1; atItemNum)
Else 
	For (x; 1; Size of array:C274(aText1))
		//aText1{x}:=aText1{x}+"@"
		QUERY:C277([zzzWord:99]; [zzzWord:99]wordCombined:5=aText1{x})
		DISTINCT VALUES:C339([zzzWord:99]relatedAlpha:8; atItemNum)
		QUERY SELECTION WITH ARRAY:C1050([Item:4]itemNum:1; atItemNum)
	End for 
End if 

QUERY SELECTION:C341([Item:4];  & [Item:4]retired:64=False:C215; *)
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60>0; *)
//QUERY Selection([Item]; & [Item]Publish<=viEndUserSecurityLevel;*)
QUERY SELECTION:C341([Item:4])

If (Records in selection:C76([Item:4])>0)
	ProcessTableOpen(Table:C252(->[Item:4]); ""; "keywords")
End if 

