If (False:C215)
	TCMod_606_67_03_04_Trans
End if 
C_POINTER:C301($ptTable; $ptField)
TRACE:C157
If (([DynamicCatalog:108]tableNum:5>0) & ([DynamicCatalog:108]fieldNum:4>0) & ([DynamicCatalog:108]valueid:6#""))
	READ ONLY:C145(Table:C252([DynamicCatalog:108]tableNum:5)->)
	$ptTable:=Table:C252([DynamicCatalog:108]tableNum:5)
	$ptField:=Field:C253([DynamicCatalog:108]tableNum:5; [DynamicCatalog:108]fieldNum:4)
	$strValue:=[DynamicCatalog:108]valueid:6
	C_LONGINT:C283($theType)
	$theType:=Type:C295($ptField->)
	Case of 
		: ($theType=Is alpha field:K8:1)
			QUERY:C277($ptTable->; $ptField->=$strValue)
		: ($theType=Is longint:K8:6)
			QUERY:C277($ptTable->; $ptField->=Num:C11($strValue))
	End case 
	If (Records in selection:C76($ptTable->)=0)
		ALERT:C41("No matching records")
	Else 
		<>ptCurTable:=$ptTable
		DB_ShowCurrentSelection($ptTable; ""; 1; "")
		READ WRITE:C146($ptTable->)
	End if 
End if 