// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-25T00:00:00, 12:24:07
// ----------------------------------------------------
// Method: [Control].Packing.Variable16
// Description
// Modified: 11/25/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

//Script ReadScale DefaultSetup 20131108

vtName:="ReadScale_"+Current machine:C483
QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]VariableName:7=vtName)
If (Records in selection:C76([DefaultSetup:86])=0)
	CREATE RECORD:C68([DefaultSetup:86])
	
	[DefaultSetup:86]VariableName:7:=vtName
	[DefaultSetup:86]Machine:13:=Current machine:C483
	CONFIRM:C162("Does this Computer have a Shipping Scale?"; " NO "; " Yes ")
	//Default answer is No Scale
	If (OK=1)
		[DefaultSetup:86]Value:9:="0"
	Else 
		[DefaultSetup:86]Value:9:="1"
	End if 
	SAVE RECORD:C53([DefaultSetup:86])
	ALERT:C41("ReadScale DefaultSetup Created")
Else 
	//  ?????
End if 

FIRST RECORD:C50([DefaultSetup:86])
If (([DefaultSetup:86]Value:9="1@") | ([DefaultSetup:86]Value:9="Y@") | ([DefaultSetup:86]Value:9="T@"))
	jMessageWindow("ReadScale is TRUE For This Computer, change in DefaultSetups")
	<>closeScale:=1
	MODIFY RECORD:C57([DefaultSetup:86])
Else 
	jMessageWindow("ReadScale is FALSE For This Computer, change in DefaultSetups")
	<>closeScale:=0
	MODIFY RECORD:C57([DefaultSetup:86])
	
End if 

REDUCE SELECTION:C351([DefaultSetup:86]; 0)

