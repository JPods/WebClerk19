//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/28/09, 17:21:36
// ----------------------------------------------------
// Method: Method: PasswordUsersInOut
// Description
// 
//
// Parameters
// ----------------------------------------------------
TRACE:C157
If (UserInPassWordGroup("AdminControl"))
	C_LONGINT:C283($1; $theTask)
	If (Count parameters:C259=1)
		$theTask:=$1
	Else 
		$theTask:=10
	End if 
	C_BLOB:C604($myBlob)
	Case of 
		: ($theTask=1)
			CONFIRM:C162("Save Users")
			If (OK=1)
				myDoc:=Create document:C266("")
				If (OK=1)
					CLOSE DOCUMENT:C267(myDoc)
					USERS TO BLOB:C849($myBlob)
					BLOB TO DOCUMENT:C526(document; $myBlob)
				End if 
			End if 
		: ($theTask=2)
			CONFIRM:C162("Load Users")
			If (OK=1)
				myDoc:=Open document:C264("")
				If (OK=1)
					CLOSE DOCUMENT:C267(myDoc)
					DOCUMENT TO BLOB:C525(document; $myBlob)
					If (BLOB size:C605($myBlob)>0)
						BLOB TO USERS:C850($myBlob)
					End if 
				End if 
			End if 
			
		: ($theTask=10)
			CONFIRM:C162("Get User Properties")
			If (OK=1)
				C_TEXT:C284($fullPass)
				$fullPass:="UserNum"+"\t"+"Name"+"\t"+"Startup"+"\t"+"password"+"\t"+"numOfLogIns"+"\t"+"lastLogIn"+"\t"+"grpOwner"+"\t"+"membershipRay"+"\r"
				ARRAY TEXT:C222($aUserNames; 0)
				ARRAY LONGINT:C221($aUserNums; 0)
				GET USER LIST:C609($aUserNames; $aUserNums)
				$k:=Size of array:C274($aUserNames)
				//
				C_TEXT:C284($userName; $theStartup; $userPassword)
				C_LONGINT:C283($numLogIns; $numGroupOwner)
				C_DATE:C307($lastLogIn)
				ARRAY LONGINT:C221($aGroupRay; 0)
				For ($i; 1; $k)
					If (Not:C34(Is user deleted:C616($aUserNums{$i})))
						GET USER PROPERTIES:C611($aUserNums{$i}; $userName; $theStartup; $userPassword; $numLogIns; $lastLogIn; $aGroupRay; $numGroupOwner)
						C_LONGINT:C283($incRay; $cntRay)
						$cntRay:=Size of array:C274($aGroupRay)
						C_TEXT:C284($packPassGroups)
						If ($cntRay>0)
							$packPassGroups:=String:C10($aGroupRay{1})
							For ($incRay; 2; $cntRay)
								$packPassGroups:=$packPassGroups+","+String:C10($aGroupRay{$incRay})
							End for 
						End if 
						$fullPass:=$fullPass+String:C10($aUserNums{$i})+"\t"+$userName+"\t"+$theStartup+"\t"+$userPassword+"\t"+String:C10($numLogIns)+"\t"+String:C10($lastLogIn)+"\t"+String:C10($numGroupOwner)+"\t"+$packPassGroups+"\r"
					End if 
				End for 
				SET TEXT TO PASTEBOARD:C523($fullPass)
			End if 
		: ($theTask=20)
			CONFIRM:C162("Get User Properties")
			If (OK=1)
				$fullPass:=Get text from pasteboard:C524
				TextToArray($fullPass; ->aText2; "\r")
				C_LONGINT:C283($incGroups; $cntGroups; $incCodes; $cntCodes)
				$cntGroups:=Size of array:C274(aText2)
				For ($incGroups; 2; $cntGroups)  //skip the header
					TextToArray(aText2{$incGroups}; ->aText1; "\t"; True:C214)
					If (Size of array:C274(aText1)=8)
						TextToArray(aText1{8}; ->aText3; ",")
						$cntCodes:=Size of array:C274(aText3)
						ARRAY LONGINT:C221($aGroupList; $cntCodes)
						For ($incCodes; 1; $cntCodes)
							$aGroupList{$incCodes}:=Num:C11(aText3{$incCodes})
						End for 
						//$fullPass:=1 "UserNum"+  2+"Name"+          3+"Startup"+    4+"password"   5 "numOfLogIns"+  6 +"lastLogIn"+ 7+"grpOwner"+  8+"membershipRay"+"\r"
						C_LONGINT:C283($userID; $groupOwner; $numOfLogIns)
						C_DATE:C307($lastLogIn)
						$numOfLogIns:=Num:C11(aText1{5})
						$lastLogIn:=Date:C102(aText1{6})
						$groupOwner:=Num:C11(aText1{8})
						$userID:=Set user properties:C612(-2; aText1{2}; aText1{3}; aText1{4}; $numOfLogIns; $lastLogIn; $aGroupList; $groupOwner)  //number; name; owner;
					End if 
				End for 
			End if 
		: ($theTask=30)
			ARRAY TEXT:C222($aUserNames; 0)
			ARRAY LONGINT:C221($aUserNums; 0)
			GET USER LIST:C609($aUserNames; $aUserNums)
			$k:=Size of array:C274($aUserNames)
			For ($i; 1; $k)
				If (Not:C34(Is user deleted:C616($aUserNums{$i})))
					DELETE USER:C615($aUserNums{$i})
				End if 
			End for 
	End case 
End if 