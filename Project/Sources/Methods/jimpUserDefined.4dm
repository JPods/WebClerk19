//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/12/11, 13:57:21
// ----------------------------------------------------
// Method: jimpUserDefined
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Import"))
	
	//OPEN WINDOW(4;40;464;310;-724;"Import General";"Wind_CloseBox")
	C_TIME:C306(itemMakeDoc)
	C_LONGINT:C283(doShowImport)
	doShowImport:=0
	jCenterWindow(700; 554; 3; "Import General"; "Wind_CloseBox")
	SET MENU BAR:C67(6)
	DIALOG:C40([Control:1]; "importGeneral")
	CLOSE WINDOW:C154
	If (doShowImport>0)
		USE SET:C118("Imported")
		CLEAR SET:C117("Imported")
		DB_ShowCurrentSelection(Table:C252(doShowImport))
		doShowImport:=0
	End if 
	ReadOnlyFiles
	C_LONGINT:C283(bClose)
	jaFilesClose
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
End if 

