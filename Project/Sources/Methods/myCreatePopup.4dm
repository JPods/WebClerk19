//%attributes = {"publishedWeb":true}
C_TEXT:C284($Response)
$Response:=Request:C163("Enter the name of the POPUP."; "PplStatus.")
QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3="<>a"+$Response)
If (Records in selection:C76([PopUp:23])=0)
	CREATE RECORD:C68([PopUp:23])
	
	[PopUp:23]approvedBy:1:="System"
	[PopUp:23]approvedOn:2:=Current date:C33
	[PopUp:23]arrayName:3:="<>a"+$Response
	[PopUp:23]listName:4:=$Response
	SAVE RECORD:C53([PopUp:23])
Else 
	ALERT:C41("A record already exists with that name.")
End if 