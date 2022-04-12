//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/11/10, 13:16:17
// ----------------------------------------------------
// Method: jsetInHeader
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
MESSAGES OFF:C175

If ((ptCurTable#$1) | (vHere#1))
	
	// ### bj ### 20200623_0455
	FormSizeFit
	
	C_TEXT:C284(srKeyword)
	srKeyword:=""
	//If (ptCurTable#$1)
	iLoPagePopUpMenuBar($1)
	//End if 
	vr1:=0
	vr2:=0
	vr3:=0
	vr4:=0
	vr5:=0
	vr6:=0
	vHere:=1
	jSetAutoReMenus
	If (jRestrictedFile)
		DISABLE MENU ITEM:C150(2; 1)
		DISABLE MENU ITEM:C150(2; 2)
		DISABLE MENU ITEM:C150(2; 7)
	End if 
	If (StopModLoop)  //needed if a change jAcceptCancel was run
		//when going between files.  
		StopModLoop:=False:C215
	End if 
	If (False:C215)
		If (vWindowTitle="")
			SET WINDOW TITLE:C213(Table name:C256($1)+":  "+String:C10(Records in selection:C76($1->))+" - "+Storage:C1525.default.company)
		Else 
			SET WINDOW TITLE:C213(Table name:C256($1)+":  "+String:C10(Records in selection:C76($1->))+" - "+Storage:C1525.default.company+" - "+vWindowTitle)
		End if 
	End if 
	UNLOAD RECORD:C212($1->)
	MESSAGES ON:C181
	
	If (ptCurTable=(->[TallyMaster:60]))
		CREATE SET:C116([TallyMaster:60]; "current")
	End if 
	TallyMasterPopuuScriptsGeneral(ptCurTable; "olo"; ""; "aLooLoScripts")
	TallyMasterPopuuScriptsGeneral(ptCurTable; "olo"; ""; "aLooLoQueries")
	TallyMasterPopuuScriptsGeneral(ptCurTable; "olo"; ""; "aLooLoOrderBy")
	If (ptCurTable=(->[TallyMaster:60]))
		USE SET:C118("current")
		CLEAR SET:C117("current")
	End if 
End if 
If (False:C215)  //TestThis
	$viProcess:=Current process:C322
	HIDE MENU BAR:C432
	SET MENU BAR:C67(iLoMenu; $viProcess)  //;*)
	SHOW MENU BAR:C431
End if 
