KeyModifierCurrent
If (OptKey=0)
	WC_StartUpShutDownFlip
Else 
	WC_StartEndBegin
End if 
DELAY PROCESS:C323(Current process:C322; 60)
Process_ListActive
$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")
If ($w>0)
	OBJECT SET ENABLED:C1123(b8; True:C214)
	OBJECT SET ENABLED:C1123(b7; False:C215)
	OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; Yellow:K11:2)
	
Else 
	OBJECT SET ENABLED:C1123(b8; False:C215)
	OBJECT SET ENABLED:C1123(b7; True:C214)
	OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; White:K11:1)
End if 