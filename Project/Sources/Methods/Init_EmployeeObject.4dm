//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/18/21, 18:37:31
// ----------------------------------------------------
// Method: Default_EmployeeObject
// Description
// 
//
// Parameters
// ----------------------------------------------------




// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

If (Count parameters:C259>=1)
	C_TEXT:C284($1; $vtEmployeeNameID)
	$vtEmployeeNameID:=$1
Else 
	$vtEmployeeNameID:=""
End if 



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_OBJECT:C1216($voRec; $voSel)
C_OBJECT:C1216($voSingleEmployeeInfo)


// ******************************************************************************************** //
// ** CREATE AN INTERPROCESS OBJECT TO STORE EMPLOYEE INFO ************************************ //
// ******************************************************************************************** //

// CREATE INTERPROCESS OBJECT

If (($vtEmployeeNameID="") | (<>voEmployeeInfo=Null:C1517))
	If (<>voEmployeeInfo=Null:C1517)
		C_OBJECT:C1216(<>voEmployeeInfo)
		<>voEmployeeInfo:=New object:C1471
	End if 
	$voSel:=ds:C1482.Employee.all()
Else 
	$voSel:=ds:C1482.Employee.query("nameID = '"+$vtEmployeeNameID+"'")
End if 

// FILL IN OBJECT

For each ($voRec; $voSel)
	
	$voSingleEmployeeInfo:=New object:C1471
	
	$voSingleEmployeeInfo.idNum:=$voRec.idNum
	$voSingleEmployeeInfo.nameid:=$voRec.nameid
	$voSingleEmployeeInfo.fullName:=$voRec.nameFirst+" "+$voRec.nameLast
	$voSingleEmployeeInfo.emailAddress:=$voRec.email
	$voSingleEmployeeInfo.active:=$voRec.active
	$voSingleEmployeeInfo.dept:=$voRec.dept
	$voSingleEmployeeInfo.jobTitle:=$voRec.title
	$voSingleEmployeeInfo.role:=$voRec.role
	$voSingleEmployeeInfo.securityLevel:=$voRec.securityLevel
	
	// will update ane existing object
	<>voEmployeeInfo[$voSingleEmployeeInfo.nameid]:=$voSingleEmployeeInfo
	
End for each 