//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: RelatedByNumberPrs
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
Process_InitLocal
ptCurTable:=<>ptCurTable
USE SET:C118("<>curSelSet")
CLEAR SET:C117("<>curSelSet")
ORDER BY:C49([Word:99]; [Word:99]tableNum:2)
FIRST RECORD:C50([Word:99])
C_LONGINT:C283($i; $k; $newProcess)
$k:=Records in selection:C76([Word:99])
$i:=0
$cntTables:=Get last table number:C254
Repeat 
	If (([Word:99]tableNum:2>0) & ([Word:99]tableNum:2<=$cntTables))
		$thisTable:=[Word:99]tableNum:2
		CREATE EMPTY SET:C140(Table:C252([Word:99]tableNum:2)->; "Current")
		While ($thisTable=[Word:99]tableNum:2)
			$i:=$i+1
			If ([Word:99]fieldNum:7<=Get last field number:C255([Word:99]tableNum:2))
				$ptField:=Field:C253([Word:99]tableNum:2; [Word:99]fieldNum:7)
				If (Type:C295($ptField->)=Is alpha field:K8:1)
					QUERY:C277(Table:C252([Word:99]tableNum:2)->; $ptField->=[Word:99]relatedAlpha:8)
				Else 
					QUERY:C277(Table:C252([Word:99]tableNum:2)->; $ptField->=[Word:99]relatedLongInt:9)
				End if 
				ADD TO SET:C119(Table:C252([Word:99]tableNum:2)->; "Current")
			End if 
			NEXT RECORD:C51([Word:99])
		End while 
		USE SET:C118("current")
		CLEAR SET:C117("current")
		<>ptCurTable:=Table:C252($thisTable)
		CREATE SET:C116(<>ptCurTable->; "<>curSelSet")
		REDUCE SELECTION:C351(<>ptCurTable->; 0)
		<>prcControl:=1
		$newProcess:=New process:C317("Prs_ShowSelection"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptCurTable); Current process:C322; ""; 0; "")  //;Table($thisTable))
		DELAY PROCESS:C323(Current process:C322; 30)
	Else 
		NEXT RECORD:C51([Word:99])
	End if 
Until ($i>=$k)