//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/18/08, 12:53:26
// ----------------------------------------------------
// Method: SuffixGet
// Description
// 
//SuffixGet
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $0; $path)
C_LONGINT:C283($i; $position)

$path:=$1

For ($i; Length:C16($path); 1; -1)
	If ($path[[$i]]=".")
		$position:=$i
		$i:=0
	End if 
End for 

$0:=Substring:C12($path; $position+1)


