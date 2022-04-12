//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/30/12, 12:23:20
// ----------------------------------------------------
// Method: Method: WO_TransferCreate
// Description
// 
//
// Parameters 8 
// ----------------------------------------------------
C_REAL:C285($2; $qty)
C_LONGINT:C283($3; $taskID; $11; $groupID)
C_DATE:C307($4; $dateAction)
C_TEXT:C284($1; $itemNum; $5; $siteIDFrom; $6; $siteIDTo; $7; $requestedBy; $8; $status; $9; $actionBy; $10; $activity)  //### jwm ### 20130129_1128 changed actionBy to requestedBy and remoteUser to ActionBy
//$actionBy:=Current user
If (Count parameters:C259>0)
	$itemNum:=$1
	If (Count parameters:C259>1)
		$qty:=$2
		If (Count parameters:C259>2)
			$taskID:=$3
			If (Count parameters:C259>3)
				$dateAction:=$4
				If (Count parameters:C259>4)
					$siteIDFrom:=$5
					If (Count parameters:C259>5)
						$siteIDTo:=$6
						If (Count parameters:C259>6)
							$requestedBy:=$7  //### jwm ### 20130129_1122 was actionBy
							If ($requestedBy="")
								$requestedBy:=Current user:C182
								iLo80String3:=$requestedBy
							End if 
							If (Count parameters:C259>7)
								$status:=$8
								If (Count parameters:C259>8)  //### jwm ### 20130129_1040 was > 7
									$actionBy:=$9  //### jwm ### 20130129_1122 was remoteUser
								End if 
								If (Count parameters:C259>9)  // ### jwm ### 20140929_1505
									$activity:=$10
								Else 
									$activity:=""
								End if 
								If (Count parameters:C259>10)  // ### jwm ### 20140929_1505
									$groupID:=$11
								Else 
									$groupID:=0
								End if 
								
								If ($actionBy="")
									$actionBy:=Current user:C182
									iLo80String4:=$actionBy
								End if 
								If ([Item:4]itemNum:1#$itemNum)
									READ ONLY:C145([Item:4])
									QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
								End if 
								CREATE RECORD:C68([WorkOrder:66])
								[WorkOrder:66]woNum:29:=CounterNew(->[WorkOrder:66])
								[WorkOrder:66]woType:60:="Transfer"
								[WorkOrder:66]action:33:=$status
								
								//###jwm ###20121129_1529 Begin
								
								[WorkOrder:66]dtCreated:44:=DateTime_Enter
								[WorkOrder:66]dtAction:5:=DateTime_Enter(iLoDate1)
								[WorkOrder:66]dateComplete:64:=!00-00-00!
								[WorkOrder:66]idNumTask:22:=$taskID
								
								//###jwm ###20121129_1529 End
								
								[WorkOrder:66]qtyOrdered:13:=$qty
								If ([WorkOrder:66]action:33="PendingTransfer")
									[WorkOrder:66]qtyActual:14:=$qty
								End if 
								[WorkOrder:66]itemNum:12:=[Item:4]itemNum:1
								[WorkOrder:66]itemDescript:34:=[Item:4]description:7  //###jwm ###20121129_1600
								[WorkOrder:66]profile3:39:=[Item:4]locationBin:113
								[WorkOrder:66]costPlanned:15:=[Item:4]costAverage:13
								
								[WorkOrder:66]siteIDFrom:62:=$siteIDFrom
								[WorkOrder:66]siteIDTo:61:=$siteIDTo
								If (iLo80String3="")
									iLo80String3:=Current user:C182
								End if 
								[WorkOrder:66]actionByLast:65:=iLo80String3
								If (iLo80String4="")
									iLo80String4:=Current user:C182
								End if 
								[WorkOrder:66]actionBy:8:=iLo80String4
								[WorkOrder:66]actionByInitiated:9:=Current user:C182
								//[WorkOrder]RemoteUserName:=$remoteUser  //### jwm ### 20130129_1124 we don't have a remoteUserID 
								[WorkOrder:66]actionBy:8:=$actionBy
								[WorkOrder:66]activity:7:=$activity
								[WorkOrder:66]groupid:32:=$groupID
								
								SAVE RECORD:C53([WorkOrder:66])
								
								If ([WorkOrder:66]action:33="PendingTransfer")
									[WorkOrder:66]qtyActual:14:=$qty
									WOTransfer_dInventory("Ship")
									
									//QUERY([UserReport];[UserReport]Name="InventoryTransferWO_Auto")
									//### jwm ### 20131004_1238
									QUERY:C277([UserReport:46]; [UserReport:46]name:2="WOTransferLabel")
									
									If (Records in selection:C76([UserReport:46])=1)
										vHere:=0
										Prnt_ReportOpts
										//SRE_Print 
										//vHere:=2
									End if 
									UNLOAD RECORD:C212([UserReport:46])
									
								End if 
								
								UNLOAD RECORD:C212([Item:4])
								READ WRITE:C146([Item:4])
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 