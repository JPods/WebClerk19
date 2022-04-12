//%attributes = {"publishedWeb":true}
//Procedure: Lead_Relate2Cus
C_LONGINT:C283($i; $k)
//
READ WRITE:C146([RemoteUser:57])
QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Lead:48]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerid:10=String:C10([Lead:48]idNum:32))
$k:=Records in selection:C76([RemoteUser:57])
FIRST RECORD:C50([RemoteUser:57])
For ($i; 1; $k)
	If (Locked:C147([RemoteUser:57]))
		BEEP:C151
		TRACE:C157
		DUPLICATE RECORD:C225([RemoteUser:57])
		[RemoteUser:57]tableNum:9:=2
		[RemoteUser:57]customerid:10:=[Customer:2]customerID:1
	Else 
		[RemoteUser:57]tableNum:9:=2
		[RemoteUser:57]customerid:10:=[Customer:2]customerID:1
	End if 
	SAVE RECORD:C53([RemoteUser:57])
	NEXT RECORD:C51([RemoteUser:57])
End for 
UNLOAD RECORD:C212([RemoteUser:57])
//
C_LONGINT:C283($k; $i)
QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=Table:C252(->[Lead:48]); *)
QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=String:C10([Lead:48]idNum:32))
$k:=Records in selection:C76([CallReport:34])
If ($k>0)
	ARRAY TEXT:C222(aTmp10Str1; $k)
	ARRAY LONGINT:C221(aTmpInt1; $k)
	For ($i; 1; $k)
		aTmpInt1{$i}:=2
		aTmp10Str1{$i}:=[Customer:2]customerID:1
	End for 
	ARRAY TO SELECTION:C261(aTmpInt1; [CallReport:34]tableNum:2; aTmp10Str1; [CallReport:34]customerID:1)
End if 
//
QUERY:C277([CommunicationDevice:63]; [CommunicationDevice:63]tableNum:2=Table:C252(->[Lead:48]); *)
QUERY:C277([CommunicationDevice:63];  & [CommunicationDevice:63]customerID:1=String:C10([Lead:48]idNum:32))
$k:=Records in selection:C76([CommunicationDevice:63])
If ($k>0)
	ARRAY TEXT:C222(aTmp10Str1; $k)
	ARRAY LONGINT:C221(aTmpInt1; $k)
	For ($i; 1; $k)
		aTmpInt1{$i}:=2
		aTmp10Str1{$i}:=[Customer:2]customerID:1
	End for 
	ARRAY TO SELECTION:C261(aTmpInt1; [CommunicationDevice:63]tableNum:2; aTmp10Str1; [CommunicationDevice:63]customerID:1)
End if 
//
QUERY:C277([QA:70]; [QA:70]tableNum:11=Table:C252(->[Lead:48]); *)
QUERY:C277([QA:70];  & [QA:70]customerid:1=String:C10([Lead:48]idNum:32))
$k:=Records in selection:C76([QA:70])
If ($k>0)
	ARRAY TEXT:C222(aTmp10Str1; $k)
	ARRAY LONGINT:C221(aTmpInt1; $k)
	For ($i; 1; $k)
		aTmpInt1{$i}:=2
		aTmp10Str1{$i}:=[Customer:2]customerID:1
	End for 
	ARRAY TO SELECTION:C261(aTmpInt1; [QA:70]tableNum:11; aTmp10Str1; [QA:70]customerid:1)
End if 
//
ARRAY TEXT:C222(aTmp10Str1; 0)
ARRAY LONGINT:C221(aTmpInt1; 0)
//