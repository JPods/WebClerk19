//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-20T00:00:00, 09:48:12
// ----------------------------------------------------
// Method: CMA_ImportBefore
// Description
// Modified: 12/20/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


//Executes before the record is acted on
iLoText5:=""
myOK:=0  //do not import line until the itemNum is checked and not found
If ((aImpFields{2}="") & (aImpFields{3}="") & (aImpFields{4}=""))  //this is a line with only the itemNum in aImpFields{1}
	myOK:=0  //do not act on this line
Else 
	iLo35String1:=aImpFields{1}
	aImpFields{1}:=Replace string:C233(aImpFields{1}; " "; "")  //clean out the spaces in the itemNum
	//  variable1 is set in the call script to fill with mfrID
	vi9:=Position:C15(aImpFields{1}; variable1)  //see if the mfrID is in the ItemNum
	If (vi9<1)
		aImpFields{1}:=aImpFields{1}+"_"+variable1  //Add mfrID to ItemNum
	End if 
	iLoText5:=aImpFields{1}
	If (iLoText5="")
		myOK:=0
		ALERT:C41("Empty Item: ")
	Else 
		PUSH RECORD:C176([Item:4])
		QUERY:C277([Item:4]; [Item:4]itemNum:1=iLoText5)
		If (Records in selection:C76([Item:4])>0)
			// Alert("Existing Item: "+[Item]ItemNum)
			myOK:=0  //do not act on this line
			[Item:4]alertMessage:52:="ImportConflict"  //marks the conflicting record so they can be searched and evaluated
			SAVE RECORD:C53([Item:4])
		Else 
			myOK:=1
		End if 
		POP RECORD:C177([Item:4])
		If (myOK=1)  //save this import line
			[Item:4]itemNum:1:=iLoText5
		End if 
	End if 
	//send packet(sumDoc;iLoText5+"\r")
	// ALERT("Before: "+iLoText5)
End if 