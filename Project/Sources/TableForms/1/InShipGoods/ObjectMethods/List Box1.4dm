// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/24/13, 23:54:58
// ----------------------------------------------------
// Method: Object Method: ePoLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(ePoLines)
C_LONGINT:C283($theRec; $err)
C_BOOLEAN:C305(vModPoLn)
$doCalPo:=False:C215
Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aPoLnSelct; 0)
		//  CHOPPED  $err:=AL_GetSelect(ePoLines; aPoLnSelct)
		aPOLineAction:=aPoLnSelct{1}
		$doCalPo:=True:C214
		PoLnFillVar(aPOLineAction)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(aPoLnSelct)
		iLoReal9:=0
		iLoReal11:=0
		iLoReal12:=0
		// Modified by: williamjames (3/24/13)
		
		For ($i; 1; $k)
			iLoReal9:=iLoReal9+(aPOQtyNow{aPoLnSelct{$i}}*aPoDscntUP{aPoLnSelct{$i}})
			iLoReal11:=iLoReal11+aPOQtyNow{aPoLnSelct{$i}}
			iLoReal12:=iLoReal12+aPOQtyRcvd{aPoLnSelct{$i}}
		End for 
		iLoReal10:=vrVendorInvoiceAmount+vrVendorInvoiceFreight-iLoReal9
		GOTO OBJECT:C206(pQtyShip)
	: (ALProEvt=2)
		ARRAY LONGINT:C221(aPoLnSelct; 0)
		//  CHOPPED  $err:=AL_GetSelect(ePoLines; aPoLnSelct)
		If (Size of array:C274(aPoLnSelct)>0)
			aPOLineAction:=aPoLnSelct{1}
		Else 
			aPOLineAction:=0
		End if 
		KeyModifierCurrent
		If (OptKey=1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aPoItemNum{aPOLineAction})
			If (Records in selection:C76([Item:4])=1)
				$boStatus:=vMod  //make sure it was not reset somewhere else
				//MODIFY RECORD([Item])
				ProcessTableOpen(Table:C252(->[Item:4])*-1)
				vMod:=$boStatus
			Else 
				BEEP:C151
				BEEP:C151
			End if 
		End if 
	: (ALProEvt=-1)
		//: (ALProEvt=-2)//cmd a
		// AL_CmdAll (aWdItemRec;aWDItemLine)    
End case 
ALProEvt:=0