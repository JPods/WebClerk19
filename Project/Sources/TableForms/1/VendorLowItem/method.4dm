Case of 
		
	: (Before:C29)
		C_LONGINT:C283($error)
		jsetBefore(->[Control:1])
		SET WINDOW TITLE:C213("Suggested Reorder")
		OBJECT SET ENABLED:C1123(bNext; False:C215)
		OBJECT SET ENABLED:C1123(bPrevious; False:C215)
		NxPrLowItems
	: (Outside call:C328)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	Else 
		
		If (booDuringDo)
			If (ptCurTable#(->[Control:1]))
				jsetDuringIncl(->[Control:1])
				SET WINDOW TITLE:C213("Low Inventory Items")
			End if 
			If (doSearch>0)
				Case of 
					: (doSearch=2000)
						viItemSel:=Records in selection:C76([Item:4])
						//  --  CHOPPED  AL_UpdateArrays(eLwItmList; -2)
						ARRAY LONGINT:C221(aLwItmLines; 0)
						doSearch:=0
					: (doSearch=5)
						doQuickQuote:=1
						Srch_FullDia(->[Vendor:38])  //QUERY([Vendor])
						doQuickQuote:=0
						doSearch:=OK
					: (doSearch=1)
						QUERY:C277([Vendor:38]; [Vendor:38]zip:8=srZip+"@")
					: (doSearch=2)
						QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=srVndAlpha+"@")
					: (doSearch=3)
						QUERY:C277([Vendor:38]; [Vendor:38]company:2=srCustomer+"@")
					: (doSearch=4)
						QUERY:C277([Vendor:38]; [Vendor:38]phone:10=srPhone+"@")
					: (doSearch=6)
						QUERY:C277([Vendor:38]; [Vendor:38]attention:55=srLstName+"@")
				End case 
				If (doSearch>0)
					viVendSel:=Records in selection:C76([Vendor:38])
					Vnd_FillLwItms(viVendSel)
					doSearch:=0
					//  CHOPPED  AL_GetScroll(eLowVndList; viVert; viHorz)
					//  --  CHOPPED  AL_UpdateArrays(eLowVndList; Size of array(aVendRec))
					// -- AL_SetScroll(eLowVndList; viVert; viHorz)
					ARRAY LONGINT:C221(aLwVndLines; 0)  //clear line selection
				End if 
			End if 
			//If (Size of array(aLwVndLines)>0)
			//OBJECT SET ENABLED(;TRUE)
			//OBJECT SET ENABLED(;TRUE)
			//Else 
			//OBJECT SET ENABLED(;FALSE)
			//OBJECT SET ENABLED(;FALSE)
			//End if 
		Else 
			booDuringDo:=True:C214
		End if 
End case 