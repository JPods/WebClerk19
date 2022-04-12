//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:16:28
// ----------------------------------------------------
// Method: PassWordCreate
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("AdminControl"))
	C_LONGINT:C283($1; $doThis)
	If (Count parameters:C259=0)
		KeyModifierCurrent
		If (OptKey=0)
			$doThis:=0
		Else 
			$doThis:=Num:C11(Request:C163("0 build, 1 add, 2 pack"; "0"))
		End if 
	Else 
		$doThis:=$1
	End if 
	//
	C_TEXT:C284($userName)
	C_LONGINT:C283($i; $k; $userNum; $w)
	ARRAY TEXT:C222($aUserNames; 0)
	ARRAY LONGINT:C221($aUserNum; 0)
	C_TEXT:C284($userName; $userPassword; $userStartup; $userPassword)
	C_DATE:C307($userDate)
	C_LONGINT:C283($numLogIns)
	ARRAY LONGINT:C221($aGroupRay; 0)
	//
	GET USER LIST:C609($aUserNames; $aUserNum)
	$k:=Size of array:C274($aUserNum)
	Case of 
		: ($doThis=0)
			For ($i; 1; $k)
				If ($aUserNum{$i}<0)
					QUERY:C277([Employee:19]; [Employee:19]nameid:1=$aUserNames{$i})
					If (Records in selection:C76([Employee:19])=1)
						$userNum:=$aUserNum{$i}
						//$userName:=$aUserNames{$i}
						GET USER PROPERTIES:C611($userNum; $userName; $userStartup; $userPassword; $numLogIns; $userDate)
						C_LONGINT:C283($incRay; $cntRay)
						$cntRay:=Size of array:C274($aGroupRay)
						C_TEXT:C284($packPassGroups)
						$packPassGroups:=""
						For ($incRay; 1; $cntRay)
							$packPassGroups:=$packPassGroups+String:C10($aGroupRay{$incRay})
						End for 
						[Employee:19]passwordGroups:48:=$packPassGroups
						[Employee:19]password:47:=""
						SAVE RECORD:C53([Employee:19])
					End if 
					DELETE USER:C615($aUserNum{$i})
				End if 
			End for 
			Set user properties:C612(-1; "JITCorp"; ""; "tkt"; 0; !00-00-00!)
			QUERY:C277([Employee:19]; [Employee:19]clientServerUser:56=True:C214)
			$k:=Records in selection:C76([Employee:19])
			FIRST RECORD:C50([Employee:19])
			For ($i; 1; $k)
				TextToArray([Employee:19]passwordGroups:48; ->aText8)
				$cntRay:=Size of array:C274(aText8)
				ARRAY LONGINT:C221($aGroupRay; $cntRay)
				For ($incRay; 1; $cntRay)
					$aGroupRay:=Num:C11(aText8{$incRay})
				End for 
				$w:=Set user properties:C612(-2; [Employee:19]nameid:1; ""; [Employee:19]password:47; 0; !00-00-00!; $aGroupRay)
				NEXT RECORD:C51([Employee:19])
			End for 
		: ($doThis=1)
			$k:=Records in selection:C76([Employee:19])
			FIRST RECORD:C50([Employee:19])
			For ($i; 1; $k)
				$w:=Find in array:C230($aUserNames; [Employee:19]nameid:1)
				If ($w<0)
					TextToArray([Employee:19]passwordGroups:48; ->aText8)
					$cntRay:=Size of array:C274(aText8)
					ARRAY LONGINT:C221($aGroupRay; $cntRay)
					For ($incRay; 1; $cntRay)
						$aGroupRay:=Num:C11(aText8{$incRay})
					End for 
					$userName:=[Employee:19]nameid:1
					$userNum:=Set user properties:C612(-2; $userName; ""; ""; 0; !00-00-00!; $aGroupRay)
				End if 
				NEXT RECORD:C51([Employee:19])
			End for 
		: ($doThis=2)
			$w:=Find in array:C230($aUserNames; [Employee:19]nameid:1)
			If ($w>0)
				BEEP:C151  //ALERT("User already exists")
			Else 
				$w:=Set user properties:C612(-2; [Employee:19]nameid:1; ""; [Employee:19]password:47; 0; !00-00-00!; $aGroupRay)
			End if 
		: ($doThis=3)
			$w:=Find in array:C230($aUserNames; [Employee:19]nameid:1)
			If ($w>0)
				$userNum:=$aUserNum{$w}
				
				GET USER PROPERTIES:C611($userNum; $userName; $userStartup; $userPassword; $numLogIns; $userDate; $aGroupRay)
				C_LONGINT:C283($incRay; $cntRay)
				$cntRay:=Size of array:C274($aGroupRay)
				C_TEXT:C284($packPassGroups)
				$packPassGroups:=""
				For ($incRay; 1; $cntRay)
					$packPassGroups:=$packPassGroups+String:C10($aGroupRay{$incRay})
				End for 
				[Employee:19]passwordGroups:48:=$packPassGroups
				[Employee:19]password:47:=""
				SAVE RECORD:C53([Employee:19])
				DELETE USER:C615($userNum)
			End if 
	End case 
	
	
	If (False:C215)  //simple passwords
		C_LONGINT:C283($kQA; $k; $iQA; $i)
		
		$k:=Records in selection:C76([Customer:2])
		FIRST RECORD:C50([Customer:2])
		TRACE:C157
		For ($i; 1; $k)
			MESSAGE:C88(String:C10($i))
			QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10=[Customer:2]customerID:1)
			[RemoteUser:57]userPassword:3:=[Customer:2]customerID:1
			[RemoteUser:57]userName:2:=[Customer:2]nameFirst:73
			SAVE RECORD:C53([RemoteUser:57])
			NEXT RECORD:C51([Customer:2])
		End for 
	End if 
	REDRAW WINDOW:C456
End if 