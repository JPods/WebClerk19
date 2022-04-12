Key_SetEnter
//Itm_ListArrows (0;eShipList;->aPKUniqueID;->aShipSel)//down; area; available; selected
C_LONGINT:C283($dataSize)
$dataSize:=Size of array:C274(aPKUniqueID)
//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
viVert:=1
viHorz:=1
Case of 
	: ($dataSize=0)
		//do nothing
	: ($dataSize=1)
		ARRAY LONGINT:C221(aShipSel; 1)
		aShipSel{1}:=1
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
		// -- AL_SetSelect(eShipList; aShipSel)
		// -- AL_SetScroll(eShipList; viVert; viHorz)
		
	Else 
		Case of 
			: (aShipSel{1}<$dataSize)
				ARRAY LONGINT:C221(aShipSel; 1)
				aShipSel{1}:=aShipSel{1}+1
				viVert:=aShipSel{1}
				//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
				// -- AL_SetSelect(eShipList; aShipSel)
				// -- AL_SetScroll(eShipList; viVert; viHorz)
				
				//
			: (aShipSel{1}=$dataSize)
				ARRAY LONGINT:C221(aShipSel; 1)
				aShipSel{1}:=1
				viVert:=aShipSel{1}
				//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
				// -- AL_SetSelect(eShipList; aShipSel)
				// -- AL_SetScroll(eShipList; viVert; viHorz)
				//
				
			: (aShipSel{1}=1)
				ARRAY LONGINT:C221(aShipSel; 1)
				aShipSel{1}:=$dataSize
				viVert:=aShipSel{1}
				//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
				// -- AL_SetSelect(eShipList; aShipSel)
				// -- AL_SetScroll(eShipList; viVert; viHorz)
			Else 
				
				
		End case 
End case 
If (Size of array:C274(aShipSel)>0)
	PKArrayManage(-8; aShipSel{1})
End if 
HIGHLIGHT TEXT:C210(iLo40String1; 1; 40)