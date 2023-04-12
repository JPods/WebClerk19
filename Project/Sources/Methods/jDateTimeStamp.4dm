//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/18/12, 15:12:37
// ----------------------------------------------------
// Method: // zzzqqq jDateTimeStamp
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305(allowAlerts_boo)
C_LONGINT:C283(bDateTime; $k; $k2; $k3)
C_TEXT:C284($2)
C_TEXT:C284($tempTxt)
C_POINTER:C301($1)
C_BOOLEAN:C305(<>vbDateTimeStamp)

// alert(string(num(<>vbDateTimeStamp)))
C_LONGINT:C283($viStamp)
Case of 
	: ((<>vbDateTimeStamp=True:C214) & (allowAlerts_boo=False:C215))
		$viStamp:=1
	: (<>vbDateTimeStamp=True:C214)
		$viStamp:=1
	: (<>vbDateTimeStamp=False:C215)
		$viStamp:=-1
	Else   //: (<>vbDateTimeStamp=true) 
		$viStamp:=1
End case 
If ($viStamp>0)
	If ([RemoteUser:57]userName:2#"")
		$tempTxt:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+[RemoteUser:57]userName:2+" - "
	Else 
		$tempTxt:=String:C10(Current date:C33; 1)+";  "+String:C10(Current time:C178; 2)+"; "+Current user:C182+" - "
	End if 
	Case of 
		: (Count parameters:C259=1)
			$tempTxt:=$tempTxt+"   "+"\r"
			$k:=Length:C16($tempTxt)+1
			$k2:=$k-4
			$k3:=$k2+3
			$1->:=Insert string:C231($1->; $tempTxt; -10)
			HIGHLIGHT TEXT:C210($1->; $k2; $k3)
		: (Count parameters:C259=2)
			$tempTxt:=$tempTxt+$2+"\r"
			$1->:=Insert string:C231($1->; $tempTxt; -10)
	End case 
End if 