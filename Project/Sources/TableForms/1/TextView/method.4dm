// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/12/09, 12:55:23
// ----------------------------------------------------
// Method: Form Method: TextView
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
		
		
	: ($formEvent=On Load:K2:1)
		<>vTextRead:=""
		<>vTextReadField:=""
	: ($formEvent=On Load Record:K2:38)
		
	: ($formEvent=On Unload:K2:2)
		<>vTextRead:=""
		<>vTextReadField:=""
	: ($formEvent=On Clicked:K2:4)
		
	: ($formEvent=On Plug in Area:K2:16)
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Outside Call:K2:11)
		
	: ($formEvent=On Drop:K2:12)
		
	: ($formEvent=On Activate:K2:9)
		//RelatedRelease 
	: ($formEvent=On Deactivate:K2:10)
		
	: ($formEvent=On Display Detail:K2:22)
		
	: ($formEvent=On Close Detail:K2:24)
		
	: ($formEvent=On Close Box:K2:21)
		
	: ($formEvent=On Validate:K2:3)
		
	: ($formEvent=On Timer:K2:25)  //auto close windows after time passing
		
	: ($formEvent=On Resize:K2:27)  //auto close windows after time passing
	: ($formEvent=On Menu Selected:K2:14)
	: ($formEvent=On Before Keystroke:K2:6)
		
	: ($formEvent=On After Keystroke:K2:26)
		C_TEXT:C284($keystroke)
		$keystroke:=Get edited text:C655
		SET TIMER:C645(60*60*10)
End case 