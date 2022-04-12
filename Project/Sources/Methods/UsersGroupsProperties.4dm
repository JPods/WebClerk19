//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/02/12, 08:33:46
// ----------------------------------------------------
// Method: UsersGroupsProperties
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($userName; $theStartup; $userPassword)
C_LONGINT:C283($numLogIns; $numGroupOwner; $userNum)
C_DATE:C307($lastLogIn)
ARRAY TEXT:C222($aUserNames; 0)
ARRAY LONGINT:C221($aUserNums; 0)
GET USER LIST:C609($aUserNames; $aUserNums)
$w:=Find in array:C230($aUserNames; Current user:C182)
$userNum:=$aUserNums{$w}
GET USER PROPERTIES:C611($userNum; $userName; $theStartup; $userPassword; $numLogIns; $lastLogIn; $aGroupRay; $numGroupOwner)

ARRAY TEXT:C222($aGroupNames; 0)
ARRAY LONGINT:C221($aGroupNums; 0)
GET GROUP LIST:C610($aGroupNames; $aGroupNums)
$groupNameToTest:="EditOrder"
$w:=Find in array:C230($aGroupNames; $groupNameToTest)
GET GROUP PROPERTIES:C613($aGroupNums{$w}; $aGroupNames{$w}; $iOwnerID; $aGroupRay)
$userNum:=3
$theStartup:="*"
$userPassword:="*"
vi1:=Set user properties:C612($userNum; $userName; $theStartup; $userPassword; $numLogIns; !2011-01-01!)
//-9979 is deleted user


GET USER LIST:C609($aUserNames; $aUserNum)

Execute_TallyMaster("UserTest"; "Utility")



