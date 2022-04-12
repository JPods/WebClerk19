// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:56:04
// ----------------------------------------------------
// Method: Object Method: ePalletList
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($error; $i; $k; $w)
Case of 
	: (Size of array:C274(aPKUniqueID22)=0)  //drop out if no arrays
		//  : (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aPalletSel; 0)
		$k:=Size of array:C274(aPalletSel)
		If ($k>0)  //Prep for monving lines
			C_LONGINT:C283($curUniqueID; $moveToUniqueID)
			$curUniqueID:=aPKUniqueID{aPalletSel{1}}
		End if 
		//
		//  CHOPPED  $error:=AL_GetSelect(ePalletList; aPalletSel)
		//
		If (iLoLongInt1=1)
			ARRAY LONGINT:C221($tempIDs; 0)
			ARRAY LONGINT:C221($tempRaySelect; 0)
			$moveToUniqueID:=aPKUniqueID22{aPalletSel{1}}
			iLoLongInt1:=0
			CONFIRM:C162("Move boxes between pallets?")
			If (OK=1)
				//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)  // ### jwm ### 20181026_1608 get current selection
				$k:=Size of array:C274(aShipSel)
				For ($i; 1; $k)  //handle selected elements
					//$theWt:=$theWt+aPKWeightExtended{aShipSel{$i}}
					If (Find in array:C230($tempIDs; aPKUniqueIDSuperior{aShipSel{$i}})<1)
						INSERT IN ARRAY:C227($tempIDs; 1; 1)
						INSERT IN ARRAY:C227($tempRaySelect; 1; 1)
						$tempIDs{1}:=aPKUniqueIDSuperior{aShipSel{$i}}
						$tempRaySelect{1}:=aShipSel{$i}
					End if 
					aPKUniqueIDSuperior{aShipSel{$i}}:=$moveToUniqueID
					PKArrayManage(-4; aShipSel{$i})  //manage pallet record
				End for 
				$k:=Size of array:C274($tempIDs)
				For ($i; 1; $k)
					PKPalletWeightReCalc($tempIDs{$i})
					$w:=Find in array:C230(aPKUniqueID22; $tempIDs{$i})
					If ($w>0)
						aPKWeightExtended22{$w}:=[LoadTag:88]weightExtended:2
					End if 
				End for 
				PKPalletWeightReCalc($moveToUniqueID)
				
				//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
				//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
				
			End if 
		End if 
		//TRACE
		
		C_LONGINT:C283($rayElement)
		//
		ARRAY LONGINT:C221(aShipSel; 0)
		iLoReal9:=0
		$k:=Size of array:C274(aPKUniqueID)
		For ($i; 1; $k)
			If (aPKUniqueIDSuperior{$i}=aPKUniqueID22{aPalletSel{1}})
				INSERT IN ARRAY:C227(aShipSel; 1; 1)
				aShipSel{1}:=$i
			End if 
		End for 
		$k:=Size of array:C274(aShipSel)
		If ($k>0)
			viVert:=aShipSel{1}
		End if 
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
		// -- AL_SetSelect(eShipList; aShipSel)
		// -- AL_SetScroll(eShipList; viVert; viHorz)
		
	: (ALProEvt=2)
		//  CHOPPED  $error:=AL_GetSelect(ePalletList; aPalletSel)
		//
		KeyModifierCurrent
		//TRACE
		If (OptKey=0)
			ARRAY LONGINT:C221(aInvoiceRecSel; 0)
			C_LONGINT:C283($rayElement)
			//
			
			//
			$k:=Size of array:C274(aPalletSel)
			iLoReal9:=0
			If ($k>0)
				//TRACE
				$packID:=aPKUniqueID22{aPalletSel{1}}
				srSO:=aPKdocumentID22{aPalletSel{1}}  //###_jwm_###
				iPalletSO:=aPKdocumentID22{aPalletSel{1}}  //###_jwm_###
				iLoText1:=aPKCustomerVendorID22{aPalletSel{1}}  //###_jwm_###
				iLoReal1:=aPKWeightPallet22{aPalletSel{1}}  //###_jwm_###
				QUERY:C277([Order:3]; [Order:3]idNum:2=aPKdocumentID22{aPalletSel{1}})  //###_jwm_###
				iLoText2:=[Order:3]company:15  //###_jwm_###
				iLoText3:=[Order:3]billToCompany:76  //###_jwm_###
				QUERY:C277([LoadTag:88]; [LoadTag:88]ideSuperior:27=$packID)
				PKArrayManage(Records in selection:C76([LoadTag:88]))
				//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
				ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)
			End if 
		End if 
		
		//
		//  : (ALProEvt=-1)//Sort Button
	: (ALProEvt=-2)  //Edit menu Select All    
		AL_CmdAll(->aoLineAction; ->aRayLines)
	: (ALProEvt=-3)  //Column Resize    
	: (ALProEvt=-4)  //Column Lock Changed
	: ((ALProEvt=-5) | (ALProEvt=-1))  //Line has been dragged
		
		
		//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
	: (ALProEvt=-6)  //User invoked Sort Editor       
End case 
ALProEvt:=0
C_LONGINT:C283($error)