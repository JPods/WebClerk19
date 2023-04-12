If (False:C215)
	//Object Method: b1  oLoMenus
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($1; $2; $itemTarget; $menuTarget)
If (Count parameters:C259=2)
	$itemTarget:=$1
	$menuTarget:=$2
Else 
	$itemTarget:=iLo20String1  //"itemFrame"
	$menuTarget:=iLo20String2  //"menuFrame"
End if 
If ($itemTarget="")
	$itemTarget:="middleframe"
End if 
If ($menuTarget="")
	$menuTarget:="rightframe"
End if 
C_LONGINT:C283($i; $k; $w)
$k:=Records in selection:C76([QQQMenu:107])
ARRAY LONGINT:C221($recNum; 0)
ARRAY LONGINT:C221($recordID; 0)
SELECTION TO ARRAY:C260([QQQMenu:107]; $recNum; [QQQMenu:107]idUnique:1; $recordID)
TRACE:C157
For ($i; 1; $k)
	QUERY:C277([QQQMenu:107]; [QQQMenu:107]ParentID:4=$recordID{$i})
	$w:=Records in selection:C76([QQQMenu:107])
	GOTO RECORD:C242([QQQMenu:107]; $recNum{$i})
	If ($w>0)
		[QQQMenu:107]Target:7:=$menuTarget
	Else 
		[QQQMenu:107]Target:7:=$itemTarget
	End if 
	SAVE RECORD:C53([QQQMenu:107])
End for 