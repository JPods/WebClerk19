//%attributes = {}

// Modified by: Bill James (2021-11-18T06:00:00Z)
// Method: Folder_ContentToDocs
// Description 
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tablePath; $serverPath; $localPath; $vtcustomerID; $pathFinal; $tableName; $pathSub)
ARRAY TEXT:C222($aServerDocs; 0)
ARRAY TEXT:C222($aLocalDocs; 0)
C_LONGINT:C283($inc; $cnt; $tableNum)
var $rec_ent; $sel_ent : Object

If (process_o#Null:C1517)
	If (process_o.tableName#"")
		$tableName:=process_o.tableName
		$tableNum:=STR_GetTableNumber(process_o.tableName)
		
		// should already be in system
		
		$localPath:=Storage:C1525.paths.localComEx
		If (Test path name:C476(Storage:C1525.paths.serverComEx)=0)
			$serverPath:=Storage:C1525.paths.serverComEx+"Customer"+Folder separator:K24:12+process_o.cur.customerID+Folder separator:K24:12
			If (process_o.cur.idNumTask#Null:C1517)
				$serverPath:=Storage:C1525.paths.serverComEx+"Customer"+Folder separator:K24:12+process_o.cur.customerID+Folder separator:K24:12\
					+"task"+String:C10(process_o.cur.idNumTask)+Folder separator:K24:12
			End if 
			DOCUMENT LIST:C474($serverPath; $aServerDocs)
		Else 
			ConsoleMessage("Error: Storage.paths.serverComEx: "+Storage:C1525.paths.serverComEx+", $serverPath: "+$serverPath)
			$serverPath:=""
		End if 
		If (Test path name:C476($localPath)=0)
			DOCUMENT LIST:C474($localPath; $aLocalDocs)
		Else 
			ConsoleMessage("Error: Storage.paths.serverComEx: "+Storage:C1525.paths.localComEx+", $localPath: "+$localPath)
			$localPath:=""
		End if 
		
		
		// MustFixQQQZZZ: Bill James (2021-11-19T06:00:00Z)
		
		
		$cnt:=Size of array:C274($aServerDocs)
		For ($inc; 1; $cnt)
			$pathFinal:=$serverPath+$aServerDocs{$inc}
			$rec_ent:=ds:C1482.Document.query("path = :1 & customerID = $2"; $pathFinal; process_o.cur.customerID).first()
			If ($rec_ent=Null:C1517)
				$rec_ent:=ds:C1482.Document.new()
				$rec_ent.customerID:=process_o.cur.customerID
				$rec_ent.path:=Convert path system to POSIX:C1106($pathFinal)
				$rec_ent.dateEntered:=Current date:C33
				$rec_ent.tableNum:=$tableNum
				$rec_ent.imageName:=$aServerDocs{$inc}
				$rec_ent.description:=$aServerDocs{$inc}
				$rec_ent.idRelated:=process_o.cur.id
				//$rec_ent.sizeBytes
				$rec_ent.save()
			End if 
		End for 
		
		$cnt:=Size of array:C274($aLocalDocs)
		For ($inc; 1; $cnt)
			$pathFinal:=$localPath+$aLocalDocs{$inc}
			$rec_ent:=ds:C1482.Document.query("path = :1 & customerID = $2"; $pathFinal; process_o.cur.customerID).first()
			If ($rec_ent=Null:C1517)
				$rec_ent:=ds:C1482.Document.new()
				$rec_ent.customerID:=process_o.cur.customerID
				$rec_ent.path:=Convert path system to POSIX:C1106($pathFinal)
				$rec_ent.dateEntered:=Current date:C33
				$rec_ent.tableNum:=$tableNum
				$rec_ent.imageName:=$aLocalDocs{$inc}
				$rec_ent.description:=$aLocalDocs{$inc}
				$rec_ent.idRelated:=process_o.cur.id
				//$rec_ent.sizeBytes
				$rec_ent.save()
			End if 
		End for 
		
		
	End if 
	
	
End if 