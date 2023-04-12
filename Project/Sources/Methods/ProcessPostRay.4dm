//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/04/06, 14:41:24
// ----------------------------------------------------
// Method: ProcessPostRay
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($w)
If (iLoaText1=1)
	//POST OUTSIDE CALL(Storage.process.processList)
	ProcessPost2Build
Else 
	KeyModifierCurrent
	$w:=Find in array:C230(<>aPrsName; iLoaText1{iLoaText1})
	Case of 
		: (Size of array:C274(<>aLsSrRec)=0)
			If (OptKey=1)
				BRING TO FRONT:C326(<>aPrsNum{$w})
			Else 
				ALERT:C41("No items selected")
			End if 
		: ($w<1)
			ALERT:C41("Process is expired")
			ProcessPost2Build
			//: (<>aPrsName{<>aPrsName}="QuickQuote@")
			//ALERT("Cannot target the same process")
		: ($w>0)
			If (OptKey=1)
				BRING TO FRONT:C326(<>aPrsNum{$w})
			Else 
				QQItemAdd(<>aPrsNum{$w})
			End if 
		: (<>aPrsName{<>aPrsName}="Main")
			If ((Size of array:C274(<>aItemLines)>0) & (Size of array:C274(<>aLsSrRec)>0))
				$w:=Find in array:C230(<>aPrsName; "Sales Dept")
				QQItemAdd(<>aPrsNum{$w})
			End if 
		Else 
			If ((Size of array:C274(<>aItemLines)>0) & (Size of array:C274(<>aLsSrRec)>0))
				$w:=Find in array:C230(<>aPrsName; <>aPrsName{<>aPrsName})
				QQItemAdd(<>aPrsNum{$w})
			End if 
	End case 
	
End if 