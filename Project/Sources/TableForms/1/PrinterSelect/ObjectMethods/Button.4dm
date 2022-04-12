// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/25/09, 10:33:27
// ----------------------------------------------------
// Method: Object Method: ePrinters
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($theRec; $error)
C_POINTER:C301($ptFile)
$doCal:=False:C215
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aPrinterLines; 0)
		//  CHOPPED  AL_GetScroll(ePrinters; viALVert; viALHorz)
		//  CHOPPED  $error:=AL_GetSelect(ePrinters; aPrinterLines)
		If (Size of array:C274(aPrinterLines)>0)
			iloText1:=iLoaText1{aPrinterLines{1}}
			iloText1:=Replace string:C233(iloText1; " "; "_")
			iloText1:=Replace string:C233(iloText1; "."; "_")
		End if 
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aPrinterLines; 0)
		//  CHOPPED  AL_GetScroll(ePrinters; viALVert; viALHorz)
		//  CHOPPED  $error:=AL_GetSelect(ePrinters; aPrinterLines)
		
		If (Size of array:C274(aPrinterLines)>0)
			[UserReport:46]printerSelected:36:=iLoaText1{aPrinterLines{1}}
			[UserReport:46]printerSelected:36:=Replace string:C233([UserReport:46]printerSelected:36; " "; "_")
			[UserReport:46]printerSelected:36:=Replace string:C233([UserReport:46]printerSelected:36; "."; "_")
		End if 
		myOK:=0
		CANCEL:C270
		//: (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All
		ARRAY LONGINT:C221(aPrinterLines; 0)
		//  CHOPPED  AL_GetScroll(ePrinters; viALVert; viALHorz)
		//  CHOPPED  $error:=AL_GetSelect(ePrinters; aPrinterLines)
		
		If (Size of array:C274(aPrinterLines)>0)
			iloText1:=iLoaText1{aPrinterLines{1}}
			iloText1:=Replace string:C233(iloText1; " "; "_")
			iloText1:=Replace string:C233(iloText1; "."; "_")
			
			
		End if 
		
		
		//: (ALProEvt=-3)//Column Resize    
		//: (ALProEvt=-4)//Column Lock Changed
		//: (ALProEvt=-5)//Line has been dragged
		//: (ALProEvt=-6)//User invoked Sort Editor   
	: ((alProEvt>2) | (alProEvt=-1) | (ALProEvt=-2) | (ALProEvt=-5) | (ALProEvt=-6))
		If (ALProEvt#-2)
			ARRAY LONGINT:C221(aPrinterLines; 0)
			doSearch:=8
		Else 
			//  CHOPPED  $error:=AL_GetSelect(ePrinters; aPrinterLines)
			doSearch:=9  //unload records
		End if 
End case 
ALProEvt:=0