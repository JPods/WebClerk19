//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-05-07T00:00:00, 10:32:56
// ----------------------------------------------------
// Method: WCItemQuery
// Description
// Modified: 05/07/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



// Script Custom Keywords WebScript 20150506
// James W Medlen

vtLogic:="AND"
vtLogic:=variable3

vText:="pb-rib"  // default WebCatalog

If (variable5#"")  // [RemoteUser]UniqueID
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]idNum:1=Num:C11(variable5))
	Case of 
		: ([RemoteUser:57]tableNum:9=19)  // employee
			vText:="@"
		: ([RemoteUser:57]tableNum:9=2)  // customer
			vText:=variable1
		: ([RemoteUser:57]tableNum:9=13)  // contact
			vText:=variable1
		: ([RemoteUser:57]tableNum:9=8)  // Rep
			vText:=variable1
	End case 
End if 

vText:=Variable1  // WebCatalog
vText:=Replace string:C233(vText; ", "; ";")
vText:=Replace string:C233(vText; ","; ";")
vText:=Replace string:C233(vText; "; "; ";")
vText:=Replace string:C233(vText; " "; ";")
ARRAY TEXT:C222(aText1; 0)
TextToArray(vText; ->aText1; ";"; True:C214)
QUERY:C277([Word:99]; [Word:99]tableNum:2=4)
QUERY SELECTION WITH ARRAY:C1050([Word:99]wordCombined:5; aText1)
ARRAY TEXT:C222(atItemNum; 0)
DISTINCT VALUES:C339([Word:99]relatedAlpha:8; atItemNum)
QUERY WITH ARRAY:C644([Item:4]itemNum:1; atItemNum)
QUERY SELECTION:C341([Item:4];  & [Item:4]retired:64=False:C215; *)
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60>0; *)
//QUERY Selection([Item]; & [Item]Publish<=viEndUserSecurityLevel;*)
QUERY SELECTION:C341([Item:4])


C_TEXT:C284(vURLQueryScript)
vURLQueryScript:=""
vURLQueryScript:="QUERY([Word];[Word]TableNum=4)"+"\r"
vURLQueryScript:=vURLQueryScript+"QUERY SELECTION WITH ARRAY([Word]WordCombined;aText1)"+"\r"
vURLQueryScript:=vURLQueryScript+"vURLQueryScript:=vURLQueryScript+"+"\r"
vURLQueryScript:=vURLQueryScript+"DISTINCT VALUES([Word]RelatedAlpha;atItemNum)"+"\r"
vURLQueryScript:=vURLQueryScript+"QUERY WITH ARRAY([Item]ItemNum;atItemNum)"+"\r"
vURLQueryScript:=vURLQueryScript+"QUERY SELECTION([Item]; & [Item]Retired=False;*)"+"\r"
vURLQueryScript:=vURLQueryScript+"QUERY SELECTION([Item]; & [Item]Publish>0;*)"+"\r"
vURLQueryScript:=vURLQueryScript+"QUERY Selection([Item]; & [Item]Publish<=viEndUserSecurityLevel;*)"+"\r"
vURLQueryScript:=vURLQueryScript+"QUERY SELECTION([Item])"+"\r"



vText:="ribmn, spdt, 15a"
vText:=variable2  // keywords
vText:=Replace string:C233(vText; ", "; ";")
vText:=Replace string:C233(vText; ","; ";")
vText:=Replace string:C233(vText; "; "; ";")
vText:=Replace string:C233(vText; " "; ";")
ARRAY TEXT:C222(aText1; 0)
TextToArray(vText; ->aText1; ";"; True:C214)

Case of 
	: (variable4="Begins")
		// Begins with Query
		For (x; 1; Size of array:C274(aText1))
			aText1{x}:=aText1{x}+"@"
		End for 
		
	: (variable4="Contains")
		// Contains Query
		For (x; 1; Size of array:C274(aText1))
			aText1{x}:="@"+aText1{x}+"@"
		End for 
		
	: (variable4="Literal")
		// Literal Query
		For (x; 1; Size of array:C274(aText1))
			aText1{x}:=aText1{x}
		End for 
	Else 
		// Contains Query
		For (x; 1; Size of array:C274(aText1))
			aText1{x}:="@"+aText1{x}+"@"
		End for 
End case 


If (vtLogic="OR")
	QUERY WITH ARRAY:C644([Word:99]wordCombined:5; aText1)
	ARRAY TEXT:C222(atItemNum; 0)
	DISTINCT VALUES:C339([Word:99]relatedAlpha:8; atItemNum)
	QUERY SELECTION WITH ARRAY:C1050([Item:4]itemNum:1; atItemNum)
Else 
	For (x; 1; Size of array:C274(aText1))
		//aText1{x}:=aText1{x}+"@"
		QUERY:C277([Word:99]; [Word:99]wordCombined:5=aText1{x})
		DISTINCT VALUES:C339([Word:99]relatedAlpha:8; atItemNum)
		QUERY SELECTION WITH ARRAY:C1050([Item:4]itemNum:1; atItemNum)
	End for 
End if 

QUERY SELECTION:C341([Item:4];  & [Item:4]retired:64=False:C215; *)
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60>0; *)
//QUERY Selection([Item]; & [Item]Publish<=viEndUserSecurityLevel;*)
QUERY SELECTION:C341([Item:4])

//If(Records In Selection([Item])>0)
//ProcessTableOpen(Table(->[Item]);"";"keywords")
//End If

