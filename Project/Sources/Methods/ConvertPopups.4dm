//%attributes = {"publishedWeb":true}
C_TEXT:C284($1; $2; $3; $theList; $4; $5; $6; $7)
$theList:=Substring:C12($1; 4)
QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3=$1)
If (Records in selection:C76([PopUp:23])=0)
	CREATE RECORD:C68([PopUp:23])
	
	[PopUp:23]arrayName:3:=$1
	[PopUp:23]listName:4:=$theList
	[PopUp:23]alternates:6:=True:C214
	[PopUp:23]approvedOn:2:=Current date:C33
	[PopUp:23]approvedBy:1:=Current user:C182
	For ($i; 2; Count parameters:C259)
		CREATE RECORD:C68([PopupChoice:134])
		//notation for a passed parameter, refered by number
		[PopupChoice:134]arrayName:1:=[PopUp:23]arrayName:3
		[PopupChoice:134]choice:3:=${$i}  //notation for a passed parameter, refered by number
		SAVE RECORD:C53([PopupChoice:134])
	End for 
	SAVE RECORD:C53([PopUp:23])
End if 