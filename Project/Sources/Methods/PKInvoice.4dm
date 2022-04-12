//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-04-19T00:00:00, 12:24:45
// ----------------------------------------------------
// Method: PKInvoice
// Description
// Modified: 04/19/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


//TRACE
C_LONGINT:C283($incRec; $i; $k; $cntRec; $cntPacks; $incPacks)
If (iLoInteger3=0)
	$cntPacks:=Size of array:C274(aPKUniqueID)
	ARRAY LONGINT:C221(aShipSel; 0)
	For ($incPacks; 1; $cntPacks)
		If (aPKInvoiceNum{$incPacks}=0)
			INSERT IN ARRAY:C227(aShipSel; 1; 1)
			aShipSel{1}:=$incPacks
		End if 
	End for 
	$k:=Size of array:C274(aShipSel)
Else 
	$k:=Size of array:C274(aShipSel)
End if 
If ($k>0)
	PKOrder2Invoice($k)
	
	UNLOAD RECORD:C212([Invoice:26])
Else 
	ALERT:C41("No packages to invoice.")
End if 