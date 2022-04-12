//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/02/20, 11:00:39
// ----------------------------------------------------
// Method: PathImageVariable
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $0; $vtWorking)
C_LONGINT:C283($p)
If (Count parameters:C259>0)
	$vtWorking:=$1
Else 
	$vtWorking:="/Users/williamjames/Documents/CommerceExpert/Customers/TimSpo/Photo-QID-36.png"
End if 
If ($vtWorking="")
	pvItemPathImage:="/images/noimage.jpg"
Else 
	pvItemPathImage:=$vtWorking
	$p:=Position:C15("CommerceExpert"; $vtWorking)
	If ($p>0)
		pvItemPathImage:=Substring:C12($vtWorking; $p+14)
		
	End if 
End if 
$0:=pvItemPathImage
// pvItemPathTN