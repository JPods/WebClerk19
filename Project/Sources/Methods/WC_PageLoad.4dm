//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-12-15T00:00:00, 16:57:53
// ----------------------------------------------------
// Method: WC_PageLoad
// Description
// Modified: 12/15/16
// Structure: CE14vah
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($thisPage; jitThisPage)
$thisPage:="PageNotFound"
C_TEXT:C284($pageText; $1; $documentPath; $secureStr; $0)
C_LONGINT:C283($w; $L; $Mtime; <>vlFixPages; $secureInd; $err; $jitSecure)
C_DATE:C307($mDate)
C_BLOB:C604($blobPageIn)
SET BLOB SIZE:C606($blobPageIn; 0)
C_POINTER:C301($2)

$jitSecure:=0
$documentPath:=$1

jitThisPage:=HFS_ShortName($documentPath)  // ### jwm ### 20161208_1154

If ([EventLog:75]securityLevelWCC:25>[EventLog:75]securityLevel:16)
	viSecureLvl:=[EventLog:75]securityLevelWCC:25
Else 
	viSecureLvl:=[EventLog:75]securityLevel:16  // ### jwm ### 20151209_0958 is this the employee or the end user ???
End if 

$maxSecurity:=WC_PathSecurityReturn($documentPath)  //Check if there is a security setting in path that exceeds the user.
If ($maxSecurity>viSecureLvl)
	vResponse:="Path Security Level Exceeded"
	$documentPath:=<>WebFolder+"error.html"
	$result:=-1
End if 

C_TEXT:C284($jitPageError)
$jitPageError:=WCapi_GetParameter("jitPageError"; "")
C_LONGINT:C283($webPageFound)



If (Test path name:C476($documentPath)=1)  // found document and 
	$doError:=False:C215
	C_LONGINT:C283($jitSecure)
	$jitSecure:=0
	$content:=WC_MetaTagRead($0; "jitSecure"; 0)
	$jitSecure:=Num:C11($content)
	If (viSecureLvl<$jitSecure)
		//<>aWebPageTimesSecurityFails{$fia}:=<>aWebPageTimesSecurityFails{$fia}+1
		vResponse:=vResponse+"Security access less than required: "+jitThisPage
		$documentPath:=WC_DoPage("Error.html"; $jitPageError)  //there must be an error page
		WC_LogEvent("PageLoadError"; Replace string:C233(vResponse; "\r"; " -- "))
	Else 
		// use existing document path
	End if 
Else 
	$documentPath:=WC_DoPage("Error.html"; $jitPageError)  //there must be an error page
	
	vResponse:=vResponse+(Num:C11(vResponse#"")*"\r")+"404, File Not Found: "+jitThisPage
	WC_LogEvent("PageLoadError"; Replace string:C233(vResponse; "\r"; " -- "))
End if 
// ### bj ### 20181219_2217  adjusting logs to better record page fails
WC_LogEvent("WC_PageLoad"; $documentPath)

DOCUMENT TO BLOB:C525($documentPath; $blobPageIn)
$0:=BLOB to text:C555($blobPageIn; UTF8 text without length:K22:17)  // send out the document as text

If (Count parameters:C259>1)
	$2->:=$documentPath
End if 

If (<>viDebugMode>910)
	C_TEXT:C284($webLog)
	$webLog:="<WC_PageLoad>"+$documentPath+", OS: "+WCapi_GetParameter("User-Agent"; "")+", jitSecure: "+String:C10($jitSecure)+", <>vlSecurityBump: "+String:C10(<>vlSecurityBump)+", UserSecurity: "+String:C10(viSecureLvl)
	$webLog:=$webLog+", WccSecurity: "+String:C10(vWccSecurity)+", vResponse: "+vResponse+"</WC_PageLoad>"
	ConsoleMessage($webLog)
End if 

