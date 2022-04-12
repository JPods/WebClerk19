//%attributes = {"publishedWeb":true}
C_LONGINT:C283($recDo; $recNum)
$recDo:=0
$recNum:=0
Case of 
	: ((vHere=0) | (vHere=1))
		//If (Count parameters=0)
		//vi1:=5
		//AUTOMATIC RELATIONS(True;True)
		//File_Select ("Select the file for which you wish to Search.")
		//AUTOMATIC RELATIONS(False;False)
		//$recDo:=myOK
		//End if 
		//: (vHere=1)
		jCenterWindow(608; 408; -720)
		DIALOG:C40([DefaultQQQ:15]; "QueryEditor")
		CLOSE WINDOW:C154
		$recDo:=myOK
	: (vHere>1)
		If (Modified record:C314(ptCurTable->))
			myCycle:=6
			jAcceptButton
		End if 
		myOK:=0  //initialize
		$recNum:=Record number:C243(ptCurTable->)
		jCenterWindow(608; 408; -720)
		DIALOG:C40([DefaultQQQ:15]; "QueryEditor")
		CLOSE WINDOW:C154
		$recDo:=myOK
End case 
JSrchEnd($recDo; $recNum)