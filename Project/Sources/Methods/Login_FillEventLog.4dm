//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/04/21, 16:41:41
// ----------------------------------------------------
// Method: Login_FillEventLog
// Description
// 
// Parameters
// ----------------------------------------------------




// ### bj ### 20210921_1215
//var $1; $tableName : Text
//$tableName:=$1
obEventLog.idRemoteUser:=obRemoteUser.id
obEventLog.idPrimary:=obRemoteUser.idPrimary
obEventLog.tableName:=obRemoteUser.tableName
Case of 
	: (obRemoteUser.tableName="Employee")
		obEventLog.securityLevelWCC:=obRemoteUser.securityLevel
End case 
$result_o:=obEventLog.save()

obRemoteUser.idEventLog:=obEventLog.id
$result_o:=obRemoteUser.save()

