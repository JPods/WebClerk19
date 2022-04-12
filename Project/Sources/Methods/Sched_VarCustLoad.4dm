//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/12/06, 03:15:15
// ----------------------------------------------------
// Method: Sched_VarCustLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $loadVar)
$loadVar:=$1
If ($loadVar=1)
	
	iLoText1:=[Customer:2]company:2
	iLoText2:=[Customer:2]phone:13
	iLoText3:=[Customer:2]nameFirst:73
	iLoText4:=[Customer:2]nameLast:23
	iLoText5:=[Customer:2]address1:4
	iLoText6:=[Customer:2]address2:5
	iLoText7:=[Customer:2]city:6
	iLoText8:=[Customer:2]state:7
	iLoText9:=[Customer:2]zip:8
	iLoText10:=[Customer:2]prospect:17
	iLoText11:=[Customer:2]profile1:26
	iLoText12:=[Customer:2]profile2:27
	iLoText13:=[Customer:2]profile3:28
	iLoText14:=[Customer:2]profile4:29
	iLoText15:=[Customer:2]profile5:30
	iLoText16:=[Customer:2]salesNameID:59
	iLoText17:=[Customer:2]repID:58
Else 
	[Customer:2]company:2:=iLoText1
	[Customer:2]phone:13:=iLoText2
	[Customer:2]nameFirst:73:=iLoText3
	[Customer:2]nameLast:23:=iLoText4
	[Customer:2]address1:4:=iLoText5
	[Customer:2]address2:5:=iLoText6
	[Customer:2]city:6:=iLoText7
	[Customer:2]state:7:=iLoText8
	[Customer:2]zip:8:=iLoText9
	[Customer:2]prospect:17:=iLoText10
	[Customer:2]profile1:26:=iLoText11
	[Customer:2]profile2:27:=iLoText12
	[Customer:2]profile3:28:=iLoText13
	[Customer:2]profile4:29:=iLoText14
	[Customer:2]profile5:30:=iLoText15
	[Customer:2]salesNameID:59:=iLoText16
	[Customer:2]repID:58:=iLoText17
	
End if 