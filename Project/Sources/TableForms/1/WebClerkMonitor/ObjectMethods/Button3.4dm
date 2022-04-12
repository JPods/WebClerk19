//KeyModifierCurrent 
//If (OptKey=1)



//Else 
WC_StartUpShutDownFlip(0)
//
DELAY PROCESS:C323(Current process:C322; 60)
//
Prs_ListActive
//End if 


$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")
If ($w>0)
	OBJECT SET ENABLED:C1123(b8; True:C214)
	OBJECT SET ENABLED:C1123(b7; False:C215)
	_O_OBJECT SET COLOR:C271(iloText1; -(Black:K11:16+(256*Yellow:K11:2)))
	
Else 
	OBJECT SET ENABLED:C1123(b8; False:C215)
	OBJECT SET ENABLED:C1123(b7; True:C214)
	_O_OBJECT SET COLOR:C271(iloText1; -(Black:K11:16+(256*White:K11:1)))
End if 