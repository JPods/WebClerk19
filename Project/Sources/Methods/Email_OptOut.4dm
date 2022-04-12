//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 07/01/02
	//Who: Bill James
	//Description: Opt out emails
	VERSION_960
End if 

// MustFixQQQZZZ: Bill James (2022-01-30T06:00:00Z)


C_TEXT:C284($1; $2; $3)
C_TEXT:C284($eMail; $theCommand; $theText)
$email:=$1
$theCommand:=$2
vText11:=$3
C_TEXT:C284(vText11)
ARRAY TEXT:C222(aText1; 11)
//
aText1{1}:=WCapi_GetParameter("OptIn1"; "")
aText1{2}:=WCapi_GetParameter("OptIn2"; "")
aText1{3}:=WCapi_GetParameter("OptIn3"; "")
aText1{4}:=WCapi_GetParameter("OptIn4"; "")
aText1{5}:=WCapi_GetParameter("OptIn5"; "")
aText1{6}:=WCapi_GetParameter("OptIn6"; "")
aText1{7}:=WCapi_GetParameter("OptIn7"; "")
aText1{8}:=WCapi_GetParameter("OptIn8"; "")
aText1{9}:=WCapi_GetParameter("OptIn9"; "")
aText1{10}:=WCapi_GetParameter("OptIn10"; "")
//
C_LONGINT:C283($i; $ki; $kl; $kc; $kr; $k)
//
QUERY:C277([RemoteUser:57]; [RemoteUser:57]email:14=$email)
$kr:=Records in selection:C76([RemoteUser:57])
//
QUERY:C277([Customer:2]; [Customer:2]email:81=$email)
$kc:=Records in selection:C76([Customer:2])
//

QUERY:C277([Contact:13]; [Contact:13]email:35=$email)
$ki:=Records in selection:C76([Contact:13])
//
$k:=$ki+$kc+$kr
If ($k>0)
	Case of 
		: ($theCommand="OptOut_All")
			If ($kr>0)
				READ WRITE:C146([RemoteUser:57])
				FIRST RECORD:C50([RemoteUser:57])
				For ($i; 1; $k)
					[RemoteUser:57]optOut:23:="N"
					SAVE RECORD:C53([RemoteUser:57])
					NEXT RECORD:C51([RemoteUser:57])
				End for 
			End if 
			
			If ($ki>0)
				READ WRITE:C146([Contact:13])
				FIRST RECORD:C50([Contact:13])
				For ($i; 1; $ki)
					[Contact:13]optOut:51:="N"
					SAVE RECORD:C53([Contact:13])
					QUERY:C277([CallReport:34]; [CallReport:34]customerID:1=[Customer:2]customerID:1; *)
					QUERY:C277([CallReport:34];  & [CallReport:34]tableNum:2=2; *)
					QUERY:C277([CallReport:34];  & [CallReport:34]profile1:26="OptIn"; *)
					If (Records in selection:C76([CallReport:34])>0)
						READ WRITE:C146([CallReport:34])
						DELETE SELECTION:C66([CallReport:34])
					End if 
					NEXT RECORD:C51([Contact:13])
				End for 
			End if 
			If ($kc>0)
				READ WRITE:C146([Customer:2])
				FIRST RECORD:C50([Customer:2])
				For ($i; 1; $kc)
					[Customer:2]optOut:98:="N"
					SAVE RECORD:C53([Customer:2])
					NEXT RECORD:C51([Customer:2])
				End for 
			End if 
		: ($theCommand="OptOut_StayIn")
			If ($kr>0)
				READ WRITE:C146([RemoteUser:57])
				FIRST RECORD:C50([RemoteUser:57])
				For ($i; 1; $k)
					[RemoteUser:57]optOut:23:="A"
					SAVE RECORD:C53([RemoteUser:57])
					NEXT RECORD:C51([RemoteUser:57])
				End for 
			End if 
			
			If ($ki>0)
				READ WRITE:C146([Contact:13])
				FIRST RECORD:C50([Contact:13])
				For ($i; 1; $ki)
					[Contact:13]optOut:51:="A"
					SAVE RECORD:C53([Contact:13])
					NEXT RECORD:C51([Contact:13])
				End for 
			End if 
			If ($kc>0)
				READ WRITE:C146([Customer:2])
				FIRST RECORD:C50([Customer:2])
				For ($i; 1; $kc)
					[Customer:2]optOut:98:="A"
					SAVE RECORD:C53([Customer:2])
					NEXT RECORD:C51([Customer:2])
				End for 
			End if 
		: ($theCommand="OptOut_Selected")
			If ($kr>0)
				READ WRITE:C146([RemoteUser:57])
				FIRST RECORD:C50([RemoteUser:57])
				For ($i; 1; $k)
					[RemoteUser:57]optOut:23:="S"
					SAVE RECORD:C53([RemoteUser:57])
					NEXT RECORD:C51([RemoteUser:57])
				End for 
			End if 
			If ($ki>0)
				READ WRITE:C146([Contact:13])
				FIRST RECORD:C50([Contact:13])
				For ($i; 1; $ki)
					[Contact:13]optOut:51:="S"
					SAVE RECORD:C53([Contact:13])
					NEXT RECORD:C51([Contact:13])
				End for 
			End if 
			If ($kc>0)
				READ WRITE:C146([Customer:2])
				FIRST RECORD:C50([Customer:2])
				For ($i; 1; $kc)
					[Customer:2]optOut:98:="S"
					SAVE RECORD:C53([Customer:2])
					For ($iOpt; 1; 10)
						QUERY:C277([CallReport:34]; [CallReport:34]customerID:1=[Customer:2]customerID:1; *)
						QUERY:C277([CallReport:34];  & [CallReport:34]profile1:26="OptIn"; *)
						QUERY:C277([CallReport:34];  & [CallReport:34]profile2:27=aText1{$iOpt})
						If (Records in selection:C76([CallReport:34])=0)
							
							//create a call report for selected optins
						End if 
						NEXT RECORD:C51([Customer:2])
					End for 
				End for 
			End if 
	End case 
End if 
