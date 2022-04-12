//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/03/16, 13:12:39
// ----------------------------------------------------
// Method: ConvertPictureLibrary
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($vlPict; $vPictCount; $vPictRef; $vTotal)
C_TEXT:C284($vPictName)
C_POINTER:C301($vPointer)
C_PICTURE:C286($vpPict)
ARRAY TEXT:C222($arrPictNames; 0)
ARRAY LONGINT:C221($arrPictRefs; 0)

$vTotal:=0
PICTURE LIBRARY LIST:C564($arrPictRefs; $arrPictNames)
$vPictCount:=Size of array:C274($arrPictRefs)
If ($vPictCount>0)
	For ($vlPict; 1; $vPictCount)  // for each picture
		$vPictRef:=$arrPictRefs{$vlPict}
		$vPictName:=$arrPictNames{$vlPict}
		GET PICTURE FROM LIBRARY:C565($arrPictRefs{$vlPict}; $vpPict)
		$vPointer:=->$vpPict  // pass a pointer
		// 161025 Fixed Deprecated Command
		// $isObs:=AP Is Picture Deprecated ($vPointer)
		TRACE:C157  // will not work as commented out
		If ($isObs=1)  // if format is obsolete
			CONVERT PICTURE:C1002($vPointer->; ".PNG")  // conversion to png
			// and saving in library
			SET PICTURE TO LIBRARY:C566($vPointer->; $vPictRef; $vPictName)
			$vTotal:=$vTotal+1
		End if 
	End for 
	ALERT:C41(String:C10($vTotal)+" picture(s) out of "+String:C10($vPictCount)+" were converted to png.")
Else 
	ALERT:C41("The picture library is empty.")
End if 

