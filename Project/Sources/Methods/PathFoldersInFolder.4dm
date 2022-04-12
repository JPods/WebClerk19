//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/30/18, 10:53:59
// ----------------------------------------------------
// Method: PathFoldersInFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------




ARRAY TEXT:C222(aList; 0)  // use a process array so it can be used outside the procedure
C_TEXT:C284($path; $0; $textList)
C_TEXT:C284($sort; $1)
C_TEXT:C284($delim; $2)
C_TEXT:C284($hidePath; $3)
C_LONGINT:C283($i; $k)
$delim:=", "
$textList:=""
$path:=Select folder:C670("Select the desired folder"; "")
If (OK=1)
	If (Count parameters:C259>0)
		$delim:=$1
		If (Count parameters:C259>1)
			$sort:=$2
			If (Count parameters:C259>2)
				$hidePath:=$3
			End if 
		End if 
	End if 
	FOLDER LIST:C473($path; aList)  //  ;*) enhanced not available until 14
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