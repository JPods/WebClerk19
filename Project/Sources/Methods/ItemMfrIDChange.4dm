//%attributes = {"publishedWeb":true}
If (False:C215)
	Version_0602
	//ItemmfrIDChange("Copperfld";"CCS")
End if 
TRACE:C157
C_TEXT:C284($1; $mfgIDOld; $2; $mfgIDNew)
$tempPass:=allowAlerts_boo
If (Count parameters:C259=2)
	$mfgIDOld:=$1
	$mfgIDNew:=$2
	allowAlerts_boo:=False:C215
	QUERY:C277([Item:4]; [Item:4]mfrID:53=$mfgIDOld)
	
	
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([Item:4])
	SELECTION TO ARRAY:C260([Item:4]; aTmpLong1)
	For ($i; 1; $k)
		GOTO RECORD:C242([Item:4]; aTmpLong1{$i})
		If (Position:C15($mfgIDOld; [Item:4]itemNum:1)>0)
			srItemNum:=Replace string:C233([Item:4]itemNum:1; $mfgIDOld; $mfgIDNew)
		Else 
			srItemNum:=[Item:4]itemNum:1+"_"+$mfgIDNew
		End if 
		If (Length:C16(srItemNum)<=35)
			ItemNumChange(srItemNum)
			If ([Item:4]vendorID:45=$mfgIDOld)
				[Item:4]vendorID:45:=$mfgIDNew
			End if 
			[Item:4]mfrID:53:=$mfgIDNew
			[Item:4]mfrItemNum:39:=Replace string:C233([Item:4]itemNum:1; $mfgIDOld; $mfgIDNew)
			[Item:4]vendorItemNum:40:=Replace string:C233([Item:4]itemNum:1; $mfgIDOld; $mfgIDNew)
		Else 
			[Item:4]profile6:94:="MfgID MisMatch"
		End if 
		SAVE RECORD:C53([Item:4])
	End for 
	READ WRITE:C146([POLine:40])
	QUERY:C277([POLine:40]; [POLine:40]vendorID:24=$mfgIDOld)
	$k:=Records in selection:C76([POLine:40])
	FIRST RECORD:C50([POLine:40])
	For ($i; 1; $k)
		[POLine:40]vendorID:24:=$mfgIDNew
		SAVE RECORD:C53([POLine:40])
		NEXT RECORD:C51([POLine:40])
	End for 
End if 
allowAlerts_boo:=$tempPass

