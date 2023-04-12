//%attributes = {}

// Modified by: Bill James (2022-11-03T05:00:00Z)
// Method: Catalog_lineOut
// Description 
// Parameters
// ----------------------------------------------------
// send out a line of data with fields converted to text
#DECLARE($line_o : Object; $what_t : Text)->$return_t : Text
var $name; $out_t : Text
$return_t:=""
If ($what_t#"header")
	For each ($name; $line_o)
		Case of 
			: ($name="dt@")  // fix time
				$return_t:=$return_t+String:C10($line_o[$name])+"\t"
			: ($name="jt@")  // fix time
				$return_t:=$return_t+String:C10($line_o[$name])+"\t"
			Else 
				$return_t:=$return_t+String:C10($line_o[$name])+"\t"
		End case 
	End for each 
	$return_t:=Substring:C12($return_t; 1; Length:C16($return_t)-1)+"\r"
Else 
	For each ($name; $line_o)
		$return_t:=$return_t+$name+"\t"
	End for each 
	$return_t:=Substring:C12($return_t; 1; Length:C16($return_t)-1)+"\r"
End if 
