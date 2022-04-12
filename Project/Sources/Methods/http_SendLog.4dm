//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $err; $remoteHost)
C_TEXT:C284($2; $dottedAddr)

//build a message sending procedure

If (False:C215)  //create a <>Log process mechanism
	POST OUTSIDE CALL:C329(<>Log)
End if 