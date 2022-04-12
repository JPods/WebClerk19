//%attributes = {"publishedWeb":true}
//Method: WC_StartEndBegin
$p:=New process:C317("WC_StartUpShutDownFlip"; <>tcPrsMemory; "WebClerk End"; 0)
$p:=New process:C317("WC_StartUpShutDownFlip"; <>tcPrsMemory; "WebClerk Restart"; 1)
DELAY PROCESS:C323(Current process:C322; 240)
