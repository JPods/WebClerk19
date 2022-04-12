//%attributes = {"publishedWeb":true}
//CloneRecord
C_LONGINT:C283($i; $myOK; $k; $Cntr; $ordNum; $taskID)
C_TEXT:C284($Part)
C_REAL:C285($PriceDisc; $UPrice; $UnitCost)
C_BOOLEAN:C305($PCBase)

$myOK:=1
If ((jRestrictedFile) & (Current user:C182#"James Technologies"))
	ABORT:C156
Else 
	If (vHere>1)
		If (Modified record:C314(ptCurTable->))
			booSorted:=False:C215
			myCycle:=6  //No Cancel trial
			jAcceptButton(False:C215; False:C215)
		Else 
			//use to cancel transaction
		End if 
		$ordNum:=[Order:3]idNum:2
		$taskID:=[Order:3]idNumTask:85
		Clone_Order
		ONE RECORD SELECT:C189(ptCurTable->)
		jNxPvButtonSet
		booSorted:=False:C215
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=$taskID)
		$k:=Records in selection:C76([WorkOrder:66])
		C_LONGINT:C283($taskRecs)
		If ($k>0)
			TaskIDAssign(->[Order:3]idNumTask:85)
			SELECTION TO ARRAY:C260([WorkOrder:66]; aTmpLong1)
			For ($i; 1; $k)
				GOTO RECORD:C242([WorkOrder:66]; aTmpLong1{$i})
				//QUERY([WorkOrderTask];[WorkOrderTask]WorkOrderNum=[WorkOrder]WONum)
				//SELECTION TO ARRAY([WorkOrderTask];$aWOTaskRecs)
				DUPLICATE RECORD:C225([WorkOrder:66])
				[WorkOrder:66]idNumTask:22:=[Order:3]idNumTask:85
				[WorkOrder:66]dtComplete:6:=0
				[WorkOrder:66]dtAction:5:=0
				[WorkOrder:66]dtReleased:4:=DateTime_Enter
				[WorkOrder:66]woNum:29:=CounterNew(->[WorkOrder:66])
				
				SAVE RECORD:C53([WorkOrder:66])
			End for 
		End if 
		RelatedRelease
	End if 
End if 