C_LONGINT:C283($error; $i; $k)
Case of 
	: (Size of array:C274(aPKUniqueID)=0)  //drop out if no arrays
		//  : (ALProEvt=0)
	: (ALProEvt=1)
		//TRACE
		ARRAY LONGINT:C221(aShipSel; 0)
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		//
		ARRAY LONGINT:C221(aInvoiceRecSel; 0)
		C_LONGINT:C283($rayElement)
		//
		$k:=Size of array:C274(aShipSel)
		iLoReal9:=0
		For ($i; 1; $k)
			iLoReal9:=iLoReal9+aPKWeightExtended{aShipSel{$i}}
			$rayElement:=Find in array:C230(aInvoices; aPKInvoiceNum{$i})
			If ($rayElement>0)
				If (Find in array:C230(aInvoiceRecSel; $rayElement)<1)
					INSERT IN ARRAY:C227(aInvoiceRecSel; 1; 1)
					aInvoiceRecSel{1}:=$rayElement
				End if 
			End if 
		End for 
		If (Size of array:C274(aInvoiceRecSel)>0)
			//  --  CHOPPED  AL_UpdateArrays(eInvoiceList; -2)  //Size of array(aInvoices))
			viVert:=$rayElement
			// -- AL_SetScroll(eInvoiceList; viVert; viHorz)
			// -- AL_SetSelect(eInvoiceList; aInvoiceRecSel)
		End if 
		
		
		// Modified by: Bill James (2017-05-01T00:00:00)
		// So it is easier to display a list on a touch screen
		
		KeyModifierCurrent
		
		If (OptKey=1)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{aShipSel{1}})
			ProcessTableOpen(Table:C252(->[LoadTag:88]))
		End if 
		
	: (ALProEvt=2)
		TRACE:C157
		//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
		KeyModifierCurrent
		If (OptKey=0)
			jSetFromArray(->[LoadTag:88]; ->aPKUniqueID; ->aShipSel; ->[LoadTag:88]idNum:1)
		Else 
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{aShipSel{1}})
		End if 
		ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)
		//
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aPKUniqueID; ->aShipSel)  // ### jwm ### 20180622_1636
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		
		
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0
C_LONGINT:C283($error)