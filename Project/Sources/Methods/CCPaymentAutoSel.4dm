//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/30/11, 07:34:07
// ----------------------------------------------------
// Method: CCPaymentAutoSel
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($vFound)
$vFound:=True:C214
C_LONGINT:C283($vLoop; $i)
C_LONGINT:C283($vCnt)
C_LONGINT:C283($vPos)
$vCnt:=0


Case of 
	: (pCreditCard="")
	: (pCreditCard[[1]]="3")
		//If (<>aPayTypes{<>aPayTypes}1#"A")
		For ($i; 1; Size of array:C274(<>aPayTypes))
			If (<>aPayTypes{$i}[[1]]="A")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					<>aPayTypes:=$i
				End if 
				CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
			Else 
				$vFound:=False:C215
				// BEEP
				// BEEP
				// ALERT("Payment type for this card number is not in pop-up list.")
				//pCreditCard:=""
			End if 
		End for 
		// End if 
	: (pCreditCard[[1]]="4")
		//If (<>aPayTypes{<>aPayTypes}1#"V")
		For ($i; 1; Size of array:C274(<>aPayTypes))
			If (<>aPayTypes{$i}[[1]]="V")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					<>aPayTypes:=$i
				End if 
				CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
			Else 
				$vFound:=False:C215
				// BEEP
				// BEEP
				// ALERT("Payment type for this card number is not in pop-up list.")
				//pCreditCard:=""
			End if 
		End for 
		// End if 
	: (pCreditCard[[1]]="5")
		//If (<>aPayTypes{<>aPayTypes}1#"M")
		For ($i; 1; Size of array:C274(<>aPayTypes))
			If (<>aPayTypes{$i}[[1]]="M")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					<>aPayTypes:=$i
				End if 
				CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
			Else 
				$vFound:=False:C215
				// BEEP
				// BEEP
				// ALERT("Payment type for this card number is not in pop-up list.")
				//pCreditCard:=""
			End if 
		End for 
		//End if 
	: (pCreditCard[[1]]="6")
		//If (<>aPayTypes{<>aPayTypes}1#"D")
		For ($i; 1; Size of array:C274(<>aPayTypes))
			If (<>aPayTypes{$i}[[1]]="D")
				If (<>aTndClass{$i}=<>ciTCCrdtCrd)
					<>aPayTypes:=$i
				End if 
				CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
			Else 
				$vFound:=False:C215
				// BEEP
				// BEEP
				// ALERT("Payment type for this card number is not in pop-up list.")
				//pCreditCard:=""
			End if 
		End for 
		//End if 
		
End case 
TRACE:C157
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
	CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)
End if 