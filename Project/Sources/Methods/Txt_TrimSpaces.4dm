//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/03/17, 16:30:28
// ----------------------------------------------------
// Method: Txt_TrimSpaces
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: Txt_TrimSpaces

C_TEXT:C284($0)  //Resulting string w/o leading or trailing spaces
C_TEXT:C284($1; $Str; $result; $unwanted)
$unwanted:=Char:C90(Space:K15:42)

If (Count parameters:C259=0)
	$Str:="  Space Trimmer    "
Else   //(Count parameters=1)
	$Str:=$1
	If (Count parameters:C259>1)
		$unwanted:=$2
	End if 
End if 

//MyTestAlert ($1)
//Trim leading spaces
If (Length:C16($Str)>0)
	While (Length:C16($Str)>0)
		// ### bj ### 20180930_1650
		// If ((($Str[[1]])=" ") | (Character code($Str[[1]])<14) | (Character code($Str[[1]])>200))
		If ((($Str[[1]])=$unwanted) | (Character code:C91($Str[[1]])<14))
			If (Length:C16($Str)>1)
				$Str:=Substring:C12($Str; 2)
			Else 
				$Str:=""
			End if 
		Else 
			$result:=$Str
			$Str:=""
		End if 
	End while 
	
	$Str:=$result
	//Trim trailing spaces
	//If (Length($Str)>0)
	$stingLength:=Length:C16($Str)
	While ($stingLength>0)
		// ### bj ### 20180930_1651
		// If (($Str[[$stingLength]]=" ") | (Character code($Str[[$stingLength]])<14) | (Character code($Str[[$stingLength]])>200))
		If (($Str[[$stingLength]]=$unwanted) | (Character code:C91($Str[[$stingLength]])<14))  // | (Character code($Str[[$stingLength]])>200))
			If ($stingLength>1)
				$Str:=Substring:C12($Str; 1; $stingLength-1)
			Else 
				$Str:=""
			End if 
		Else 
			$result:=$Str
			$Str:=""
		End if 
		$stingLength:=Length:C16($Str)
	End while 
	$0:=$result
Else 
	$0:=""
End if 