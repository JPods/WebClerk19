//%attributes = {"publishedWeb":true}
//Procedure: Prs_ShowSelect
C_LONGINT:C283($1; $newProcess; $tableNum)
//
If (Application type:C494#4D Server:K5:6)
	If (Count parameters:C259=1)
		$tableNum:=1
	Else 
		ALL RECORDS:C47([QQQCustomer:2])
		$tableNum:=2
	End if 
	
	<>ptCurTable:=Table:C252($tableNum)
	CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
	REDUCE SELECTION:C351(<>ptCurTable->; 0)
	$newProcess:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256($tableNum); Current process:C322; ""; 0; "")  //;Table($tableNum))
	//Repeat 
	//DELAY PROCESS(Current process;60)
	//Until (<>prcControl=0)
	//Prs_ListActive 
End if 