//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/17/20, 13:35:40
// ----------------------------------------------------
// Method: URL_Encode
// Description
// 
//
// Parameters
// ----------------------------------------------------


//<declarations>
//==================================
//  Type variables 
//==================================

C_LONGINT:C283($vi1; $vi2; $viCode)
C_TEXT:C284($1; $vtChar; $vtEncoded; $vtString)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi2:=0
$viCode:=0
$vtChar:=""
$vtEncoded:=""
$vtString:=""
//</declarations>

//================================================================  
//  URL Encode  
//================================================================

$vtString:=$1
$vtEncoded:=""

//Console_Log ($vtString)

$vi2:=Length:C16($vtString)

For ($vi1; 1; $vi2)
	
	$vtChar:=$vtString[[$vi1]]
	$viCode:=Character code:C91($vtString[[$vi1]])
	
	Case of 
		: (Match regex:C1019("[A-Za-z0-9_]"; $vtChar; 1))
			
			$vtEncoded:=$vtEncoded+$vtChar
			
		Else 
			
			$vtEncoded:=$vtEncoded+"%"+Substring:C12(String:C10($viCode; "&x"); 5)
			
	End case 
	
End for 

//Console_Log ($vtEncoded)

$0:=$vtEncoded
