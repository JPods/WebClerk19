//%attributes = {}
// ----------------------------------------------------
// User name (OS): Add Komoncharoensiri
// Date and time: 09/23/19, 08:23:41
// ----------------------------------------------------
// Method: getReadableUserList
// Description
//     Get the list of user with specific property who shares
//     their calendar with the current user. This method is called
//     from the main window.
// ----------------------------------------------------

C_COLLECTION:C1488($0; $users_c)
C_LONGINT:C283($curUserId_l; $i; $index_l)
C_OBJECT:C1216($obSelectEmployees)
$obSelectEmployees:=ds:C1482.Employee.query("nameID = Dale")
$curUserId_l:=$obSelectEmployees.first().unique[Employee].idNum
$users_c:=New collection:C1472(New object:C1471("show"; True:C214; "id"; $curUserId_l; \
"name"; "Dale"; "colorPic"; bgColorPict("#404040")))

QUERY:C277([Employee:19]; [Employee:19]idNum:71#$curUserId_l)

For ($i; 1; Records in selection:C76([Employee:19]))
	// $index_l:=[Employee]ObGeneral.users.findIndex(0; "findID"; $curUserId_l)
	//If ($index_l>=0)
	//If (Employee]ObGeneral.users[$index_l].permission#"None")
	$users_c.push(New object:C1471("show"; True:C214; "id"; [Employee:19]idNum:71; \
		"name"; [Employee:19]nameid:1; "colorPic"; bgColorPict("#994C00")))  // userColorFromId([Employee]UniqueID))))
	//End if 
	//End if 
	NEXT RECORD:C51([Employee:19])
End for 

$0:=$users_c