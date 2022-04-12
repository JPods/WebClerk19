//%attributes = {"publishedWeb":true}
If (False:C215)
	//01/21/03.prf
	//New method to send email
	VERSION_9919
	VERSION_9919_ISC
End if 
C_TEXT:C284($1; $email)
$email:=$1
If (($email#"") & (Position:C15(Char:C90(64); $email)>0))
	If (Position:C15("mailto:"; $email)>0)
		OPEN URL:C673($email)
	Else 
		OPEN URL:C673("mailto:"+$email)
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 