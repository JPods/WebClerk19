C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Outside Call:K2:11)
		Prs_OutsideCall
	: ($formEvent=On Load:K2:1)
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		//
		PKALDefine(eShipList; "Arial"; 10; 2)
		//   
		If (Size of array:C274(aPKUniqueID)>0)
			ARRAY LONGINT:C221(aShipSel; 1)
			aShipSel{1}:=1
			PKArrayManage(-8; 1)
		Else 
			PKArrayManage(-9)
			$doEnter:=False:C215
		End if 
		HIGHLIGHT TEXT:C210(iLo40String1; 1; 40)
	: ($formEvent=On Plug in Area:K2:16)
		LoadTagsAreaList
		
	Else 
		If ((doSearch>0) & (Size of array:C274(aShipSel)>0))
			doSearch:=0
			viVert:=aShipSel{1}
			//  CHOPPED  AL_GetScroll(eShipList; viVert; viHorz)
			//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
			// -- AL_SetSelect(eShipList; aShipSel)
			// -- AL_SetScroll(eShipList; viVert; viHorz)
		End if 
End case 