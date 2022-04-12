
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-27T00:00:00, 00:00:57
// ----------------------------------------------------
// Method: [Customer].Input1.Button4
// Description
// Modified: 06/27/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------
iLoText2:=""
iLoText3:=""
If ([WorkOrder:66]customerid:28="")
	ALERT:C41("There is no customer assigned to this WorkOrder.")
Else 
	If ([Customer:2]customerID:1#[WorkOrder:66]customerid:28)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerid:28)
	End if 
End if 



MQVariables  // translate variables
C_TEXT:C284($working)
iLoText2:=TagsToText(iLoText1)  // convert tags to values