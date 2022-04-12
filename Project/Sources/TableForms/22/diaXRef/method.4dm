C_TEXT:C284(vRefPartNum)
C_LONGINT:C283(intTemp; $error)
Case of 
	: (Before:C29)
		If (ptCurTable=(->[ItemXRef:22]))
			OBJECT SET ENABLED:C1123(b4; False:C215)
		Else 
			OBJECT SET ENABLED:C1123(b4; True:C214)
		End if 
		v2:=vPartNum
		v1:=vPartDesc
		intTemp:=0
		ARRAY LONGINT:C221(aItemLines; 0)
		XR_ALDefine(eXRefList)
		vMod:=False:C215
		aXRefRec:=Num:C11(Size of array:C274(aXRefRec)>0)
		If (aXRefRec>0)
			OBJECT SET ENABLED:C1123(b47; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b47; False:C215)
		End if 
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (aXRefRec>0)
			OBJECT SET ENABLED:C1123(b47; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b47; False:C215)
		End if 
		If (doSearch>0)
			//  CHOPPED  AL_GetScroll(eXRefList; viVert; viHorz)
			If (Size of array:C274(aItemLines)#0)
				If (aItemLines{1}<=Size of array:C274(aXItemDesc))
					Case of   // : //|(Record number([ItemXRef])=-1))
						: (doSearch=11)  //Description
							aXItemDesc{aItemLines{1}}:=v1
						: (doSearch=12)  //xRef Item Num
							aXItemNum{aItemLines{1}}:=v2
						: (doSearch=15)  //vendor code
							aXVendCode{aItemLines{1}}:=v5
						: (doSearch=16)  //Location
							aXLocation{aItemLines{1}}:=v6
						: (doSearch=17)  //Type v7
						: (doSearch=31)  //lead time  vi1
							aXLead{aItemLines{1}}:=vi1
						: (doSearch=41)  //Comment vText1
						: (doSearch=21)  //Cost vR1
							aXCost{aItemLines{1}}:=vR1
						: (doSearch=22)  //Qty vR2
							aXQtyLoc{aItemLines{1}}:=vR2
					End case 
					//  --  CHOPPED  AL_UpdateArrays(eXRefList; -2)
					If (doSearch#-1000)
						// -- AL_SetSelect(eXRefList; aItemLines)
						// -- AL_SetScroll(eXRefList; viVert; viHorz)
					End if 
				End if 
			End if 
			vMod:=True:C214
			doSearch:=0
		End if 
End case 