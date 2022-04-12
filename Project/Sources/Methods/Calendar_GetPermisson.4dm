//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/03/21, 18:51:44
// ----------------------------------------------------
// Method: Calendar_GetPermisson
// Description

//      Get the user permission of the current user or the
//      user associated with the given user ID.
//
// Parameters
//     $1    -    User Id
// ----------------------------------------------------

C_TEXT:C284($0; $permission_t)
C_LONGINT:C283($1; $curUserid_l)
C_OBJECT:C1216($shares_o)
If (False:C215)
	// commented because it is looking for a number
	//$curUserid_l:=CurrentUser_Get
	If ($curUserid_l#$1)
		$shares_o:=ds:C1482.Share.query("ownerid = :1"; $1)
		If ($shares_o.length>0)
			C_COLLECTION:C1488($shareWithUsers_c)
			C_LONGINT:C283($index_l)
			$shareWithUsers_c:=$shares_o[0].shareWith.users
			$index_l:=$shareWithUsers_c.findIndex(0; "findid"; $curUserid_l)
			If ($index_l>=0)
				$permission_t:=$shareWithUsers_c[$index_l].permission
			End if 
		End if 
	Else 
		$permission_t:="Read and Write"
	End if 
	
	$0:=$permission_t
End if 

$0:="Read and Write"