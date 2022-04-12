Case of 
	: (Before:C29)
		//
		C_LONGINT:C283($i; $k; $error)
		LT_ALDefineLoadItems
		vi5:=1
		$k:=Size of array:C274(aLiTagGroup)
		For ($i; 1; $k)
			If (vi5<=aLiTagGroup{$i})
				vi5:=aLiTagGroup{$i}+1
			End if 
		End for 
		//    
		C_LONGINT:C283($i; $k; $error)
		// Superseded
		Ship_FillArray(0)
		//
		// -- $error:=AL_SetArraysNam(eShipList; 1; 11; "aLongInt1"; "aReal1"; "a20Str1"; "a20Str2"; "a20Str3"; "a20Str4"; "aReal3"; "aReal2"; "atrackID"; "aTrackTagID"; "aTagContents")
		// -- AL_SetHeaders(eShipList; 1; 11; "Weight"; "Charges"; "trk"; "o/s"; "ins"; "ctg"; "Declared Value"; "Other Charges"; "trackID"; "TagID"; "Contents")
		// -- AL_SetWidths(eShipList; 1; 11; 55; 73; 21; 21; 21; 21; 73; 52; 110; 64; 300)
		//
		// -- AL_SetRowOpts(eShipList; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eShipList; 1; 0; 1; 0; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eShipList; 0; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eShipList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eShipList; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort (eShipList;3;1)    
		// -- AL_SetFormat(eShipList; 1; ""; 3; 0)
		// -- AL_SetFormat(eShipList; 2; ""; 3; 2)
		// -- AL_SetFormat(eShipList; 6; ""; 3; 0)
		//
		// -- AL_SetHdrStyle(eShipList; 0; "Geneva"; 9; 0)
		// -- AL_SetStyle(eShipList; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eShipList; "Gray"; "Gray"; 0; ""; ""; 0)
		//
		// -- AL_SetScroll(eShipList; 1; 1)
		// -- AL_SetSelect(eShipList; aShipSel)
		If (Size of array:C274(aShipSel)>0)
			vi1:=aLongInt1{aShipSel{1}}
			vR1:=aReal1{aShipSel{1}}
			b1:=Num:C11(a20Str1{aShipSel{1}}="x")
			b2:=Num:C11(a20Str2{aShipSel{1}}="x")
			b3:=Num:C11(a20Str3{aShipSel{1}}="x")
			b4:=Num:C11(a20Str4{aShipSel{1}}="x")
			vR3:=aReal3{aShipSel{1}}
			vR2:=aReal2{aShipSel{1}}
			v1:=atrackID{aShipSel{1}}
			$doEnter:=True:C214
		Else 
			vi1:=0
			vi2:=0
			vR1:=0
			vR2:=0
			b1:=0
			b2:=0
			b3:=0
			b4:=0
			v1:=""
			$doEnter:=False:C215
		End if 
		//SET ENTERABLE(vi1;$doEnter)
		//SET ENTERABLE(vR1;$doEnter)
		//SET ENTERABLE(vR2;$doEnter)
		//SET ENTERABLE(vR3;$doEnter)
		//SET ENTERABLE(v1;$doEnter)    
		If ([Invoice:26]dateLinked:31#!00-00-00!)
			OBJECT SET ENABLED:C1123(bAcceptB; False:C215)
		End if 
	: (Outside call:C328)
		Prs_OutsideCall
		
	Else 
		If (doSearch>0)
			Case of 
				: (doSearch=6)
					$k:=Size of array:C274(aShipSel)
					// For ($i;1;$k)
					a20Str1{aShipSel{1}}:="x"*b1
					
					aLongInt1{aShipSel{1}}:=vi1
					aReal1{aShipSel{1}}:=vR1
					a20Str1{aShipSel{1}}:="x"*b1
					a20Str2{aShipSel{1}}:="x"*b2
					a20Str3{aShipSel{1}}:="x"*b3
					a20Str4{aShipSel{1}}:="x"*b4
					aReal3{aShipSel{1}}:=vR3
					aReal2{aShipSel{1}}:=vR2
					atrackID{aShipSel{1}}:=v1
					//End for 
				: (doSearch=2)
					vi1:=aLongInt1{aShipSel{1}}
					vR1:=aReal1{aShipSel{1}}
					b1:=Num:C11(a20Str1{aShipSel{1}}#"")
					b2:=Num:C11(a20Str2{aShipSel{1}}#"")
					b3:=Num:C11(a20Str3{aShipSel{1}}#"")
					b4:=Num:C11(a20Str4{aShipSel{1}}#"")
					vR3:=aReal3{aShipSel{1}}
					vR2:=aReal2{aShipSel{1}}
					v1:=atrackID{aShipSel{1}}
			End case 
			//  CHOPPED  AL_GetScroll(eShipList; viVert; viHorz)
			//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
			If (Size of array:C274(aShipSel)>0)
				viVert:=aShipSel{1}
				// -- AL_SetSelect(eShipList; aShipSel)
				// -- AL_SetScroll(eShipList; viVert; viHorz)
				$doEnter:=True:C214
			Else 
				$doEnter:=False:C215
			End if 
			//SET ENTERABLE(vi1;$doEnter)
			//SET ENTERABLE(vR1;$doEnter)
			//SET ENTERABLE(vR2;$doEnter)
			//SET ENTERABLE(vR3;$doEnter)
			//SET ENTERABLE(v1;$doEnter)
			doSearch:=0
		End if 
End case 