//%attributes = {"publishedWeb":true}
KeyModifierCurrent
If ((CmdKey=1) & (CtlKey=1))
	ALERT:C41("Zon Text Length: "+String:C10(Length:C16(<>vtZonJrText))+"\r"+Substring:C12(<>vtZonJrText; 1; 30))
	ZON_SaveToDisk(-><>vtZonJrText)
End if 
If (Length:C16(<>vtZonJrText)>200)  //Only parse real messages
	If (CC_ZonParseText(-><>vtZonJrText; ->pPayment; ->pCreditCard; ->pDateExpire; ->pCardApprv; ->pReferNum))  //true if parseing OK
		If (pTotal<0)
			If (pPayment>0)
				pPayment:=-pPayment
			End if 
		End if 
		Case of 
			: (pCardApprv="")  // Modified by: williamjames (111216 checked for <= length protection)
			: (pCardApprv[[1]]="4")
				<>aPayTypes:=Find in array:C230(<>aPayTypes; "Visa")
			: (pCardApprv[[1]]="5")
				<>aPayTypes:=Find in array:C230(<>aPayTypes; "MC")
		End case 
		pDiff:=Round:C94(pTotal-pPayment; <>tcDecimalTt)
		If (pCardApprv="")
			ALERT:C41("Enter an Auth. Code.")
		End if 
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
		POST KEY:C465(9; 0)
	End if 
End if 
If (Process state:C330(<>ZonRcvPrcss)>=0)
	While (Process state:C330(<>ZonRcvPrcss)#5)  //wait for pause
		IDLE:C311
	End while 
	RESUME PROCESS:C320(<>ZonRcvPrcss)
End if 