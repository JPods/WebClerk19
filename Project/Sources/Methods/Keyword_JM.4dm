//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-10-26T00:00:00, 14:22:29
// ----------------------------------------------------
// Method: Keyword_JM
// Description
// Modified: 10/26/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

variable1:=Request:C163("Enter Keywords"; "Siemens Buffalo Grove")

ARRAY TEXT:C222(aText1; 0)
vText:=variable1

TextToArray(vText; ->aText1; " "; False:C215)

vi2:=Size of array:C274(aText1)

//ALERT(String(vi2))

For (vi1; 1; vi2)
	
	vtValue:=aText1{vi1}
	vtContains:="@"+aText1{vi1}+"@"
	vtBegins:=aText1{vi1}+"@"
	QUERY:C277([Customer:2]; [Customer:2]company:2%vtValue; *)
	
	QUERY:C277([Customer:2];  | ; [Customer:2]nameFirst:73%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]nameLast:23%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]profile1:26%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]profile2:27%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]profile3:28%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]profile4:29%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]profile5:30%vtValue; *)
	
	
	QUERY:C277([Customer:2];  | ; [Customer:2]typeSale:18%vtBegins; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]repID:58%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]salesNameID:59%vtValue; *)
	
	QUERY:C277([Customer:2];  | ; [Customer:2]address1:4%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]address2:5%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]city:6%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]state:7%vtValue; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]zip:8%vtBegins; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]phone:13%vtBegins; *)
	QUERY:C277([Customer:2];  | ; [Customer:2]email:81%vtValue; *)
	QUERY:C277([Customer:2];  & ; [Customer:2]dateRetired:111=!00-00-00!; *)
	QUERY:C277([Customer:2])
	
	vtSet:="Customer"+String:C10(vi1)
	CREATE SET:C116([Customer:2]; vtSet)
End for 

vtSet1:="Customers1"
For (vi1; 2; vi2)
	vtSet2:="Customer"+String:C10(vi1)
	INTERSECTION:C121(vtSet1; vtSet2; vtSet1)
	CLEAR SET:C117(vtSet2)
End for 

USE SET:C118(vtSet1)
CLEAR SET:C117(vtSet1)

If (Records in selection:C76([Customer:2])>0)
	ProcessTableOpen(Table:C252(->[Customer:2]); ""; "TEST")
Else 
	ALERT:C41("No Customer Records Selected")
End if 
