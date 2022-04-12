//%attributes = {"publishedWeb":true}

C_LONGINT:C283($i; $k; $w)
C_BOOLEAN:C305($AddSet)
KeyModifierCurrent
ALL RECORDS:C47([GLAccount:53])
$k:=Records in selection:C76([GLAccount:53])
GL_AcctRayInit($k)
//FIRST RECORD([GLAccount])
//For ($i;1;$k)
//aGLAll{$i}:=[GLAccount]Account
//aGLType{$i}:=[GLAccount]TypeAcct
//NEXT RECORD([GLAccount])
//End for 
SELECTION TO ARRAY:C260([GLAccount:53]account:1; aGLAll; [GLAccount:53]typeID:3; aGLType)
UNLOAD RECORD:C212([GLAccount:53])
CONFIRM:C162("Check Items for valid Accounts.")
If (OK=1)
	CREATE EMPTY SET:C140([Item:4]; "Errors")
	If (optkey=0)
		ALL RECORDS:C47([Item:4])
	Else 
		QUERY:C277([Item:4])
	End if 
	$k:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
	For ($i; 1; $k)
		$AddSet:=False:C215
		$w:=Find in array:C230(aGLAll; [Item:4]salesGlAccount:21)
		Case of 
			: ($w<1)
				$AddSet:=True:C214
			: (Not:C34((aGLType{$w}="Incom@") | (aGLType{$w}="reven@") | (aGLType{$w}="sale@")))
				$AddSet:=True:C214
		End case 
		$w:=Find in array:C230(aGLAll; [Item:4]costGLAccount:22)
		Case of 
			: ($w<1)
				$AddSet:=True:C214
			: (aGLType{$w}#"Co@")
				$AddSet:=True:C214
		End case 
		$w:=Find in array:C230(aGLAll; [Item:4]inventoryGlAccount:23)
		Case of 
			: ($w<1)
				$AddSet:=True:C214
			: (aGLType{$w}#"Current Asset")
				$AddSet:=True:C214
		End case 
		If ($AddSet)
			ADD TO SET:C119([Item:4]; "Errors")
		End if 
		NEXT RECORD:C51([Item:4])
	End for 
	UNLOAD RECORD:C212([Item:4])
	USE SET:C118("Errors")
	CLEAR SET:C117("Errors")
	If (Records in selection:C76([Item:4])>0)
		ProcessTableOpen("Item")
	Else 
		jAlertMessage(10003)
	End if 
End if 
CONFIRM:C162("Check Reps for valid Accounts.")
If (OK=1)
	CREATE EMPTY SET:C140([Rep:8]; "Errors")
	ALL RECORDS:C47([Rep:8])
	$k:=Records in selection:C76([Rep:8])
	FIRST RECORD:C50([Rep:8])
	For ($i; 1; $k)
		$AddSet:=False:C215
		$w:=Find in array:C230(aGLAll; [Rep:8]commPayGLAcct:18)
		Case of 
			: ($w<1)
				$AddSet:=True:C214
			: (aGLType{$w}#"Current Liability")
				$AddSet:=True:C214
		End case 
		If ($AddSet)
			ADD TO SET:C119([Rep:8]; "Errors")
		End if 
		NEXT RECORD:C51([Rep:8])
	End for 
	UNLOAD RECORD:C212([Rep:8])
	USE SET:C118("Errors")
	CLEAR SET:C117("Errors")
	If (Records in selection:C76([Rep:8])>0)
		ProcessTableOpen("Rep")
	Else 
		jAlertMessage(10003)
	End if 
End if 
CONFIRM:C162("Check Tax Jusidictions for valid Accounts.")
If (OK=1)
	CREATE EMPTY SET:C140([TaxJurisdiction:14]; "Errors")
	ALL RECORDS:C47([TaxJurisdiction:14])
	$k:=Records in selection:C76([TaxJurisdiction:14])
	FIRST RECORD:C50([TaxJurisdiction:14])
	For ($i; 1; $k)
		$AddSet:=False:C215
		$w:=Find in array:C230(aGLAll; [TaxJurisdiction:14]taxPayGLAcct:4)
		Case of 
			: ($w<1)
				$AddSet:=True:C214
			: (aGLType{$w}#"Current Liability")
				$AddSet:=True:C214
		End case 
		If ($AddSet)
			ADD TO SET:C119([TaxJurisdiction:14]; "Errors")
		End if 
		NEXT RECORD:C51([TaxJurisdiction:14])
	End for 
	UNLOAD RECORD:C212([TaxJurisdiction:14])
	USE SET:C118("Errors")
	CLEAR SET:C117("Errors")
	If (Records in selection:C76([TaxJurisdiction:14])>0)
		ProcessTableOpen("TaxJurisdiction")
	Else 
		jAlertMessage(10003)
	End if 
End if 
GL_AcctRayInit(0)