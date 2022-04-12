//%attributes = {"publishedWeb":true}
//C_TEXT($tempTxt)
//C_POINTER($1)
////C_LONGINT($1)
////<>iPopup:=$1
//MP_GetPopItem (epStdCom;<>sPopMenu;<>sPopItem;<>iPopMenuID;<>iPopItemID)
//If (<>iPopItemID>1)
//SEARCH([OrderCom];[OrderCom]ComName=<>sPopItem)
//If ($1="")
//$1:=[OrderCom]ComText
//Else 
//$tempTxt:=[OrderCom]ComText+"  "
//$1:=Insert string($1;$tempTxt;-10)
//End if 
//End if 
//UNLOAD RECORD([OrderCom])
//<>iPopMenuID:=0
//<>iPopItemID:=0
//<>sPopMenu:=""
//<>sPopItem:=""
//
C_TEXT:C284($tempTxt)
C_POINTER:C301($1)
If (<>aStdOrdCom>1)
	QUERY:C277([OrderComment:27]; [OrderComment:27]ComName:4=<>aStdOrdCom{<>aStdOrdCom})
	If ($1->="")
		$1->:=[OrderComment:27]ComText:5
	Else 
		$tempTxt:=[OrderComment:27]ComText:5+"  "
		$1->:=Insert string:C231($1->; $tempTxt; -10)
	End if 
End if 
<>aStdOrdCom:=1
UNLOAD RECORD:C212([OrderComment:27])