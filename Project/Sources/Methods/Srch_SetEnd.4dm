//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/11/19, 13:05:44
// ----------------------------------------------------
// Method: Srch_SetEnd
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20190911_1304 added second parameter for pointer to table


C_TEXT:C284($1)
C_POINTER:C301($2; $vpTable)
If (Count parameters:C259>=2)
	$vpTable:=$2
Else 
	$vpTable:=ptCurTable
End if 

$doSet:=True:C214
Case of 
	: (($1="New Selection") | ($1="Search Selection"))
		$doSet:=False:C215
	: ($1="Union")
		CREATE SET:C116($vpTable->; "New")
		UNION:C120("New"; "Current"; "New")
	: ($1="Intersection")
		CREATE SET:C116($vpTable->; "New")
		INTERSECTION:C121("New"; "Current"; "New")
	: (($1="Difference") | ($1="Reverse"))
		CREATE SET:C116($vpTable->; "New")
		DIFFERENCE:C122("Current"; "New"; "New")
End case 
If ($doSet)
	USE SET:C118("New")
	CLEAR SET:C117("Current")
	CLEAR SET:C117("New")
End if 