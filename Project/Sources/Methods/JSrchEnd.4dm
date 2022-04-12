//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2)  //$1; $recNum
Case of 
	: ((vHere>1) & (Records in selection:C76(ptCurTable->)=0))
		GOTO RECORD:C242(ptCurTable->; $2)
		BEEP:C151
		BEEP:C151
	: (Records in selection:C76(ptCurTable->)=0)
		MenuTitle  // ### jwm ### 20190625_1718 rest menu title
		BEEP:C151
		BEEP:C151
		//jCancelButton 
	: (($1=1) & (vHere=0))
		ProcessTableOpen(ptCurTable)
		//  : (($1=0)|(vHere>0))//do nothing    
	: (($1=1) & (vHere>1))
		LOAD RECORD:C52(ptCurTable->)
		booPreNext:=True:C214
	: (vHere=1)
		MenuTitle
		If (ptCurTable=(->[Item:4]))
			ORDER BY:C49([Item:4]; [Item:4]itemNum:1)
		End if 
		If (ptCurTable#(->[TallyMaster:60]))
			Execute_TallyMaster(Table name:C256(ptCurTable); "oloOpen")
		End if 
End case 
