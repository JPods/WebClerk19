//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3)  //price; cost; item number
C_BOOLEAN:C305(vBooMarFlag)
If ((<>minMargin>0) & (vBooMarFlag))
	If ($2->>0)
		If (<>minMargin>(($1->-$2->)/$2->*100))
			If (allowAlerts_boo)
				ConsoleMessage($3->+"\r"+"\r"+"Item is priced less than standard margins.")
			End if 
			vBooMarFlag:=False:C215
		End if 
	End if 
End if 