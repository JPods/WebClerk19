// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 11:12:08
// ----------------------------------------------------
// Method: Form Method: SummaryText
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($obEvent)
$obEvent:=FORM Event:C1606
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Clicked:K2:4)
		
		
		
	: ($formEvent=On Load:K2:1)
		jsetBefore(->[Control:1])
		C_TEXT:C284(vText; vTextSummary)
		
		
		C_BOOLEAN:C305($inGroup)
		$inGroup:=UserInPassWordGroup("UnlockRecord")
		If ($inGroup)
			OBJECT SET ENABLED:C1123(b6; True:C214)
			OBJECT SET ENABLED:C1123(b1; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b6; False:C215)
			OBJECT SET ENABLED:C1123(b1; False:C215)
		End if 
		SET WINDOW TITLE:C213("Script Editor")
		
		
		// FONT(vText;"Courier")
		// FONT SIZE(vText;10)
		OBJECT SET ENABLED:C1123(b1; True:C214)
		OBJECT SET ENABLED:C1123(b2; True:C214)
		OBJECT SET ENABLED:C1123(b3; True:C214)
		OBJECT SET ENABLED:C1123(b4; True:C214)
		OBJECT SET ENABLED:C1123(b5; True:C214)
		J_Programing
		b18:=0
		
		
		
		ARRAY TEXT:C222(atTableNames; 0)
		STR_GetTableNameList(->atTableNames)
		
	: ($formEvent=On Outside Call:K2:11)  //(Outside call)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
		
	Else 
		
End case 