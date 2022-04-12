//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/07, 06:15:16
// ----------------------------------------------------
// Method: Http_RemoteUserSearch
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $err; $userRec)
C_POINTER:C301($2)
C_BOOLEAN:C305(<>webAreYouHuman)

vResponse:="No UserName or Password"
$suppression:=<>vlWildSrch
<>vlWildSrch:=1
$userName:=WCapi_GetParameter("userName"; "")
<>vlWildSrch:=0
$password:=WCapi_GetParameter("password"; "")
$areYouHuman:=WCapi_GetParameter("AreYouHuman"; "")


<>vlWildSrch:=$suppression
C_LONGINT:C283($pAt)
$pAt:=Position:C15(Char:C90(Character code:C91("@")); $password)
If ($pAt>0)
	$password:=""
	vResponse:="Illigal character in Password."
End if 

//TRACE
//
$biometric:=WCapi_GetParameter("biometric"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//$email:=WCapi_GetParameter("email";"")
//
lang:="us"
$suffix:=""
ARRAY TEXT:C222(aSignInText; 0)
//
$doQuery:=True:C214
If (($userName="") | ($password=""))
	If ($userName="")
		vResponse:="UserName not defined"+"\r"
	End if 
	If ($password="")
		vResponse:=vResponse+"Password not defined"+"\r"
	End if 
Else 
	If (<>webAreYouHuman)
		If ($areYouHuman=[EventLog:75]areYouHuman:36)
			vResponse:="OK"
		Else 
			vResponse:="Are You Human did not match."
			$doQuery:=False:C215
		End if 
	End if 
	
	If ($doQuery)
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName; *)  //find remote user record
		QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$password)
		Case of 
			: (Records in selection:C76([RemoteUser:57])>1)
				vResponse:="Multiple RemoteUsers Records"
				
			: (Records in selection:C76([RemoteUser:57])=1)
				vResponse:="Found RemoteUser"
				$thePage:=""
				$thePage:=RemoteUser_SetEventLog
			Else 
				vResponse:="No matching UserName and Password"
		End case 
	End if 
End if 
If (<>viDebugMode>0)
	If (vResponse="OK")
		webLog:=webLog+"<SearchRemoteUser> UserName: "+$userName+", Password: "+$password+", biometric: "+$biometric+", RemoteUserRecordNum: "+String:C10(Record number:C243([RemoteUser:57]))+", SecurityLevel: "+String:C10([RemoteUser:57]securityLevel:4)+"</SearchRemoteUser>"+"\r"
	Else 
		webLog:=webLog+"<SearchRemoteUser>Response: "+vResponse+"</SearchRemoteUser>"+"\r"
	End if 
End if 
$thePage:=WC_DoPage("error.html"; $thePage)
$err:=WC_PageSendWithTags($1; $thePage; 0)
//
