//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //port number Printer vs Modem (0 or 1)
C_LONGINT:C283(<>ZonRcvPrcss)
C_BOOLEAN:C305(<>ZonRcvRun)
C_LONGINT:C283(<>ZonRcvPort)
<>ZonRcvPort:=$1
<>ZonRcvRun:=True:C214
<>ZonRcvPrcss:=New process:C317("CC_ZonGetText"; 32*1024; "$ZonJrRcv")