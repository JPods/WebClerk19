//%attributes = {}
// ----------------------------------------------------
// Method: compareCollection
// Description: Compares the contents of 2 collections and returns True if they contain the same data; returns False otherwise.
// Parameters: $1 & $2 - Collections to compare
// NOTE: Order matters (i.e. ["1";"2"] is not equal to ["2";"1"])
// ----------------------------------------------------
// very valuable for De-Dupping
#DECLARE($vcFirst : Collection; $vcSecond : Collection)->$vbReturn : Boolean

$vbReturn:=False:C215
If (Count parameters:C259>=2)
	
	C_TEXT:C284($container_t)
	C_OBJECT:C1216($container_o)
	
	$container_o:=New object:C1471("content"; $vcFirst)
	$container_t:=JSON Stringify:C1217($container_o)
	$digest1_t:=Generate digest:C1147($container_t; 4D digest:K66:3)
	
	$container_o:=New object:C1471("content"; $vcSecond)
	$container_t:=JSON Stringify:C1217($container_o)
	$digest2_t:=Generate digest:C1147($container_t; 4D digest:K66:3)
	
	$vbReturn:=($digest1_t=$digest2_t)
	
End if 