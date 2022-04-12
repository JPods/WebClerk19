//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/09, 00:35:14
// ----------------------------------------------------
// Method: Default_Employee
// Description
// 
//
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222(<>aEmpPref; Get last table number:C254)

C_OBJECT:C1216($obCurrentUser; $obSel; $obRec)
C_TEXT:C284($vtCurrentUser)
$vtCurrentUser:=Current user:C182
If ($vtCurrentUser="jitCorp")
	//  QQQZZZ  // ### bj ### 20210801_1414 Must remove after testing
	$vtCurrentUser:="Dale"
End if 
// so we can override in testing
$obRec:=ds:C1482.Employee.query("nameID = :1"; $vtCurrentUser).first()
// Modified by: William James (2013-09-12T00:00:00)
C_OBJECT:C1216($obUser)
C_TEXT:C284($vtUserType)
$vtUserType:="NoEmployeeRec"
//adjust this at some time for Reps, Vendors, etc....
If ($obRec#Null:C1517)
	If ($obRec.preference=Null:C1517)
		$obRec.preference:=New object:C1471("customerComment"; "Order"; "orderComment"; "process"; "salesTrack"; True:C214; "site"; ""; "siteAdder"; "")
		$result_o:=$obRec.save()
	End if 
	$obUser:=New object:C1471("preference"; $obRec.preference)
	$obUser.securityLevel:=$obRec.securityLevel
	$obUser.userType:="Employee"
Else 
	$obUser:=New object:C1471
	$obUser.preference:=New object:C1471("customerComment"; "Order"; "orderComment"; "process"; "salesTrack"; True:C214; "site"; ""; "siteAdder"; "")
	$obUser.securityLevel:=1
	$obUser.userType:="NoEmployeeRec"
End if 
If ($obRec.obGeneral.tables=Null:C1517)
	// need to setup default tables to show for different employees
	$obRec.obGeneral.tables:=New object:C1471("sales"; "Order"; "production"; "Item"; "admin"; "TallyResult")
	$obRec.save()
End if 
$obUser.tables:=$obRec.obGeneral.tables

///  QQQQ
$obUser.testing:=True:C214

If (($obRec.webClerkAutoStart) | ($obRec.nameID="WebClerk@"))
	WC_StartUpShutDownFlip
End if 

If ($obRec.alertOnStartUp)
	DB_SalesService
End if 

Storage_ToNew($obUser; "user")

C_LONGINT:C283($viLevel)
$viLevel:=Storage:C1525.user.securityLevel

Execute_TallyMaster("DefaultSettings"; "Startup")
Execute_TallyMaster(Current user:C182; "Startup")


// ### bj ### 20201127_1955

vlProcessID:=Execute on server:C373("ExecuteText"; 64*1024; String:C10(Count user processes:C343)+"-OnServer"; 0; "setChEmploy"; *)

