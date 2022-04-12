//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/29/20, 23:04:01
// ----------------------------------------------------
// Method: Time_String
// Description
// 
//
// Parameters
// ----------------------------------------------------

// vtTime:=Time_String( vhTime ; vtFormat )

C_TEXT:C284($0; $2; $vtFormat)
C_TIME:C306($1; $vhTime)

// HH MM         Longint 2     01:02
// HH MM AM PM   Longint 5     1:02 AM
// HH MM SS      Longint 1     01:02:03

If (Count parameters:C259>=1)
	$vhTime:=$1
Else 
	$vhTime:=Current time:C178
End if 

If (Count parameters:C259>=2)
	$vtFormat:=$2
Else 
	$vtFormat:="HH:MM AMPM"
End if 

Case of 
	: ($vtFormat="HHMM")
		
		$0:=Replace string:C233(String:C10($vhTime; HH MM:K7:2); ":"; "")
		
	: ($vtFormat="HHMMSS")
		
		$0:=Replace string:C233(String:C10($vhTime; HH MM SS:K7:1); ":"; "")
		
	: ($vtFormat="HHMMAMPM")
		
		$0:=Replace string:C233(String:C10($vhTime; HH MM AM PM:K7:5); ":"; "")
		
	: ($vtFormat="HH:MM")
		
		$0:=String:C10($vhTime; HH MM:K7:2)
		
	: ($vtFormat="HH:MM:SS")
		
		$0:=String:C10($vhTime; HH MM SS:K7:1)
		
	: ($vtFormat="HH:MM AMPM")
		
		$0:=String:C10($vhTime; HH MM AM PM:K7:5)
		
	Else 
		
		$0:=""
		
End case 
