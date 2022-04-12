$k:=Size of array:C274(aHtPage)
C_LONGINT:C283($cntMatch; $k; $i; $w)
$cntMatch:=0
viVert:=0
If ($k>0)
	C_LONGINT:C283($i; $k)
	ARRAY LONGINT:C221(aRayLines; 0)
	For ($i; 1; $k)
		If (aHtvLink{$i}#"")
			QUERY:C277([Document:100]; [Document:100]idNum:1=Num:C11(aHtvLink{$i}))
			If (Records in selection:C76([Document:100])=1)
				If (viVert=0)
					viVert:=$i
				End if 
				aHtBkGraf{$i}:=[Document:100]title:8
				aHtBkColor{$i}:=[Document:100]description:3
				aHtLink{$i}:=[Document:100]keyTags:11
				aHtPage{$i}:=[Document:100]imageName:2
				aHtaLink{$i}:=[Document:100]pathTN:5
				aHtPage{$i}:=[Document:100]imageName:2
				aHtBody{$i}:=[Document:100]event:9
				aHtReason{$i}:=String:C10([Document:100]publish:12)
				aHtStyle{$i}:=[Document:100]copyrightPath:15
				aHtvLink{$i}:=String:C10([Document:100]idNum:1)
				INSERT IN ARRAY:C227(aRayLines; 1; 1)
				aRayLines{1}:=$i
				UNLOAD RECORD:C212([Document:100])
			End if 
		End if 
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
	// -- AL_SetSelect(eHttpEdit; aRayLines)
	// -- AL_SetScroll(eHttpEdit; viVert; viHorz)
End if 