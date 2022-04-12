//%attributes = {"publishedWeb":true}
//Method: EMail_In
If (False:C215)
	//Date: 07/01/02
	//Who: bill , IDC WebDev
	//Description: Searches RemoteUsers table for an email match, sends email
End if 
C_TEXT:C284($1; $0)
C_LONGINT:C283($p)
C_LONGINT:C283($2; $vlCheckAt)
$0:=$1
// ### bj ### 20181213_2133
// no longer using &~
If (False:C215)
	If (Count parameters:C259=2)
		$vlCheckAt:=$2
	Else 
		$vlCheckAt:=0
	End if 
	If (Not:C34(<>tcDefaultAllowEmailChar))
		$p:=Position:C15(Char:C90(64); $1)
		If ($p>0)
			$0:=Substring:C12($1; 1; $p-1)+"&~"+Substring:C12($1; $p+1)
		Else 
			Case of 
				: ($vlCheckAt=1)
					ALERT:C41("No @ sign in email address")
				: ($vlCheckAt=2)
					$0:=$1
			End case 
		End if 
	End if 
End if 