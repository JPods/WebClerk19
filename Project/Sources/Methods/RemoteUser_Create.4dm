//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/21/08, 06:38:33
// ----------------------------------------------------
// Method: RemoteUser_Create
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
C_TEXT:C284($2; $3; $userName; $passWord; $tableName)
C_LONGINT:C283($4; $securityLevel; $k; $forceValue)


$userName:=$2
$passWord:=WCapi_GetParameter("password")
If ($passWord="")
	$passWord:=$3
End if 
$securityLevel:=$4
$forceValue:=0

var $rec_ent : Object

$rec_ent:=ds:C1482.RemoteUser.new()
$rec_ent.dateCreated:=Current date:C33

$rec_ent.userPassword:=$passWord
$rec_ent.dtLastVisit:=DateTime_Enter
If ($securityLevel<1)
	$rec_ent.securityLevel:=1
Else 
	$rec_ent.securityLevel:=$securityLevel
End if 
$rec_ent.hitCount:=0
$rec_ent.idEventLog:=""
[EventLog:75]hitsTotal:11:=0
$rec_ent.dtCreated:=0
$rec_ent.dotted:=""
Case of 
	: ($1=(->[Customer:2]))
		[Customer:2]email:81:=[Customer:2]email:81
		If ([Customer:2]email:81#"")
			$userName:=[Customer:2]email:81
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[Customer:2]domain:90
		$rec_ent.email:=[Customer:2]email:81
		$rec_ent.tableNum:=Table:C252(->[Customer:2])
		$rec_ent.customerID:=[Customer:2]customerID:1
		$rec_ent.company:=[Customer:2]company:2
		$rec_ent.idPrimary:=[Customer:2]id:127
		$rec_ent.save()
		[Customer:2]remoteUser:84:=True:C214
		SAVE RECORD:C53([Customer:2])
	: ($1=(->[zzzLead:48]))
		[zzzLead:48]email:33:=[zzzLead:48]email:33
		If ([zzzLead:48]email:33#"")
			$userName:=[zzzLead:48]email:33
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[zzzLead:48]domain:46
		$rec_ent.email:=[zzzLead:48]email:33
		$rec_ent.tableNum:=Table:C252(->[zzzLead:48])
		$rec_ent.customerID:=String:C10([zzzLead:48]idNum:32)
		$rec_ent.company:=[zzzLead:48]company:5
		$rec_ent.idPrimary:=[zzzLead:48]id:60
		$rec_ent.save()
		[zzzLead:48]remoteUser:44:=True:C214
		SAVE RECORD:C53([zzzLead:48])
	: ($1=(->[Rep:8]))
		[Rep:8]email:22:=[Rep:8]email:22
		If ([Rep:8]email:22#"")
			$userName:=[Rep:8]email:22
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[Rep:8]domain:30
		$rec_ent.email:=[Rep:8]email:22
		$rec_ent.tableNum:=Table:C252(->[Rep:8])
		$rec_ent.customerID:=[Rep:8]RepID:1
		$rec_ent.company:=[Rep:8]company:2
		$rec_ent.keyTags:=[Rep:8]RepID:1
		$rec_ent.role:=[Rep:8]nameFirst:25
		$rec_ent.idPrimary:=[Rep:8]id:48
		$rec_ent.save()
		[Rep:8]remoteUser:29:=True:C214
		SAVE RECORD:C53([Rep:8])
	: ($1=(->[RepContact:10]))
		[RepContact:10]email:21:=[RepContact:10]email:21
		If ([RepContact:10]email:21#"")
			$userName:=[RepContact:10]email:21
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[Rep:8]domain:30
		$rec_ent.email:=[RepContact:10]email:21
		$rec_ent.tableNum:=Table:C252(->[RepContact:10])
		$rec_ent.tableName:=Table name:C256($rec_ent.tableNum)
		$rec_ent.customerID:=[RepContact:10]repID:1
		$rec_ent.company:=[Rep:8]company:2
		$rec_ent.idPrimary:=[Rep:8]id:48
		$rec_ent.save()
		//[RepContact]RemoteUser:=True
		//SAVE RECORD([RepContact])
	: ($1=(->[Contact:13]))
		[Contact:13]email:35:=[Contact:13]email:35
		If ([Contact:13]email:35#"")
			$userName:=[Contact:13]email:35
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[Contact:13]domain:53
		$rec_ent.email:=[Contact:13]email:35
		$rec_ent.tableNum:=Table:C252(->[Contact:13])
		$rec_ent.customerID:=String:C10([Contact:13]idNum:28)
		$rec_ent.company:=[Contact:13]company:23
		$rec_ent.contactID:=[Contact:13]idNum:28
		$rec_ent.idPrimary:=[Contact:13]id:62
		$rec_ent.save()
		[Contact:13]remoteUser:41:=True:C214
		SAVE RECORD:C53([Contact:13])
	: ($1=(->[Employee:19]))
		[Employee:19]email:16:=[Employee:19]email:16
		If ([Employee:19]email:16#"")
			$userName:=[Employee:19]email:16
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[Employee:19]domain:30
		$rec_ent.email:=[Employee:19]email:16
		$rec_ent.tableNum:=Table:C252(->[Employee:19])
		$rec_ent.customerID:=[Employee:19]nameID:1
		$rec_ent.company:=Storage:C1525.default.company
		$rec_ent.role:=[Employee:19]role:7
		$rec_ent.idPrimary:=[Employee:19]id:72
		$rec_ent.save()
		[Employee:19]remoteUser:31:=True:C214
		SAVE RECORD:C53([Employee:19])
	: ($1=(->[Vendor:38]))
		[Vendor:38]email:59:=[Vendor:38]email:59
		If ([Vendor:38]email:59#"")
			$userName:=[Vendor:38]email:59
		End if 
		$rec_ent.userName:=$userName
		$rec_ent.domain:=[Vendor:38]domain:68
		$rec_ent.email:=[Vendor:38]email:59
		$rec_ent.tableNum:=Table:C252(->[Vendor:38])
		$rec_ent.customerID:=[Vendor:38]vendorID:1
		$rec_ent.company:=[Vendor:38]company:2
		$rec_ent.idPrimary:=[Vendor:38]id:98
		$rec_ent.save()
		[Vendor:38]remoteUser:91:=True:C214
		SAVE RECORD:C53([Vendor:38])
End case 



If (False:C215)
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
End if 
