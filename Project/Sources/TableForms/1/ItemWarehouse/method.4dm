// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/09/12, 17:31:14
// ----------------------------------------------------
// Method: Form Method: ItemWarehouse
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		
		
	: ($formEvent=On Plug in Area:K2:16)
		
	: ($formEvent=On Load:K2:1)
		//QUERY([ItemWarehouse];[ItemWarehouse]ItemNum=srItemNum)
		//REDUCE SELECTION([ItemWarehouse];0)
		C_BOOLEAN:C305($doChange)
		$doChange:=UserInPassWordGroup("Inventory")
		If ($doChange)
			READ WRITE:C146([ItemWarehouse:117])
		Else 
			READ ONLY:C145([ItemWarehouse:117])
		End if 
		C_LONGINT:C283(eItemWarehouse)
		
		ALL RECORDS:C47([ItemWarehouse:117])
		//If (Records in selection([ItemWarehouse])<100)
		//FIRST RECORD([ItemWarehouse])
		//Else 
		//REDUCE SELECTION([ItemWarehouse];0)
		//End if 
		//  CHOPPED  AL_UpdateFields(eItemWarehouse; 2)
		
	: ($formEvent=On Load Record:K2:38)
		
		
	: ($formEvent=On Unload:K2:2)
		
		READ WRITE:C146([ItemWarehouse:117])
		
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Outside Call:K2:11)
		
		//  CHOPPED  AL_UpdateFields(eItemWarehouse; 2)
		
	: ($formEvent=On Drop:K2:12)
		
	: ($formEvent=On Activate:K2:9)
		
		
		
End case 