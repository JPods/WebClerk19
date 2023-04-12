//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/15/11, 15:41:07
// ----------------------------------------------------
// Method: EmployeesReps
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i; $k)
C_LONGINT:C283($1; $direction)
ALL RECORDS:C47([Rep:8])
$direction:=0
If (Count parameters:C259=1)
	$direction:=$1
End if 
If ($direction=0)
	ALL RECORDS:C47([Rep:8])
	FIRST RECORD:C50([Rep:8])
	$k:=Records in selection:C76([Rep:8])
	For ($i; 1; $k)
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Rep:8]repID:1)
		If (Records in selection:C76([Employee:19])=0)
			CREATE RECORD:C68([Employee:19])
		End if 
		[Employee:19]nameID:1:=[Rep:8]repID:1
		[Employee:19]nameLast:2:=[Rep:8]nameLast:27
		[Employee:19]nameFirst:3:=[Rep:8]nameFirst:25
		[Employee:19]address1:17:=[Rep:8]address1:4
		[Employee:19]address2:18:=[Rep:8]address2:5
		[Employee:19]city:19:=[Rep:8]city:6
		[Employee:19]state:20:=[Rep:8]state:7
		[Employee:19]zip:21:=[Rep:8]zip:8
		[Employee:19]country:37:=[Rep:8]country:9
		[Employee:19]domain:30:=[Rep:8]domain:30
		[Employee:19]email:16:=[Rep:8]email:22
		[Employee:19]fax:15:=[Rep:8]fax:20
		[Employee:19]phone1:13:=[Rep:8]phone:10
		[Employee:19]phone2:14:=[Rep:8]phoneCell:41
		[Employee:19]comment:64:=[Rep:8]comment:19
		[Employee:19]dateHire:34:=[Rep:8]dateOpened:11
		[Employee:19]publish:39:=[Rep:8]publish:40
		[Employee:19]comRate:6:=[Rep:8]comRate:13
		[Employee:19]dateLastUpdated:52:=[Rep:8]dateLastUpdated:42
		SAVE RECORD:C53([Employee:19])
		UNLOAD RECORD:C212([Employee:19])
		NEXT RECORD:C51([Rep:8])
	End for 
Else 
	FIRST RECORD:C50([Employee:19])
	$k:=Records in selection:C76([Employee:19])
	For ($i; 1; $k)
		QUERY:C277([Rep:8]; [Employee:19]nameID:1=[Rep:8]repID:1)
		If (Records in selection:C76([Employee:19])=0)
			CREATE RECORD:C68([Rep:8])
		End if 
		[Rep:8]repID:1:=[Employee:19]nameID:1
		[Rep:8]nameLast:27:=[Employee:19]nameLast:2
		[Rep:8]nameFirst:25:=[Employee:19]nameFirst:3
		[Rep:8]address1:4:=[Employee:19]address1:17
		[Rep:8]address2:5:=[Employee:19]address2:18
		[Rep:8]city:6:=[Employee:19]city:19
		[Rep:8]state:7:=[Employee:19]state:20
		[Rep:8]zip:8:=[Employee:19]zip:21
		[Rep:8]country:9:=[Employee:19]country:37
		[Rep:8]domain:30:=[Employee:19]domain:30
		[Rep:8]email:22:=[Employee:19]email:16
		[Rep:8]fax:20:=[Employee:19]fax:15
		[Rep:8]phone:10:=[Employee:19]phone1:13
		[Rep:8]phoneCell:41:=[Employee:19]phone2:14
		[Rep:8]comment:19:=[Employee:19]comment:64
		[Rep:8]dateOpened:11:=[Employee:19]dateHire:34
		[Rep:8]publish:40:=[Employee:19]publish:39
		[Rep:8]comRate:13:=[Employee:19]comRate:6
		[Rep:8]dateLastUpdated:42:=[Employee:19]dateLastUpdated:52
		SAVE RECORD:C53([Rep:8])
		UNLOAD RECORD:C212([Rep:8])
		NEXT RECORD:C51([Employee:19])
	End for 
End if 
$doThis:=False:C215
If ($doThis)
	ALL RECORDS:C47([Employee:19])
	FIRST RECORD:C50([Employee:19])
	$k:=Records in selection:C76([Employee:19])
	For ($i; 1; $k)
		Parse_UnWanted(process_o.entry_o.nameid)
		SAVE RECORD:C53([Employee:19])
		NEXT RECORD:C51([Employee:19])
	End for 
	UNLOAD RECORD:C212([Employee:19])
	
	ALL RECORDS:C47([Rep:8])
	FIRST RECORD:C50([Rep:8])
	$k:=Records in selection:C76([Rep:8])
	For ($i; 1; $k)
		Parse_UnWanted(process_o.entry_o.repID)
		SAVE RECORD:C53([Rep:8])
		NEXT RECORD:C51([Rep:8])
	End for 
	UNLOAD RECORD:C212([Rep:8])
End if 

$doThis:=False:C215
If ($doThis)
	ALL RECORDS:C47([Employee:19])
	FIRST RECORD:C50([Employee:19])
	$k:=Records in selection:C76([Employee:19])
	For ($i; 1; $k)
		RemoteUser_Create(->[Employee:19]; [Employee:19]email:16; [Employee:19]nameID:1; 5000)
		SAVE RECORD:C53([Employee:19])
		NEXT RECORD:C51([Employee:19])
	End for 
	UNLOAD RECORD:C212([Employee:19])
	
	ALL RECORDS:C47([Rep:8])
	FIRST RECORD:C50([Rep:8])
	$k:=Records in selection:C76([Rep:8])
	For ($i; 1; $k)
		RemoteUser_Create(->[Rep:8]; [Rep:8]repID:1; [Rep:8]nameLast:27; 5)
		SAVE RECORD:C53([Rep:8])
		NEXT RECORD:C51([Rep:8])
	End for 
	UNLOAD RECORD:C212([Rep:8])
End if 



//myPage:=nameID
//Keyword:=RepID



