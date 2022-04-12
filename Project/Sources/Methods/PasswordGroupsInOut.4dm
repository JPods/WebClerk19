//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/25/09, 12:42:49
// ----------------------------------------------------
// Method: PasswordGroupsInOut
// Description
// 
//
// Parameters

If (UserInPassWordGroup("AdminControl"))
	C_LONGINT:C283($1; $inout)
	If (Count parameters:C259=1)
		$inout:=$1
	Else 
		$inout:=0
	End if 
	
	
	C_LONGINT:C283(bPWCreate; bPWChange)
	//TRACE
	C_LONGINT:C283(bPWCreate; bPWChange)
	ARRAY TEXT:C222($aGroupNames; 0)
	ARRAY LONGINT:C221($aGroupNums; 0)
	ARRAY TEXT:C222($aUserNames; 0)
	ARRAY LONGINT:C221($aUserNum; 0)
	If ($inOut=0)
		GET GROUP LIST:C610($aGroupNames; $aGroupNums)
		$k:=Size of array:C274($aGroupNames)
		C_TEXT:C284($fullPass)
		$fullPass:="aGroupNums"+"\t"+"aGroupNames"+"\t"+"iOwnerID"+"\t"+"aUserNames"+"\t"+"packPassGroups"+"\r"
		GET USER LIST:C609($aUserNames; $aUserNum)
		For ($i; 1; $k)
			ARRAY LONGINT:C221($aGroupRay; 0)
			GET GROUP PROPERTIES:C613($aGroupNums{$i}; $aGroupNames{$i}; $iOwnerID; $aGroupRay)
			C_LONGINT:C283($incRay; $cntRay)
			$cntRay:=Size of array:C274($aGroupRay)
			C_TEXT:C284($packPassGroups)
			$packPassGroups:=""
			If ($cntRay>0)
				$packPassGroups:=String:C10($aGroupRay{1})
				For ($incRay; 2; $cntRay)
					$packPassGroups:=$packPassGroups+","+String:C10($aGroupRay{$incRay})
				End for 
			End if 
			$w:=Find in array:C230($aUserNum; $iOwnerID)
			$fullPass:=$fullPass+String:C10($aGroupNums{$i})+"\t"+$aGroupNames{$i}+"\t"+String:C10($iOwnerID)+"\t"+$aUserNames{$w}+"\t"+$packPassGroups+"\r"
		End for 
		
		SET TEXT TO PASTEBOARD:C523($fullPass)
	Else 
		CONFIRM:C162("Import Users and Groups from Clipboard?")
		If (OK=1)
			CONFIRM:C162("Import Users and Groups from Clipboard?")
			If (OK=1)
				$fullPass:=Get text from pasteboard:C524
				TextToArray($fullPass; ->aText2; "\r")
				C_LONGINT:C283($incGroups; $cntGroups; $incCodes; $cntCodes)
				$cntGroups:=Size of array:C274(aText2)
				For ($incGroups; 2; $cntGroups)  //skip the header
					TextToArray(aText2{$incGroups}; ->aText1; "\t")
					If (Size of array:C274(aText1)=5)
						TextToArray(aText1{5}; ->aText3; ",")
						$cntCodes:=Size of array:C274(aText3)
						ARRAY LONGINT:C221($aGroupList; $cntCodes)
						For ($incCodes; 1; $cntCodes)
							$aGroupList{$incCodes}:=(-1)*(Num:C11(aText3{$incCodes}))
						End for 
						Set group properties:C614(Num:C11(aText1{1}); aText1{2}; Num:C11(aText1{3}); $aGroupList)  //number; name; owner;
					End if 
				End for 
			End if 
		End if 
	End if 
End if 