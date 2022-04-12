//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/14/09, 09:13:04
// ----------------------------------------------------
// Method: FixNAN
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

If (String:C10($1->)="")
	$1->:=0
End if 

If (False:C215)
	If (($1->>0.001) | ($1-><-0.001))
		//do nothing
	Else 
		$1->:=0  //fix NAN problem
	End if 
End if 