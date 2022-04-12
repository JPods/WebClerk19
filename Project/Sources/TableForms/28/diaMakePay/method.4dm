If (False:C215)
	//Date: 04/17/02
	//Who: Janani, Arkware
	//Description: Modified to take off the beep and alert if a matching credit card 
	//is not found and point to default credit card entry
	VERSION_960
End if 

C_BOOLEAN:C305($vFound)
$vFound:=True:C214
C_LONGINT:C283($vLoop; $vCnt; $vPos; $i; $k)


Case of 
	: (Outside call:C328)
		CC_ZonJrAccept
	: (Before:C29)
		C_LONGINT:C283($i; $w)
		C_REAL:C285($total; pDiffCurr)
		$w:=Find in array:C230(<>aPayAction; "AUTH_CAPTURE")
		If ($w>0)
			<>aPayAction:=$w
		Else 
			<>aPayAction:=1
		End if 
		If (viPayAddWin=2)  //viPayAddWin=2 only on 1st opening      
			//Pay_InitializeVars 
			
			P_PayHeaderVars(2)
			
			$k:=Size of array:C274(<>aPayTypes)
			If (pCreditCard#"")  // Modified by: williamjames (111216 checked for <= length protection)
				Case of 
					: (pCreditCard[[1]]="3")
						For ($i; 1; $k)
							If (<>aPayTypes{$i}[[1]]="A")
								If (<>aTndClass{$i}=<>ciTCCrdtCrd)
									<>aPayTypes:=$i
									$i:=$k
									$vFound:=True:C214
								End if 
							Else 
								$vFound:=False:C215
								// BEEP
								// BEEP
								// ALERT("Payment type for this card number is not in pop-up list.")
								//pCreditCard:=""
							End if 
						End for 
					: (pCreditCard[[1]]="4")
						For ($i; 1; $k)
							If (<>aPayTypes{$i}[[1]]="V")
								If (<>aTndClass{$i}=<>ciTCCrdtCrd)
									<>aPayTypes:=$i
									$i:=$k
									$vFound:=True:C214
								End if 
								
							Else 
								$vFound:=False:C215
								// BEEP
								// BEEP
								// ALERT("Payment type for this card number is not in pop-up list.")
								//pCreditCard:=""
							End if 
						End for 
					: (pCreditCard[[1]]="5")
						For ($i; 1; $k)
							If (<>aPayTypes{$i}[[1]]="M")
								If (<>aTndClass{$i}=<>ciTCCrdtCrd)
									<>aPayTypes:=$i
									$i:=$k
									$vFound:=True:C214
								End if 
								
							Else 
								$vFound:=False:C215
								// BEEP
								// BEEP
								// ALERT("Payment type for this card number is not in pop-up list.")
								//pCreditCard:=""
							End if 
						End for 
					: (pCreditCard[[1]]="6")
						For ($i; 1; $k)
							If (<>aPayTypes{$i}[[1]]="D")
								If (<>aTndClass{$i}=<>ciTCCrdtCrd)
									<>aPayTypes:=$i
									$i:=$k
									$vFound:=True:C214
								End if 
							Else 
								$vFound:=False:C215
								// BEEP
								// BEEP
								// ALERT("Payment type for this card number is not in pop-up list.")
								//pCreditCard:=""
							End if 
						End for 
				End case 
			End if 
			
			//If (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd)
			//  v1:="Address"
			//v2:="Zip"
			// pCkNum:=[Customer]Zip
			// pBank:=[Customer]Address1
			// pCardApprv:="Pend"
			//Else 
			//  v1:="Bank"
			//v2:="Check#"
			//End if 
			If ($vFound=False:C215)  // if no match is found for the no point to "credit card"
				For ($vLoop; 1; Size of array:C274(<>aTndClass))
					If (<>aTndClass{$vLoop}=<>ciTCCrdtCrd)
						$vCnt:=$vCnt+1
						$vPos:=$vLoop
					End if 
				End for 
				If ($vCnt=1)  // if there is only one credit card entry found in the pop up then select it
					<>aPayTypes:=$vPos
				End if 
			End if 
			CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
			
			pOrigTotal:=pTotal
			pPayment:=pTotal
			Format_CreditCd(->pCreditCard)
			If ((strCurrency#<>tcMONEYCHAR) & (<>tcMONEYCHAR#"") & (rExchRate#rUExchRate) & ((rUExchRate#0) | (rUExchRate#1)))
				Pay_CurrConvert
			Else 
				pDiffCurr:=0
			End if 
			pDiff:=0
			// aaaDecConsts  Line 57 +
			If ((<>tcCcDevice#<>ciCCDevMaSu) & (<>tcCcDevice#<>ciCCDevMaMu) & (<>tcCcDevice#<>ciCCDevSOAP) & (<>tcCcDevice#<>ciCCDevAuthNet) & (<>tcCcDevice#<>ciCCDevChase) & (<>tcCcDevice#<>ciCCDevVerisign) & (<>tcCcDevice#<>ciCCDevSyncRelations))
				OBJECT SET ENABLED:C1123(bAppCC; False:C215)
			End if 
		End if 
		viPayAddWin:=0
		
	Else 
		If (vMod)
			If ((rExchRate#rUExchRate) & ((rUExchRate#0) | (rUExchRate#1)))
				Pay_CurrConvert
			Else 
				pDiffCurr:=0
			End if 
			vMod:=False:C215
		End if 
End case 

