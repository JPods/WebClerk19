If (False:C215)
	//Date: 04/17/02
	//Who: Janani, Arkware
	//Description: Included CC_VerifyPayType 
	VERSION_960
End if 
C_LONGINT:C283($w)
KeyModifierCurrent
If ((<>aPayTypes<1) & (Size of array:C274(<>aPayTypes)>0))
	If (<>aPayTypes{0}#"")
		$w:=Find in array:C230(<>aPayTypes; <>aPayTypes{0})
		If ($w>0)
			<>aPayTypes:=$w
		Else 
			<>aPayTypes:=1
		End if 
	Else 
		<>aPayTypes:=1
	End if 
End if 
//TRACE
CC_VerifyPayType(<>aTndClass{<>aPayTypes}; <>ciTCCrdtCrd)



If (False:C215)
	
	VI2:=Size of array:C274(<>aPayTypes)
	vText1:=""
	For (vi1; 1; vi2)
		vText1:=vText1+<>aPayTypes{vi1}+"\r"
	End for 
	SET TEXT TO PASTEBOARD:C523(vText1)
	vText1:=""
End if 
//If (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd)
// v1:="Address"
// v2:="Zip"
//If (optKey=0)
//  pCkNum:=[Customer]Zip
// pBank:=[Customer]Address1
// pCardApprv:="Pend"
// End if 
//Else 
//v1:="Bank"
//v2:="Check#"
//If (optKey=0)
// pCkNum:=""
//pBank:=""
// pCardApprv:=""
//End if 
//End if 
