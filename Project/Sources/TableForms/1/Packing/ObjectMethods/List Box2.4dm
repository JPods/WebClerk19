C_LONGINT:C283($error; $i; $k)
Case of 
	: (Size of array:C274(aInvoices)=0)  //drop out if no arrays
		//  : (ALProEvt=0)
	: (ALProEvt=1)
		//TRACE
		ARRAY LONGINT:C221(aInvoiceRecSel; 0)
		//  CHOPPED  $error:=AL_GetSelect(eInvoiceList; aInvoiceRecSel)
		
		
	: (ALProEvt=2)
		// TRACE
		//  CHOPPED  $error:=AL_GetSelect(eInvoiceList; aInvoiceRecSel)
		$k:=Size of array:C274(aInvoiceRecSel)
		If ($k>0)
			$k:=1
		End if 
		
		KeyModifierCurrent
		If (OptKey=1)
			jSetFromArray(->[Invoice:26]; ->aInvoices; ->aInvoiceRecSel; ->[Invoice:26]idNum:2)
		Else 
			QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=aInvoices{aInvoiceRecSel{1}})
		End if 
		curTableNum:=Table:C252(->[Invoice:26])
		ProcessTableOpen
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aInvoices; ->aInvoiceRecSel)  // ### jwm ### 20180622_1636
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		
		
		//  --  CHOPPED  AL_UpdateArrays(eInvoiceList; -2)
		
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0
C_LONGINT:C283($error)