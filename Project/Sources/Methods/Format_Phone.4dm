//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 03/02/15, 11:41:16
// ----------------------------------------------------
// Method: Format_Phone
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150302_1118 EXT Not first character
If (False:C215)
	C_LONGINT:C283($i; $k; $w; $len)
	C_TEXT:C284($1; $0; $extStr)
	$w:=Position:C15("ext"; $1)
	// ### jwm ### 20150302_1118 EXT Not first character changed to > 1
	If ($w>1)  // Modified by: williamjames (111216 checked for <= length protection) should be $w>1
		$extStr:=" "+Substring:C12($1; $w)
		If ($1[[($w-1)]]=" ")
			$w:=$w-1
		End if 
		$1:=Substring:C12($1; 1; $w-1)
	End if 
	$len:=Length:C16($1)
	Case of 
		: ($1="011")
			$0:=$1
		: ($len=10)
			$0:="("+Substring:C12($1; 1; 3)+") "+Substring:C12($1; 4; 3)+"-"+Substring:C12($1; 7; 4)+$extStr
		: ($len=7)
			$0:=Substring:C12($1; 1; 3)+"-"+Substring:C12($1; 4; 4)+$extStr
		: ($w<=1)  // ### jwm ### 20150302_1157 Ext first character don't format
			$0:=$1
		Else 
			For ($i; 1; $len; 4)
				$0:=Substring:C12($1; $i; 4)+("-"*Num:C11($len-$i>3))
			End for 
	End case 
End if 

C_TEXT:C284($1; $0)  // from Format_Phone
C_LONGINT:C283($w; $len)
C_TEXT:C284($ext)
$w:=Position:C15("ext"; $1)
//TRACE
If ($w>1)
	If ($1[[($w-1)]]=" ")
		$w:=$w-1
	End if 
	$len:=$w-1  //get to befor the first letter of ext
	$ext:=Substring:C12($1; $w; Length:C16($1))
Else 
	$len:=Length:C16($1)
	$ext:=""
End if 
Case of 
	: ($len=0)
		$0:=""
	: (Position:C15("("; $1)>0)
		$0:=$1
	: (Position:C15("-"; $1)>0)
		$0:=$1
	: (Position:C15("."; $1)>0)
		$0:=$1
	: ((<>vbIgnoreFone=True:C214) | (Substring:C12($1; 1; 3)="011"))
		$0:=$1
	: ($len=7)
		$0:=Substring:C12($1; 1; 3)+"-"+Substring:C12($1; 4; 4)+$ext
	: ($len=10)
		$0:="("+Substring:C12($1; 1; 3)+") "+Substring:C12($1; 4; 3)+"-"+Substring:C12($1; 7; 4)+$ext
	Else 
		C_TEXT:C284($tempStr)
		C_LONGINT:C283($index; $index2)
		$index:=1
		$index2:=1
		While ($index<=Length:C16(<>vAltFoneFor))
			If (<>vAltFoneFor[[$index]]="#")
				If ($index2<=$len)
					$tempStr:=$tempStr+$1[[$index2]]
					$index2:=$index2+1
				Else 
					$index:=32000  //terminate
				End if 
			Else 
				$tempStr:=$tempStr+<>vAltFoneFor[[$index]]
			End if 
			$index:=$index+1
		End while 
		If ($index2<=$len)  //$index2 is 1 greater then the number used so far
			$tempStr:=$tempStr+Substring:C12($1; $index2; ($len-$index2)+1)
		End if 
		$0:=$tempStr+$ext
End case 

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): jmedlen
	// Date and time: 04/19/10, 17:08:53
	// ----------------------------------------------------
	// Method: //  Put  the formating in the form  jFormatPhone
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// ### jwm ### 20150302_1118 test Length of phone number
	
	
	C_TEXT:C284($1; $working_t; $0)
	C_LONGINT:C283($i; $k; $w; $len)
	C_TEXT:C284($extFormat)
	KeyModifierCurrent
	$k:=Count parameters:C259
	$working_t:=$1
	$len:=-1
	If (optKey=0)
		If ((<>vbIgnoreFone=False:C215) & (Substring:C12($working_t; 1; 3)#"011"))
			$p:=Position:C15(";"; $working_t)
			If ($p=0)
				$p:=Position:C15(" "; $working_t)
			End if 
			If ($p=0)
				$p:=Position:C15("-"; $working_t)
			End if 
			If ($p=0)
				$p:=Position:C15("/"; $working_t)
			End if 
			If ($p=0)
				$p:=Position:C15(")"; $working_t)
			End if 
			If ($p=0)
				$p:=Position:C15("("; $working_t)
			End if 
			If ($p=0)
				$p:=Position:C15("."; $working_t)
			End if 
			If ($p=0)
				$p:=Position:C15(","; $working_t)
			End if 
			If ($p>0)
				$working_t:=Replace string:C233(Replace string:C233(Replace string:C233($working_t; " "; ""); "-"; ""); "/"; "")
				$working_t:=Replace string:C233(Replace string:C233(Replace string:C233($working_t; "("; ""); ")"; ""); "."; "")
			End if 
		End if 
		
		Case of 
				
			: ((Position:C15("ext"; $working_t))>0)
				$w:=Position:C15("ext"; $working_t)
				If ($w>1)  // ### jwm ### 20150302_1118 EXT Not first character
					If ($working_t[[($w-1)]]=" ")
						$w:=$w-1
					End if 
					$len:=$w-1  //get to before the first letter of ext
					$extFormat:=" ### "+("#"*(Length:C16($working_t)-($w+2)))
				Else 
					$len:=Length:C16($working_t)
					$extFormat:=""
				End if 
			: ((Position:C15("x"; $working_t))>0)
				$w:=Position:C15("x"; $working_t)
				If ($w>1)  // ### jwm ### 20150302_1118 EXT Not first character
					If ($working_t[[($w-1)]]=" ")
						$w:=$w-1
					End if 
					$len:=$w-1  //get to before the first letter of ext
					$extFormat:=" # "+("#"*(Length:C16($working_t)-($w)))
				Else 
					$len:=Length:C16($working_t)
					$extFormat:=""
				End if 
			Else 
				$len:=Length:C16($working_t)
				$extFormat:=""
				
		End case 
		
	End if 
	Case of 
		: ($len=0)
			OBJECT SET FORMAT:C236($working_t; "(###) ###-####"+$extFormat)
		: ((Position:C15("."; $working_t)>0) | (Position:C15("-"; $working_t)>0) | (Substring:C12($working_t; 1; 3)="011"))
			OBJECT SET FORMAT:C236($working_t; "#"*(Length:C16($working_t)))
		: ($len=7)
			OBJECT SET FORMAT:C236($working_t; "###-####"+$extFormat)
		: ($len=10)
			OBJECT SET FORMAT:C236($working_t; "(###) ###-####"+$extFormat)
		Else 
			OBJECT SET FORMAT:C236($working_t; <>vAltFoneFor+$extFormat)
	End case 
	
	$0:=$working_t
	
	
End if 
