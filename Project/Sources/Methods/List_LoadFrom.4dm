//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: List_LoadFrom  
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
//
C_TEXT:C284($1)  //arraynamepopup
C_POINTER:C301($2; $ptPopRay)  // ;ptArray
C_LONGINT:C283($3; $doMore; $k; $i; $w)
If (Count parameters:C259>2)  // 
	$doMore:=$3
Else 
	$doMore:=1
End if 
$ptPopRay:=$2
C_LONGINT:C283($i; $k)
QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=$1)
$k:=Records in selection:C76([PopupChoice:134])
ORDER BY:C49([PopupChoice:134]; [PopupChoice:134]choice:3)

FIRST RECORD:C50([PopupChoice:134])
For ($i; 1; $k)
	If (<>VIDEBUGMODE>410)
		ConsoleLog("[PopupChoice]choice: "+[PopupChoice:134]choice:3)
	End if 
	$w:=Find in array:C230($ptPopRay->; [PopupChoice:134]choice:3)
	If ($w=-1)
		$w:=Size of array:C274($ptPopRay->)+1
		APPEND TO ARRAY:C911($ptPopRay->; [PopupChoice:134]choice:3)
		Case of 
			: ([PopUp:23]arrayName:3="<>aItemsType")
				APPEND TO ARRAY:C911(<>aItemsTypeAlt; [PopupChoice:134]alternate:4)
			: ([PopUp:23]arrayName:3="<>aItemsProfile1")
				APPEND TO ARRAY:C911(<>aItemsProfile1Alt; [PopupChoice:134]alternate:4)
		End case 
	End if 
	NEXT RECORD:C51([PopupChoice:134])
End for 