C_LONGINT:C283($formevent)
$formevent:=Form event code:C388

Case of 
	: ($formevent=On Load:K2:1)
		C_TEXT:C284(vtallyMastersName)
		b51:=0
		b52:=0
		vSearchBy:=""
		vSearchBy2:=""
		bMakeUnique:=0
		
		ARRAY TEXT:C222(theFields; 0)
		ARRAY TEXT:C222(theTypes; 0)
		ARRAY TEXT:C222(theUniques; 0)
		ARRAY LONGINT:C221(theFldNum; 0)
		//
		ARRAY LONGINT:C221(aMatchCounter; 0)
		ARRAY TEXT:C222(aMatchField; 0)
		ARRAY TEXT:C222(aMatchType; 0)
		ARRAY LONGINT:C221(aMatchNum; 0)
		//
		ARRAY LONGINT:C221(aMatchLine; 0)
		
		//
		ARRAY LONGINT:C221(aCntImpFlds; 0)
		ARRAY TEXT:C222(aImpFields; 0)
		ARRAY TEXT:C222(aBullets; 0)
		//
		jaFilesInitial(True:C214; True:C214)  //restricted access; auto load search field
		Fld_ALDefine(eExportFlds)
		
		FldMatch_ALDefine
		Import_ALDefine
		
		//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
		//  --  CHOPPED  AL_UpdateArrays(eImportList; -2)
		
		vDiaCom:=""
		vFldSep:=""
		vFldSepBeg:=""
		vFldSepEnd:=""
		C_TEXT:C284(vFldSep)
		C_TEXT:C284(vFldSep)
		C_TEXT:C284(vRecDelim)
		C_TEXT:C284(vFldDelim)
		vFldDelim:="\t"
		vRecDelim:="\r"
		If (iLo255String1="Keep_@")
			iLo255String1:=Substring:C12(iLo255String1; 6)
		Else 
			iLo255String1:=""
		End if 
		SET MENU BAR:C67(6)
	: (After:C31)
		Temp_RayInit
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (doSearch#0)
			Case of 
				: (doSearch=2)
					//KeyModifierCurrent 
					//If (OptKey=1)
					//jImpRayArch 
					//Else 
					MatchAdd(True:C214; Size of array:C274(aMatchType))
					//End if 
				: (doSearch=3)
					MatchAdd(True:C214; aMatchType)
					
			End case 
			doSearch:=0
		End if 
End case 