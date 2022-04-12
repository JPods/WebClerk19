//%attributes = {}
If (False:C215)
	// proc: u_ExtractHeader
	// This routine extract values from RFC#822 formatted headers
	
	// $1 -> RFC-822 header
	// $2 -> value name to extract
	// $3 -> default value (optional)
	// $0 <- returned value
End if 

// remove the ending data
$p:=Position:C15(Storage:C1525.char.crlf+Storage:C1525.char.crlf; $1)
If ($p>0)
	$0:=Storage:C1525.char.crlf+Substring:C12($1; 1; $p)+Storage:C1525.char.crlf
Else 
	$0:=Storage:C1525.char.crlf+$1+Storage:C1525.char.crlf
End if 

$p:=Position:C15(Storage:C1525.char.crlf+$2; $0)+2  //+2 because of the CR/LF
If ($p>2)
	$0:=Substring:C12($0; $p)  // kepp only the line we want
	$0:=Substring:C12($0; 1; Position:C15(Storage:C1525.char.crlf; $0)-1)
	
	$0:=Substring:C12($0; Position:C15(":"; $0)+1)  // remove the name of the value
	
	If ($0#"")
		$p:=0  // remove beginning spaces
		While (($0[[$p+1]]=" ") & (($p+1)<Length:C16($0)))
			$p:=$p+1
		End while 
		If ($p>0)
			$0:=Substring:C12($0; $p+1)
		End if 
		If ($0=" ")
			$0:=""
		End if 
	End if 
Else 
	If (Count parameters:C259>2)  // do we have a default value ?
		$0:=$3
	Else 
		$0:=""
	End if 
End if 