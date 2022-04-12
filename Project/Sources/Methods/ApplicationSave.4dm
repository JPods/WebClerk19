//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/06/06, 10:17:16
// ----------------------------------------------------
// Method: Method: ApplicationSave
// Description
// 
//
// Parameters
// ----------------------------------------------------
//
C_TEXT:C284($locItems; $theSuffix; $theApp; $theCreator)
C_LONGINT:C283($rslt)
$rslt:=1
$locItems:=Storage:C1525.folder.jitPrefPath+"LaunchHelpers.txt"
If (HFS_Exists($locItems)#0)
	$rslt:=HFS_Delete($locItems)
End if 
If ($rslt=0)  //no error
	myDoc:=Create document:C266($locItems)
	If (OK=1)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(<>aLaunchApp)
		For ($i; 1; $k)
			SEND PACKET:C103(myDoc; <>aLaunchSuff{$i}+"\t"+<>aLaunchCrea{$i}+"\t"+<>aLaunchApp{$i}+"\r")
		End for 
		CLOSE DOCUMENT:C267(myDoc)
	Else 
		
	End if 
Else 
	CONFIRM:C162(Storage:C1525.folder.jitPrefPath+"LnchHelp.txt is locked save as a backup?")
	If (OK=1)
		sumDoc:=Create document:C266("")
		If (OK=1)
			C_LONGINT:C283($i; $k)
			$k:=Size of array:C274(<>aLaunchApp)
			For ($i; 1; $k)
				SEND PACKET:C103(sumDoc; <>aLaunchSuff{$i}+"\t"+<>aLaunchCrea{$i}+"\t"+<>aLaunchApp{$i}+"\r")
			End for 
			CLOSE DOCUMENT:C267(sumDoc)
		End if 
	End if 
End if 