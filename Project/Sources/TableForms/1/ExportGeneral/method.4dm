C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		If (vHere>1)
			OBJECT SET ENABLED:C1123(bSearch; False:C215)
		End if 
		jaFilesInitial(False:C215; False:C215)  //restricted access; auto load search field  
		Fld_ALDefine(eExportFlds)
		vFldSepBeg:=""
		vFldSepEnd:=""
		C_TEXT:C284(vRecDelim)
		C_TEXT:C284(vFldDelim)
		vFldDelim:="\t"
		vRecDelim:="\r"
		
		FldMatch_ALDefine
		//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
		
	: ($formEvent=On Outside Call:K2:11)  //(Outside call)
		Prs_OutsideCall
	Else 
		If (doSearch#0)
			Case of 
				: (doSearch=3)
					MatchAdd(False:C215; aMatchType)
			End case 
			// ARRAY Longint(aMatchLine;0)
			
			doSearch:=0
		End if 
		
		
End case 

