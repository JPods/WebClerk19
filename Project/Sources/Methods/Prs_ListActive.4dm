//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/07/09, 19:15:08
// ----------------------------------------------------
// Method: Prs_ListActive
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($index)
C_LONGINT:C283($tasks; $prsNum; $state; $tics)
C_TEXT:C284($name)
If (Count parameters:C259=0)
	var $processNum : Integer
	$processNum:=New process:C317("Prs_ListActive"; 0; "Internal"; "startup")
Else 
	DELAY PROCESS:C323(Current process:C322; 20)  // let the calling process close
	$tasks:=Count tasks:C335
	C_LONGINT:C283($fia)
	C_LONGINT:C283($dtLaunch)
	$dtLaunch:=DateTime_Enter
	ARRAY TEXT:C222(<>aPrsName; 0)
	ARRAY LONGINT:C221(<>aPrsNum; 0)
	ARRAY LONGINT:C221(<>aPrsDTActiv; 0)
	ARRAY TEXT:C222(<>aPrsNameWeb; 0)
	ARRAY LONGINT:C221(<>aPrsNumWeb; 0)
	//KeyModifierCurrent 
	For ($index; 1; $tasks)
		If (Process state:C330($index)>-1)
			$prsNum:=$index
			PROCESS PROPERTIES:C336($prsNum; $name; $state; $tics)
			Case of 
				: (($name="WC_@") | ($name="Log@"))
					$fia:=Size of array:C274(<>aPrsNameWeb)+1
					APPEND TO ARRAY:C911(<>aPrsNameWeb; $name)
					APPEND TO ARRAY:C911(<>aPrsNumWeb; $prsNum)
					
					If ((<>ProcessAll) | ($name="Log@"))  //($name="htt@"))
						$fia:=Size of array:C274(<>aPrsNum)+1
						APPEND TO ARRAY:C911(<>aPrsName; $name)
						APPEND TO ARRAY:C911(<>aPrsNum; $prsNum)
						APPEND TO ARRAY:C911(<>aPrsDTActiv; $dtLaunch)
					End if 
					
				: (($name="Cache Man@") | ($name="$@"))
					
				: (($name="WebClerkPro@") | ($name="User/Cust@") | ($name="Design process@"))
					
				: (($name="Internal@") | ($name="Apple Events Ma@"))  // | ($prsNum>-1))  //&($name="Processes@")
					
					
				Else 
					// : (($name#"Cache Manager@") & ($name#"$@") & ($name#"WebClerkProcess@") & ($name#"User/Cust@") & ($name#"Design process@") & ($name#"Internal@") & ($name#"Apple Events Ma@") & ($prsNum>-1))  //&($name#"Processes@")
					If ($prsNum=1)  //Changes name of "User/Customer Menus"
						$name:="Main"
					End if 
					//($name#"User/Custom M@")&       need to have this 'Main' to rebuild Sales if 
					//$fia:=Find in array(<>aPrsNum;$prsNum)
					//If ($fia=-1)
					
					APPEND TO ARRAY:C911(<>aPrsName; $name)
					APPEND TO ARRAY:C911(<>aPrsNum; $prsNum)
					APPEND TO ARRAY:C911(<>aPrsDTActiv; $dtLaunch)
			End case 
		End if 
	End for 
	
	If (False:C215)
		$prsNum:=Find in array:C230(<>aPrsName; "Processes")
		If ($prsNum>0)
			If (<>aPrsNum{$prsNum}#Current process:C322)
				POST OUTSIDE CALL:C329(<>aPrsNum{$prsNum})  //<>theProcessList)
			Else 
				REDRAW WINDOW:C456
			End if 
		End if 
	End if 
End if 