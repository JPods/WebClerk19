//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 10:31:24
// ----------------------------------------------------
// Method: WordsWebByCustomerProfile
// Description
// Modified: 12/16/15
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

//vText:=Variable1  // WebCatalog
vText:=Replace string:C233(vText; ", "; ";")
vText:=Replace string:C233(vText; ","; ";")
vText:=Replace string:C233(vText; "; "; ";")
vText:=Replace string:C233(vText; " "; ";")
ARRAY TEXT:C222(aText1; 0)
TextToArray(vText; ->aText1; ";"; True:C214)
QUERY:C277([Word:99]; [Word:99]tableNum:2=4)
If ([RemoteUser:57]tableNum:9#19)
	QUERY SELECTION WITH ARRAY:C1050([Word:99]wordCombined:5; aText1)
End if 
ARRAY TEXT:C222(atItemNum; 0)
DISTINCT VALUES:C339([Word:99]relatedAlpha:8; atItemNum)
QUERY WITH ARRAY:C644([Item:4]itemNum:1; atItemNum)
QUERY SELECTION:C341([Item:4];  & [Item:4]retired:64=False:C215; *)
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60>0; *)
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60<=viSecureLvl; *)
QUERY SELECTION:C341([Item:4])

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
		// // Begins with Query
		For (x; 1; Size of array:C274(aText1))
			aText1{x}:=aText1{x}+"@"
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
QUERY SELECTION:C341([Item:4];  & [Item:4]publish:60<=viSecureLvl; *)
QUERY SELECTION:C341([Item:4])

DISTINCT VALUES:C339([Item:4]itemNum:1; atItemNum)

// ARRAY LONGINT(aRecNums;0)
// BLOB TO VARIABLE([EventLog]RecordArray;aRecNums)
// CREATE SELECTION FROM ARRAY ([Item]ItemNum; aRecNums
// ARRAY LONGINT(aRecNums;0)

C_TEXT:C284(vURLQueryScript)
vURLQueryScript:=""
vURLQueryScript:=vURLQueryScript+"ARRAY LONGINT(aRecNums;0)"+"\r"
vURLQueryScript:=vURLQueryScript+"BLOB TO VARIABLE([EventLog]RecordArray;aRecNums)"+"\r"
vURLQueryScript:=vURLQueryScript+"CREATE SELECTION FROM ARRAY ([Item]; aRecNums)"+"\r"
vURLQueryScript:=vURLQueryScript+"ARRAY LONGINT(aRecNums;0)"+"\r"

vURLSortScript:="Order By([Item];[Item]ItemNum;>)"

[EventLog:75]tableName:39:="Item"
[EventLog:75]lastQueryScript:31:=vURLQueryScript
[EventLog:75]wccEmail:33:=vURLSortScript
If ([EventLog:75]idNum:5#0)
	SAVE RECORD:C53([EventLog:75])
End if 
ARRAY LONGINT:C221(aRecNums; 0)
SELECTION TO ARRAY:C260([Item:4]; aRecNums)
VARIABLE TO BLOB:C532(aRecNums; [EventLog:75]recordArray:43)
[EventLog:75]tableNumArray:44:=Table:C252(->[Item:4])
If ([EventLog:75]idNum:5#0)
	SAVE RECORD:C53([EventLog:75])
End if 

//If(Records In Selection([Item])>0)
//ProcessTableOpen(Table(->[Item]);"";"keywords")
//End If

