//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2)  //1 up; 2 down; 3 add -- areaList
C_POINTER:C301($3; $4)  //aLsSrRec -- aItemLines
If (Size of array:C274($3->)>0)  //aLsSrRec)>0)
	viHorz:=1
	If (Size of array:C274($4->)=0)
		viVert:=1
	Else 
		//  CHOPPED  $error:=AL_GetSelect($2; $4->)  //eItemOrd;aItemLines)
		If (Size of array:C274($4->)>0)
			viVert:=$4->{1}
		Else 
			viVert:=1
		End if 
	End if 
	Case of 
		: ($1=1)
			If (viVert>1)
				viVert:=viVert-1
			Else 
				viVert:=Size of array:C274(aLsSrRec)
			End if 
			//  --  CHOPPED  AL_UpdateArrays($2; -2)
			ARRAY LONGINT:C221($4->; 1)
			$4->{1}:=viVert
			// -- AL_SetSelect($2; $4->)
			// -- AL_SetScroll($2; viVert; viHorz)
		: ($1=2)
			If (viVert<Size of array:C274($3->))
				viVert:=viVert+1
			Else 
				viVert:=1
			End if 
			//  --  CHOPPED  AL_UpdateArrays($2; -2)
			ARRAY LONGINT:C221($4->; 1)
			$4->{1}:=viVert
			// -- AL_SetSelect($2; $4->)
			// -- AL_SetScroll($2; viVert; viHorz)
		: ($1=3)
			//  CHOPPED  $error:=AL_GetSelect($2; $4->)
			If (Size of array:C274($4->)>0)
				pPartNum:=aLsItemNum{$4->{1}}
				ListItemsLrScrn(ptCurTable; pPartNum)
			Else 
				BEEP:C151
			End if 
	End case 
	HIGHLIGHT TEXT:C210(pQtyOrd; 1; 20)
Else 
	BEEP:C151
End if 