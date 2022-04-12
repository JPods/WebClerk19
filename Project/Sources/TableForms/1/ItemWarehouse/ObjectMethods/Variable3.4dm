// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/14/15, 15:03:45
// ----------------------------------------------------
// Method: [Control].ItemWarehouse.Variable3
// Description
// 
//
// Parameters
// ----------------------------------------------------
// test copied from Item Num

C_LONGINT:C283($myFormEvent)
C_BOOLEAN:C305($doQuery)
$doQuery:=False:C215
C_TEXT:C284($vsDescription; $vsShadowDescription; vsSpecialKeys; $vsKey)
$myFormEvent:=Form event code:C388
Case of 
	: ($myFormEvent=On Before Keystroke:K2:6)
		$vsKey:=Keystroke:C390
		//(->vsDescription;->vsShadowDescription;vsSpecialKeys)
		If ($vsKey#"")
			$vsShadowDescription:=Self:C308->
			$vsDescription:=$vsShadowDescription+$vsKey
			
			Self:C308->:=$vsShadowDescription
			QUERY:C277([ItemWarehouse:117]; [ItemWarehouse:117]locationid:4=$vsDescription+"@")
			//  CHOPPED  AL_UpdateFields(eItemWarehouse; 2)
		Else 
			
		End if 
		
	: (False:C215)  //: ($myFormEvent=On After Keystroke)
		$vsKey:=Keystroke:C390
		//(->vsDescription;->vsShadowDescription;vsSpecialKeys)
		If ($vsKey#"")
			$doQuery:=True:C214
			QUERY:C277([ItemWarehouse:117]; [ItemWarehouse:117]itemNum:2=Self:C308->+"@")
			//  CHOPPED  AL_UpdateFields(eItemWarehouse; 2)
		End if 
	Else 
		If (Self:C308->#"")
			QUERY:C277([ItemWarehouse:117]; [ItemWarehouse:117]locationid:4=Self:C308->+"@")
			//  CHOPPED  AL_UpdateFields(eItemWarehouse; 2)
		End if 
End case 


