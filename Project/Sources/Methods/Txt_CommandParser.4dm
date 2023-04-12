//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-24T00:00:00, 09:40:57
// ----------------------------------------------------
// Method: Txt_CommandParser
// Description
// Modified: 04/24/17
// 
// Parses 4d commands and functions in scripts into array elements
//
// Parameters
// ----------------------------------------------------

// Array Elements generally
// 1 equal return value
// 2 equal command
// 3 comment
// 4 is name
// 5 is purpose
// 6 is security level

C_TEXT:C284($1; $workingText)
C_TEXT:C284($function; $command)
C_POINTER:C301($2)
ARRAY TEXT:C222($arrayElements; 3)
C_LONGINT:C283($p_firstQuote; $p_firstOpen; $p_firstEqual; $p_firstComment)

$workingText:=$1


// See aaaDecConsts for values of <>Constants
$p_firstEqual:=Position:C15(":="; $workingText)
$p_firstQuote:=Position:C15("\""; $workingText)
$p_firstOpen:=Position:C15("("; $workingText)


If (($p_firstEqual>0) & ($p_firstEqual<$p_firstOpen))  // function, not procedure
	$arrayElements{1}:=Substring:C12($workingText; 1; $p_firstEqual-1)  // fill if a function
	$workingText:=Substring:C12($workingText; $p_firstEqual+2)
Else 
	$arrayElements{1}:=""  // nothing if a method
End if 
If ($p_firstOpen=0)  // gets the command
	$arrayElements{2}:=$workingText
Else 
	$arrayElements{2}:=Substring:C12($workingText; 1; $p_firstOpen-1)
	$workingText:=Substring:C12($workingText; $p_firstOpen+1)
	ARRAY TEXT:C222(aText1; 0)
	Txt_2Array($workingText; ->aText1; ";")
	C_LONGINT:C283($incArray; $cntArray)
	$cntArray:=Size of array:C274(aText1)
	$workingText:=aText1{$cntArray}
	$p_firstComment:=Position:C15(Storage:C1525.char.comment; $workingText)
	If ($p_firstComment>0)
		$arrayElements{3}:=Substring:C12($workingText; $p_firstComment)
		$workingText:=Substring:C12($workingText; 1; $p_firstComment-1)
	End if 
	// should have added name, purpose, security level to $arrayElements
	
	For ($incArray; 1; $cntArray)
		//aText1{$incArray}:=Preg Replace ("(?im)^\\s*";"";aText1{$incArray})
		//aText1{$incArray}:=Preg Replace ("(?im)\\s*$";"";aText1{$incArray})
		aText1{$incArray}:=Txt_TrimSpaces(aText1{$incArray})  // ### jwm ### 20170503_1632
		// Convert Current User if passed as a parameter // #### TEST #####
		
		APPEND TO ARRAY:C911($arrayElements; aText1{$incArray})
	End for 
	ARRAY TEXT:C222(aText1; 0)
	
	// check to see if the value is a text string, field, variable for name and purpose
	$cntArray:=$cntArray+3  // add to the return value {1}, comment in {2}, everything after the closeing )
	$arrayElements{$cntArray}:=Tx_ClipFromFrontToLastDelim($arrayElements{$cntArray}; ")")
	// working Name and Purpose
	For ($incArray; 4; 5)  // ### jwm ### 20170426_1639 too complex !!!
		If (Length:C16($arrayElements{$incArray})>0)
			Case of 
				: ($arrayElements{$incArray}="Current User")
					$arrayElements{$incArray}:=Txt_Quoted(Current user:C182)  // ### jwm ### 20170504_0103
				: ($arrayElements{$incArray}="Current Machine")
					$arrayElements{$incArray}:=Txt_Quoted(Current machine:C483)  // ### jwm ### 20170504_0103
					// might need more special functions
					
				: ($arrayElements{$incArray}[[1]]="[")
					C_POINTER:C301($ptField)
					C_LONGINT:C283($theType)
					$ptField:=PointerFromName($arrayElements{$incArray})
					If (Is nil pointer:C315($ptField))  // ### jwm ### 20170426_1650 check for NIL Pointer
						$arrayElements{3}:=$arrayElements{3}+" // NIL POINTER: "+$arrayElements{$incArray}
						ConsoleLog($arrayElements{3})
						// leave the value in the array element as is
					Else 
						
						$theType:=Type:C295($ptField->)
						Case of   // only looking at longint and text value, may need to expand to all types
							: ($theType=Is longint:K8:6)
								$arrayElements{$incArray}:=Txt_Quoted(String:C10($ptField->))
							Else 
								$arrayElements{$incArray}:=Txt_Quoted($ptField->)
						End case 
					End if 
					
				: ($arrayElements{$incArray}[[1]]="\"")
					$arrayElements{$incArray}:=Substring:C12($arrayElements{$incArray}; 2; Length:C16($arrayElements{$incArray})-2)
				Else 
					C_POINTER:C301($ptVariable)
					C_LONGINT:C283($theType)
					$ptVariable:=Get pointer:C304($arrayElements{$incArray})
					If (Is nil pointer:C315($ptVariable))  // ### jwm ### 20170503_1423
						$arrayElements{3}:=$arrayElements{3}+" // NIL POINTER: "+$arrayElements{$incArray}
						ConsoleLog($arrayElements{3})
					Else 
						
						$theType:=Type:C295($ptVariable->)
						Case of 
							: ($theType=Is longint:K8:6)
								$arrayElements{$incArray}:=Txt_Quoted(String:C10($ptVariable->))
							Else 
								$arrayElements{$incArray}:=Txt_Quoted($ptVariable->)
						End case 
					End if 
			End case 
		End if 
	End for 
	COPY ARRAY:C226($arrayElements; $2->)
End if 
