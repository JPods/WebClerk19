C_LONGINT:C283($formevent)
$formevent:=Form event code:C388

Case of 
	: ($formevent=On Load:K2:1)
		bMakeUnique:=0
		jaFilesInitial(True:C214; False:C215)  //restricted access; auto load search field
		Fld_ALDefine(eExportFlds)
		SET MENU BAR:C67(6)
		FldMatch_ALDefine
		Import_ALDefine
		
	: (After:C31)
		Temp_RayInit
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (doSearch#0)
			Case of 
				: (doSearch=2)
					MatchAdd(True:C214; Size of array:C274(aMatchType))
				: (doSearch=3)
					MatchAdd(True:C214; aMatchType)
			End case 
			doSearch:=0
		End if 
End case 