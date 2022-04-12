//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/29/18, 17:06:40
// ----------------------------------------------------
// Method: ListDocumentsInFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------

KeyModifierCurrent
ARRAY TEXT:C222(aList; 0)  // use a process array so it can be used outside the procedure
C_TEXT:C284($path; $0; $textList)
C_TEXT:C284($sort; $1)
C_TEXT:C284($delim; $2)
C_TEXT:C284($hidePath; $3)
C_LONGINT:C283($4; $options)
C_LONGINT:C283($i; $k)
$delim:=", "
$textList:=""
$hidePath:="showPath"
$options:=0
If (OptKey=1)
	$options:=Recursive parsing:K24:13
End if 
If (ShftKey=1)
	$options:=$options+Posix path:K24:15
End if 
If (CmdKey=1)
	$options:=$options+Ignore invisible:K24:16
End if 
$path:=Select folder:C670("Select the desired folder"; "")
If (OK=1)
	If (Count parameters:C259>0)
		$delim:=$1
		If (Count parameters:C259>1)
			$sort:=$2
			If (Count parameters:C259>2)
				$hidePath:=$3
				If ((Count parameters:C259>3) & ($options=0))
					$options:=$4
				End if 
			End if 
		End if 
		If (False:C215)
			$options:=Absolute path:K24:14+Ignore invisible:K24:16+Posix path:K24:15+Recursive parsing:K24:13
		End if 
		DOCUMENT LIST:C474($path; aList; $options)  //  ;*) enhanced not available until 14
		Case of 
			: ($sort="<")
				SORT ARRAY:C229(aList; <)
			: ($sort=">")
				SORT ARRAY:C229(aList; >)
			Else 
				//  no sort
		End case 
		
		If ($hidePath#"hide@")
			$textList:=$path+"\r"
		End if 
		
		$k:=Size of array:C274(aList)
		For ($i; 1; $k)
			$textList:=$textList+aList{$i}
			If ($i<$k)
				$textList:=$textList+$delim
			End if 
		End for 
	End if 
	$0:=$textList
End if 