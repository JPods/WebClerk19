Case of 
	: (Size of array:C274(aLiQty)=0)
		//no action    
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		//TRACE
		ARRAY LONGINT:C221(aLiLoadItemSelect; 0)
		//  CHOPPED  $error:=AL_GetSelect(eLoadList; aLiLoadItemSelect)
		C_LONGINT:C283($i; $k; $w; $found)
		$k:=Size of array:C274(aLiLoadItemSelect)
		iLoReal1:=0
		iLoReal2:=0
		If ($k>0)
			ARRAY LONGINT:C221($aShipSelTemp; 0)
			
			iLoReal3:=aLiQty{aLiLoadItemSelect{1}}
			iLoReal4:=aLiExtendedWt{aLiLoadItemSelect{1}}
			For ($i; 1; $k)
				iLoReal1:=iLoReal1+aLiQty{aLiLoadItemSelect{$i}}
				iLoReal2:=iLoReal2+aLiExtendedWt{aLiLoadItemSelect{$i}}
				//
				If (aLiLoadTagID{$i}>0)
					$w:=Find in array:C230(aPKUniqueID; aLiLoadTagID{$i})
					If ($w>0)
						INSERT IN ARRAY:C227($aShipSelTemp; 1; 1)
						$aShipSelTemp{1}:=$w
					End if 
				End if 
			End for 
			If (Size of array:C274($aShipSelTemp)>0)
				COPY ARRAY:C226($aShipSelTemp; aShipSel)
				// -- AL_SetSelect(eShipList; aShipSel)
			End if 
		End if 
	: (ALProEvt=-1)
	: (ALProEvt=-2)  //Edit menu Select All
		AL_CmdAll(->aLiRecordNum; ->aLiLoadItemSelect)
End case 
ALProEvt:=0