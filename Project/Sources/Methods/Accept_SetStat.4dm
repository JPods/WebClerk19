//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($2; $3)  //$complete;$virgin
C_POINTER:C301($1)
C_LONGINT:C283($4)
Case of 
	: ($3)  //check complete status first, no line items
		$0:=2
		If ($1->=!00-00-00!)
			$1->:=Current date:C33
		End if 
	: ($2)
		$0:=0
		$1->:=!00-00-00!
	Else 
		$0:=1
		$1->:=!00-00-00!
End case 