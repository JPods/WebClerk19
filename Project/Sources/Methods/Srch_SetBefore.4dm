//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/11/19, 11:41:20
// ----------------------------------------------------
// Method: Srch_SetBefore
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20190911_1304 added second parameter for pointer to table

C_POINTER:C301($2; $vpTable)
If (Count parameters:C259>=2)
	$vpTable:=$2
Else 
	$vpTable:=ptCurTable
End if 

C_TEXT:C284($1)
Case of 
	: (($1="New Selection") | ($1="Search Selection"))
		//no action    
	: ($1="Union")
		CREATE SET:C116($vpTable->; "Current")
	: ($1="Intersection")
		CREATE SET:C116($vpTable->; "Current")
	: ($1="Difference")
		CREATE SET:C116($vpTable->; "Current")
	: ($1="Reverse")
		ALL RECORDS:C47($vpTable->)
		CREATE SET:C116($vpTable->; "Current")
End case 