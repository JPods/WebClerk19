//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/21/06, 05:14:45
// ----------------------------------------------------
// Method: Path_CustomerTask
// Description
// 
//
// Parameters
// ----------------------------------------------------
// gngngn  test this
C_TEXT:C284($0; $tablePath; $serverPath; $vtcustomerID; $pathFinal; $tableName)
If (Test path name:C476(Storage:C1525.paths.serverComEx)=0)
	$folderBase:=Storage:C1525.paths.serverComEx
Else 
	$folderBase:=Storage:C1525.paths.localComEx
End if 


If (ptCurTable#Null:C1517)  // classic
	$ptCurTable:=ptCurTable
End if 
If ($ptCurTable=Null:C1517)
	If (process_o.dataClassName#Null:C1517)  // adapt to ORDA
		$ptCurTable:=STR_GetTablePointer(process_o.dataClassName)
	End if 
End if 
If ($ptCurTable=Null:C1517)
	$pathFinal:=$folderBase+"general"+Folder separator:K24:12+Date_strYyyymmdd+Folder separator:K24:12
Else 
	$tableName:=Table name:C256($ptCurTable)
	If ($ptCurTable=(->[TechNote:58]))
		$pathFinal:=Storage:C1525.paths.jitHelpLocal+"TechNote"+Folder separator:K24:12+"idNum"+Folder separator:K24:12+String:C10([TechNote:58]idNum:1)+Folder separator:K24:12
	Else 
		If (process_o.cur.id=Null:C1517)
			// Should never happenBill James (2022-01-28T06:00:00Z)
			
			process_o.cur:=ds:C1482[$tableName].query("id = :1"; STR_Get_idPointer(Table name:C256($ptCurTable))->).first()
			process_o.old:=process_o.cur.clone()
		End if 
		If (process_o.cur#Null:C1517)
			$taskID:=0
			If (process_o.cur.idNumTask#Null:C1517)
				If (process_o.cur.idNumTask=0)
					var $ptidNumTask : Pointer
					$ptidNumTask:=STR_GetFieldPointer($tableName; "idNumTask")
					TaskIDAssign($ptidNumTask)
					process_o.cur.idNumTask:=$ptidNumTask->
					If (Record number:C243($ptCurTable->)#-1)  // classic 
						// MustFixQQQZZZ: Bill James (2021-11-16T06:00:00Z)
						
						SAVE RECORD:C53($ptCurTable->)
					Else 
						$taskID:=process_o.cur.save()  // ORDA
					End if 
				End if 
				$taskID:=process_o.cur.idNumTask
			End if 
			Case of 
				: (process_o.cur.customerID#Null:C1517)
					$tablePath:="Customer"+Folder separator:K24:12+process_o.cur.customerID+Folder separator:K24:12
					If ($taskID>9)
						$tablePath:=$tablePath+"taskID"+String:C10($taskID)+Folder separator:K24:12
					End if 
				: (process_o.cur.vendorID#Null:C1517)
					$tablePath:="Vendor"+Folder separator:K24:12+process_o.cur.vendorID+Folder separator:K24:12
					If ($taskID>9)
						$tablePath:=$tablePath+"taskID"+String:C10($taskID)+Folder separator:K24:12
					End if 
				: (process_o.cur.itemNum#Null:C1517)
					$tablePath:="Item"+Folder separator:K24:12+process_o.cur.itemNum+Folder separator:K24:12
					If ($taskID>9)
						$tablePath:=$tablePath+"taskID"+String:C10($taskID)+Folder separator:K24:12
					End if 
				Else 
					$tablePath:=$tableName+Folder separator:K24:12+process_o.cur.id+Folder separator:K24:12
					If ($taskID>9)
						$tablePath:=$tablePath+"taskID"+String:C10($taskID)+Folder separator:K24:12
					End if 
			End case 
			$pathFinal:=$folderBase+$tablePath
		End if 
	End if 
End if 
If (Test path name:C476($pathFinal)#0)
	CREATE FOLDER:C475($pathFinal; *)
End if 
$0:=$pathFinal