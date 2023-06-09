//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-24T00:00:00, 05:19:49
// ----------------------------------------------------
// Method: CR_CreateAlways
// Description
// Modified: 06/24/17
// 
// 
//
// Parameters
// ----------------------------------------------------

// do a set in an outside wrapper
// CREATE SET([CallReport];"Current")
// CREATE RECORD([CallReport])


C_LONGINT:C283($1)
C_TEXT:C284($2; $3; $4; $comment; $5; $email; $6; $profile)
$doRecord:=False:C215
If (Count parameters:C259>2)
	$doRecord:=True:C214
	// $1 is tableNum
	// $2 is accountID
	// $3 is action
	If (Count parameters:C259>3)
		$comment:=$4
		If (Count parameters:C259>4)
			$email:=$5
			If (Count parameters:C259>5)
				$profile:=$6
			End if 
		End if 
	End if 
End if 
If ($doRecord)
	CREATE RECORD:C68([Call:34])
	[Call:34]tableNum:2:=$1
	[Call:34]customerID:1:=$2
	[Call:34]actionBy:3:=Current user:C182
	[Call:34]initiatedBy:23:=Current user:C182
	[Call:34]dtAction:4:=DateTime_DTTo
	[Call:34]dateDocument:17:=!2017-06-01!  // Current date
	[Call:34]complete:7:=True:C214
	[Call:34]action:15:=$3
	[Call:34]comment:16:=$comment
	[Call:34]email:38:=$email
	[Call:34]profile1:26:=$profile
	SAVE RECORD:C53([Call:34])
End if 


//  ADD TO SET([CallReport];"Current")
//  USE SET("Current")
//  CLEAR SET("Current")