//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:28:46
// ----------------------------------------------------
// Method: jexpUserDefined
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Export"))
	C_LONGINT:C283($recNum)
	C_BOOLEAN:C305($doReport)
	If (vHere>1)
		$doReport:=jConfirmSave(True:C214; True:C214)
		If ($doReport)
			AcceptPrint
			$recNum:=Record number:C243(ptCurTable->)
			ONE RECORD SELECT:C189(ptCurTable->)
		End if 
	Else 
		$doReport:=True:C214
	End if 
	If ($doReport)
		//OPEN WINDOW(4;40;424;318;-724;"Export General";"Wind_CloseBox")
		SET MENU BAR:C67(6)
		jCenterWindow(610; 570; 3; "Export General"; "Wind_CloseBox")
		DIALOG:C40([Control:1]; "ExportGeneral")
		CLOSE WINDOW:C154
		tkSpreadSheet:=1
		Case of 
			: (myOK=3)
				Records_In(Table:C252(curTableNum))
			: (myOK=4)
				Records_Out(Table:C252(curTableNum); ""; 0)  //File; name of file; keep selection//
		End case 
		jaFilesClose
		myOK:=0
		If (vHere>1)
			GOTO RECORD:C242(ptCurTable->; $recNum)
			SET WINDOW TITLE:C213(Table name:C256(ptCurTable)+" - "+aPages{1}+" - "+String:C10(1))
			jNxPvButtonSet
		End if 
	End if 
	vFldSepBeg:=""
	vFldSepEnd:=""
	
	Case of 
		: (vhere=0)
			SET MENU BAR:C67(splashMenu)
		: (vhere=1)
			SET MENU BAR:C67(oLoMenu)
		Else 
			SET MENU BAR:C67(iLoMenu)
	End case 
	
	If (False:C215)
		
		ALL RECORDS:C47([DefaultQQQ:15])
		DELETE SELECTION:C66([DefaultQQQ:15])
		Records_In(->[DefaultQQQ:15])
		
	End if 
End if 