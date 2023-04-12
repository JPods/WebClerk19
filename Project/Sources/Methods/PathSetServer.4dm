//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/02/18, 13:51:34
// ----------------------------------------------------
// Method: PathSetServer
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($vbdidQuery)
C_OBJECT:C1216($obRec; $obSel)
var $pathResult_t; $launchPath : Text

var $webPath_t; $jitF : Text
$jitF:=System folder:C487(Documents folder:K41:18)+"CommerceExpert"+Folder separator:K24:12

$obRec:=ds:C1482.Default.query("primeDefault = 1").first()
If ($obRec=Null:C1517)
	ALERT:C41("There is no Default record primeDefault = 1")
Else 
	If (process_o=Null:C1517)  // we are not in the Default record, OK to save
		$obRec.save()
	Else 
		If (process_o.dataClassName="Default")  // we are in the Default Record so save it
			[Default:15]sharePath:179:=$obRec.sharePath
			SAVE RECORD:C53([Default:15])
			$obRec:=ds:C1482.Default.query("primeDefault = 1").first()
		Else 
			$obRec.save()  // we are in some other table than Default so save it
		End if 
	End if 
	
	$serverComEx:=""
	$driveLaunch:=""
	Case of 
		: ($obRec.shareServer#"")  // mac and windows 
			// always save to the POSIX full path, clip when using
			$saveComEx:="//"+$obRec.shareServer+"/"+$obRec.shareName+"/"+"CommerceExpert/"
			If (Is macOS:C1572)
				// the accessing path on this Mac machine
				$serverComEx:=$obRec.shareName+Folder separator:K24:12+"CommerceExpert"+Folder separator:K24:12  //  +Folder separator is not on <>vtShareName
				$serverDocs:=$obRec.shareName+Folder separator:K24:12
				// path to the ComEx folder
				$driveLaunch:="//"+$obRec.shareServer+"/"+$obRec.shareName+"/"
			Else 
				// the accessing path on this Windows machine
				$serverComEx:="\\\\"+$obRec.shareServer+"\\"+$obRec.shareName+"\\"+"CommerceExpert"+"\\"
				// path to the ComEx folder
				$driveLaunch:="\\\\"+$obRec.shareServer+"\\"+$obRec.shareName+"\\"
				$serverDocs:=$driveLaunch
			End if 
		: ($obRec.shareName#"")  // mac only, no pc server
			$saveComEx:=$obRec.shareName+"/"
		Else 
			$saveComEx:=Convert path system to POSIX:C1106($jitF)
	End case 
	
	C_LONGINT:C283($viCnt)
	
	If (($serverComEx#"") & (Application type:C494#4D Server:K5:6))
		If (Test path name:C476($serverComEx)#0)
			LaunchShareDrive($driveLaunch)
		End if 
	End if 
	
	
	
	$webPath_t:=ds:C1482.WebClerk.query("publish = 1").first().pathTojitWeb
	
	
	//  $serverPath   // this is in the local machine format
	//  //"documents"; System folder(Documents folder); 
	
	$voData:=New shared object:C1526(\
		"localComEx"; $jitF; \
		"serverComEx"; $serverComEx; \
		"serverDocuments"; $serverDocs; \
		"saveComEx"; $saveComEx; \
		"driveLaunch"; $driveLaunch; \
		"jitF"; $jitF; \
		"shareServer"; $obRec.shareServer; \
		"shareName"; $obRec.shareName; \
		"remote"; ""; \
		"jitAudits"; $jitF+"jitAudits"+Folder separator:K24:12; \
		"jitCatalog"; $jitF+"jitCatalog"+Folder separator:K24:12; \
		"customerLocal"; $jitF+"customer"+Folder separator:K24:12; \
		"customerServer"; $jitF+"customer"+Folder separator:K24:12; \
		"customerRemote"; $jitF+"customer"+Folder separator:K24:12; \
		"jitDebug"; $jitF+"jitDebug"+Folder separator:K24:12; \
		"jitjDocs"; $jitF+"jitjDocs"+Folder separator:K24:12; \
		"jitExports"; $jitF+"jitExports"+Folder separator:K24:12; \
		"jitFAX"; $jitF+"jitFAX"+Folder separator:K24:12; \
		"jitHelpLocal"; $jitF+"jitHelp"+Folder separator:K24:12; \
		"jitHelpRemote"; "https://www.webclerk.net"; \
		"jitHelpServer"; "https://www.webclerk.net"; \
		"jitLabels"; $jitF+"jitLabels"+Folder separator:K24:12; \
		"jitLetters"; $jitF+"jitLetters"+Folder separator:K24:12; \
		"jitReports"; $jitF+"jitReports"+Folder separator:K24:12; \
		"jitSearches"; $jitF+"jitSearches"+Folder separator:K24:12; \
		"jitShip"; $jitF+"jitShip"+Folder separator:K24:12; \
		"jitWeb"; $webPath_t)
	
	
	Use (Storage:C1525)
		Storage:C1525.paths:=$voData
	End use 
	
	
	
End if 

C_LONGINT:C283(<>viDebugMode)
If (<>viDebugMode>210)
	ConsoleLog("Storage.paths: "+JSON Stringify:C1217(Storage:C1525.paths))
Else 
	ConsoleLog("Storage.paths.saveComEx: "+Storage:C1525.paths.saveComEx)
	ConsoleLog("Storage.paths.serverComEx: "+Storage:C1525.paths.serverComEx)
	ConsoleLog("Storage.paths.shareServer (pc): "+Storage:C1525.paths.shareServer)
	ConsoleLog("Storage.paths.shareName (pc & mac): "+Storage:C1525.paths.shareName)
	ConsoleLog("Storage.paths.driveLaunch (pc & mac): "+Storage:C1525.paths.driveLaunch)
End if 




<>jitHelpServer:=Storage:C1525.paths.jitHelpServer
<>jitHelpLocal:=Storage:C1525.paths.jitHelpLocal
<>jitHelpPath:=Storage:C1525.paths.jitHelpRemote


