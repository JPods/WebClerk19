// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/16/07, 07:24:43
// ----------------------------------------------------
// Method: Form Method: Estimating
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($formEvent; $curRecNum)
$formEvent:=Form event code:C388

Case of 
	: ($formEvent=On Clicked:K2:4)
		
	: ($formEvent=On Plug in Area:K2:16)
		
	: ($formEvent=On Load:K2:1)
		
		
		C_LONGINT:C283(eEstimate)
		ARRAY LONGINT:C221(aEstimateLines; 0)
		
		ARRAY REAL:C219(iLoaReal5; 0)
		ARRAY REAL:C219(iLoaReal1; 0)
		ARRAY REAL:C219(iLoaReal2; 0)
		ARRAY REAL:C219(iLoaReal3; 0)
		
		
		
		
		ProcessPost2Build
		READ ONLY:C145([Item:4])
		
		If (Size of array:C274(<>aLsSrRec)>0)
			GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{1}})
			srItem:=[Item:4]itemNum:1
			srItemDscrp:=[Item:4]description:7
		End if 
		srItemKeyWords:="5, 50, 500, 5000, 50000"
		
	: ($formEvent=On Load Record:K2:38)
		//UNLOAD RECORD(ptCurTable->)
		READ WRITE:C146([Customer:2])
	: ($formEvent=On Unload:K2:2)
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Outside Call:K2:11)
		
	: ($formEvent=On Drop:K2:12)
		
	: (($formEvent=On Activate:K2:9) | ($formEvent=On Deactivate:K2:10))
		
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
	Else 
End case 
