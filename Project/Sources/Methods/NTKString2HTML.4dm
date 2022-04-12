//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 08:50:06
// ----------------------------------------------------
// Method: NTKString2HTML
// Description
// 
//
// Parameters
// ----------------------------------------------------
// (PM) NTKString2HTML
// $1 = Input text (encoded in MacRoman encoding if not in Unicode mode)
// $1 = Options (0 = full conversion, 1 (don't convert existing HTML tags and entities)
// $0 = HTML encoded text

C_TEXT:C284($1; $0; $input; $output; $replacement)
C_LONGINT:C283($2; $options; $i; $codepoint; $lengthInput)

$input:=$1
If (Count parameters:C259>=2)
	$options:=$2
End if 

// Initialise the array with HTML entities
//NTKString__InitHTMLEntities 


// Replace the characters with their equivalent
$lengthInput:=Length:C16($input)
For ($i; 1; $lengthInput)
	$codepoint:=Character code:C91($input[[$i]])
	Case of 
		: (($codepoint=Tab:K15:37) | ($codepoint=Line feed:K15:40) | ($codepoint=Carriage return:K15:38))
			$replacement:=Char:C90($codepoint)
		: (($codepoint<31) | ($codepoint>255))  // Non-printable characters or characters outside of the Latin 1 range 
			$replacement:="&#"+String:C10($codepoint)+";"
		: (($options=1) & (($codepoint=60) | ($codepoint=62) | ($codepoint=39)))  // Do not convert < > ' 
			$replacement:=Char:C90($codepoint)
		: (<>HTML_Entities{$codepoint}#"")
			$replacement:=<>HTML_Entities{$codepoint}
			If (($options=1) & ($codepoint=38))  // If it's the ampersand character
				If (Substring:C12($input; $i; 8)="&@;@")  // Check if we're already dealing with a HTML entity
					$replacement:="&"  // If so, we should not encode the ampersand
				End if 
			End if 
		Else 
			$replacement:=Char:C90($codepoint)
	End case 
	
	$output:=$output+$replacement
	
End for 

$0:=$output
