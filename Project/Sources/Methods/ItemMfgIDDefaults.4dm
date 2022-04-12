//%attributes = {"publishedWeb":true}
//Method: ItemMfgIDDefaults
If (False:C215)
	TCMod_606_67_03_04_Trans
End if 
//
C_TEXT:C284($thePath)
C_LONGINT:C283($myOK)
If (Is new record:C668([Item:4]))
	$myOK:=1
Else 
	CONFIRM:C162("Auto Set MfgID from defaults")
	$myOK:=OK
End if 
If ($myOK=1)
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Items_MfgID_Defaults"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=[Item:4]mfrid:53)
	If (Records in selection:C76([TallyMaster:60])=1)
		C_LONGINT:C283($i; $k; $cntFields)
		ExecuteText(0; [TallyMaster:60]script:9)
	End if 
End if 
//
UNLOAD RECORD:C212([TallyMaster:60])