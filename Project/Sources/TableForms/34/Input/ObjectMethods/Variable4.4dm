// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/19/07, 01:36:29
// ----------------------------------------------------
// Method: Object Method: b12
// Description
// 
//
// Parameters
// ----------------------------------------------------
Case of 
	: ([CallReport:34]tableNum:2=Table:C252(->[Customer:2]))
		If ([Customer:2]customerID:1#[CallReport:34]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1#[CallReport:34]customerID:1)
		End if 
		vText1:="QUERY([Order];[Order]customerID=[CallReport]customerID)"
		C_LONGINT:C283(vOrderProcessNum)
		C_TEXT:C284(<>prscustomerID)
		// Modified by: williamjames (101021)
		DB_ShowCurrentSelection(Table:C252(curTableNum); vText1; 1; "")
		vText1:=""
		vi2:=0
	: ([CallReport:34]tableNum:2=Table:C252(->[Contact:13]))
		If ([Contact:13]idNum:28#Num:C11([CallReport:34]customerID:1))
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([CallReport:34]customerID:1))
		End if 
		If ([Customer:2]customerID:1#[Contact:13]customerID:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
		End if 
		vText1:="QUERY([Order];[Order]customerID=[Customer]customerID)"
		C_LONGINT:C283(vOrderProcessNum)
		C_TEXT:C284(<>prscustomerID)
		vi2:=Table:C252(->[CallReport:34])
		// Modified by: williamjames (101021) jQuery
		DB_ShowCurrentSelection(->[CallReport:34]; vText1; 1; "")
		vText1:=""
		vi2:=0
	Else 
		//Alert("Not a customer or Contact")
End case 
