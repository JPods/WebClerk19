//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/30/06, 10:36:39
// ----------------------------------------------------
// Method: QQItemAdd
// Description
// 
//
// Parameters
//$1; Process to be called
//$2; A boolean determining whether a prompt will popup asking
// for the quantity.  False = no popup, True = popup
// ----------------------------------------------------
C_LONGINT:C283($1)
C_BOOLEAN:C305($2; $doThis)
$doThis:=False:C215
If (Count parameters:C259>1)
	$doThis:=$2
End if 
Case of 
	: (Size of array:C274(<>aItemLines)=0)  //no lines selected
	: ($doThis=False:C215)
		//We do nothing here because a false was passed
		// this happens when the <>rQQAddQty is already set by another process
	: (Size of array:C274(<>aItemLines)=1)
		GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{1}})
		//qty set in layout
		//<>rQQAddQty:=Num(Request("Enter Quantity";String([Item]QtySaleDefault)))
	: (Size of array:C274(<>aItemLines)>1)
		
		//qty set in layout
		//<>rQQAddQty:=Num(Request("Enter Quantity";"1"))
	Else 
		OK:=0
End case 
If (OK=1)
	REDUCE SELECTION:C351([Item:4]; 0)
	<>bQQAddItems:=True:C214
	POST OUTSIDE CALL:C329($1)
End if 

