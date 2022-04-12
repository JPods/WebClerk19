//%attributes = {}

// Modified by: Bill James (2021-11-05T05:00:00Z)
// Method: 00FixEmployeeRemoteUser
// Description
// 
// Parameters
// ----------------------------------------------------

// Modified by: Bill James (2021-11-05T05:00:00Z)
var $tableName : Text
var $rec_ent; $sel_ent; $recRU_ent : Object

If (Storage:C1525.fix.ContractDetail#Null:C1517)
	If (Storage:C1525.fix.ContractDetail="yes")
		var $path; $pathTN : Text
		CONFIRM:C162("fix.ContractDetail")
		If (OK=1)
			
			For each ($rec_ent; $sel_ent)
				$path:=$rec_ent.path
				Case of 
					: ($path="")
						$rec_ent.creator:="bad: empty path"
					: (Test path name:C476($rec_ent.path)>-1)
						$rec_ent.creator:="good path"
						// test if local or server
						// if local copy to sever
					: (Position:C15("CommerceExpert"; $rec_ent.path)>0)
						// test if local or server
						// if local copy to sever
						
						
						
				End case 
				
			End for each 
			ALERT:C41("Complete fix.ContractDetail")
		End if 
	End if 
End if 


If (Storage:C1525.fix.document.path#Null:C1517)
	If (Storage:C1525.fix.document.path="yes")
		var $path; $pathTN : Text
		CONFIRM:C162("fix.document.path")
		If (OK=1)
			$sel_ent:=ds:C1482.Document.all()
			For each ($rec_ent; $sel_ent)
				$path:=$rec_ent.path
				Case of 
					: ($path="")
						$rec_ent.creator:="bad: empty path"
					: (Test path name:C476($rec_ent.path)>-1)
						$rec_ent.creator:="good path"
						// test if local or server
						// if local copy to sever
					: (Position:C15("CommerceExpert"; $rec_ent.path)>0)
						// test if local or server
						// if local copy to sever
						
						
						
				End case 
				
			End for each 
			ALERT:C41("Complete fix.remoteUser.employee")
		End if 
	End if 
End if 

If (Storage:C1525.fix.remoteUser.employee#Null:C1517)
	If (Storage:C1525.fix.remoteUser.employee="yes")
		CONFIRM:C162("fix.remoteUser.employee")
		If (OK=1)
			
			$tableName:="Employee"
			$sel_ent:=ds:C1482[$tableName].all()
			For each ($rec_ent; $sel_ent)
				$selRU_ent:=ds:C1482.RemoteUser.query("customerID = :1 AND tableName = :2"; $rec_ent.nameID; $tableName)
				Case of 
					: ($selRU_ent.length>1)
						
					: ($selRU_ent.length=1)
						
					Else 
						
				End case 
				
				$rec_ent.save()
			End for each 
			ALERT:C41("Complete fix.remoteUser.employee")
		End if 
	End if 
End if 

If (Storage:C1525.fix.remoteUser.tableName#Null:C1517)
	If (Storage:C1525.fix.remoteUser.tableName="yes")
		CONFIRM:C162("fix.remoteUser.tableName")
		If (OK=1)
			var $recTarget_ent : Object
			var $ptTable : Pointer
			$sel_ent:=ds:C1482.RemoteUser.all()
			For each ($rec_ent; $sel_ent)
				vi3:=1
				$ptTable:=Table:C252($rec_ent.tableNum)
				If ($ptTable#Null:C1517)
					$tableName:=Table name:C256($rec_ent.tableNum)
					Case of 
						: ($rec_ent.tableNum=2)
							$recTarget_ent:=ds:C1482[$tableName].query("customerID= :1"; $rec_ent.customerID)
							$rec_ent.company:=$recTarget_ent.company
							
						: ($rec_ent.tableNum=13)  //Contacts
							$recTarget_ent:=ds:C1482[$tableName].query("idNum= :1"; Num:C11($rec_ent.customerID))
							$rec_ent.company:=$recTarget_ent.company
							
						: ($rec_ent.tableNum=8)  //Reps
							$recTarget_ent:=ds:C1482[$tableName].query("repID= :1"; $rec_ent.customerID)
							$rec_ent.company:=$recTarget_ent.company
							
						: ($rec_ent.tableNum=38)  //Vendors
							$recTarget_ent:=ds:C1482[$tableName].query("vendorID= :1"; $rec_ent.customerID)
							$rec_ent.company:=$recTarget_ent.company
							
						: ($rec_ent.tableNum=19)  //Employees
							$recTarget_ent:=ds:C1482[$tableName].query("nameID= :1"; $rec_ent.customerID)
							$rec_ent.company:="Employee"
							
						: ($rec_ent.tableNum=48)  //Leads
							$recTarget_ent:=ds:C1482[$tableName].query("idNum= :1"; Num:C11($rec_ent.customerID))
							$rec_ent.company:=$recTarget_ent.company
						Else 
							vi3:=0
							$rec_ent.drop()
					End case 
					If (vi3=1)
						If ($recTarget_ent.obGeneral=Null:C1517)
							$recTarget_ent:=New object:C1471
						End if 
						$recTarget_ent.obGeneral.related:=New collection:C1472
						$recTarget_ent.obGeneral.related.push(New object:C1471("RemoteUser"; $rec_ent.id))
						$rec_ent.tableName:=Table name:C256($rec_ent.tableNum)
						$rec_ent.save()
					End if 
				End if 
			End for each 
			ALERT:C41("Complete fix.remoteUser.tableName")
		End if 
	End if 
End if 


