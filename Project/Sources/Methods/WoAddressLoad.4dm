//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/05/18, 12:58:02
// ----------------------------------------------------
// Method: WoAddressLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20201127_2202 make LatLng a string
C_TEXT:C284($1; $tableName)
$tableName:=$1
Case of 
	: ($tableName="Customer")
		[WorkOrder:66]company:36:=[Customer:2]company:2
		[WorkOrder:66]address1:50:=[Customer:2]address1:4
		[WorkOrder:66]address2:51:=[Customer:2]address2:5
		[WorkOrder:66]city:52:=[Customer:2]city:6
		[WorkOrder:66]state:53:=[Customer:2]state:7
		[WorkOrder:66]zip:54:=[Customer:2]zip:8
		[WorkOrder:66]lat:72:=[Customer:2]lat:135
		If ([WorkOrder:66]adSource:58="")
			[WorkOrder:66]adSource:58:=[Customer:2]adSource:62
		End if 
		If ([Customer:2]objective:133#Null:C1517)
			[WorkOrder:66]objective:68:=OB Copy:C1225([Customer:2]objective:133)
		End if 
		If ([WorkOrder:66]instructions:55="")
			[WorkOrder:66]instructions:55:=[Customer:2]profile1:26
		End if 
	: ($tableName="Contact")
		[WorkOrder:66]company:36:=[Contact:13]company:23
		[WorkOrder:66]address1:50:=[Contact:13]address1:6
		[WorkOrder:66]address2:51:=[Contact:13]address2:7
		[WorkOrder:66]city:52:=[Contact:13]city:8
		[WorkOrder:66]state:53:=[Contact:13]state:9
		[WorkOrder:66]zip:54:=[Contact:13]zip:11
		[WorkOrder:66]lat:72:=[Contact:13]lat:68
		If ([WorkOrder:66]adSource:58="")
			[WorkOrder:66]adSource:58:=[Contact:13]adSource:44
		End if 
		If ([Contact:13]objective:65#Null:C1517)
			[WorkOrder:66]objective:68:=OB Copy:C1225([Contact:13]objective:65)
		End if 
		If ([WorkOrder:66]instructions:55="")
			[WorkOrder:66]instructions:55:=[Contact:13]profile1:18
		End if 
		
		
	: ($tableName="Order")
		[WorkOrder:66]company:36:=[Order:3]company:15
		[WorkOrder:66]address1:50:=[Order:3]address1:16
		[WorkOrder:66]address2:51:=[Order:3]address2:17
		[WorkOrder:66]city:52:=[Order:3]city:18
		[WorkOrder:66]state:53:=[Order:3]state:19
		[WorkOrder:66]zip:54:=[Order:3]zip:20
		[WorkOrder:66]lat:72:=[Order:3]lat:144
		If ([WorkOrder:66]adSource:58="")
			[WorkOrder:66]adSource:58:=[Order:3]adSource:41
		End if 
		If ([Order:3]objective:142#Null:C1517)
			[WorkOrder:66]objective:68:=OB Copy:C1225([Order:3]objective:142)
		End if 
		If ([WorkOrder:66]instructions:55="")
			[WorkOrder:66]instructions:55:=[Order:3]profile1:61
		End if 
		
	: ($tableName="Proposal")
		[WorkOrder:66]company:36:=[Proposal:42]company:11
		[WorkOrder:66]address1:50:=[Proposal:42]address1:12
		[WorkOrder:66]address2:51:=[Proposal:42]address2:13
		[WorkOrder:66]city:52:=[Proposal:42]city:14
		[WorkOrder:66]state:53:=[Proposal:42]state:15
		[WorkOrder:66]zip:54:=[Proposal:42]zip:16
		[WorkOrder:66]lat:72:=[Proposal:42]lat:46
		[WorkOrder:66]lng:73:=[Proposal:42]lng:78
		If ([WorkOrder:66]adSource:58="")
			[WorkOrder:66]adSource:58:=[Proposal:42]adSource:47
		End if 
		If ([Proposal:42]objective:91#Null:C1517)
			[WorkOrder:66]objective:68:=OB Copy:C1225([Proposal:42]objective:91)
		End if 
		If ([WorkOrder:66]instructions:55="")
			[WorkOrder:66]instructions:55:=[Proposal:42]profile1:51
		End if 
End case 