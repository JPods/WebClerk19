//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/06/06, 10:19:14
// ----------------------------------------------------
// Method: ApplicationLoad
// Description
// 
//
// Parameters
// ----------------------------------------------------


//CLOSE DOCUMENT(myDoc)

ARRAY TEXT:C222(<>aLaunchSuff; 0)
ARRAY TEXT:C222(<>aLaunchApp; 0)
ARRAY TEXT:C222(<>aLaunchCrea; 0)

C_TEXT:C284($locItems; $theSuffix; $theApp; $theCreator)
KeyModifierCurrent
If (OptKey=0)
	$locItems:=Storage:C1525.folder.jitPrefPath+"LaunchHelpers.txt"
Else 
	myDoc:=Open document:C264("")
	If (OK=1)
		CLOSE DOCUMENT:C267(myDoc)
		$locItems:=document
	Else 
		$locItems:=""  //Storage.folder.jitPrefPath+"LaunchHelpers.txt"
	End if 
End if 
If ($locItems#"")
	If (HFS_Exists($locItems)#0)
		myDoc:=Open document:C264($locItems)
		If (OK=1)
			Repeat 
				RECEIVE PACKET:C104(myDoc; $theSuffix; "\t")
				If (OK=1)
					RECEIVE PACKET:C104(myDoc; $theCreator; "\t")
					RECEIVE PACKET:C104(myDoc; $theApp; "\r")
					INSERT IN ARRAY:C227(<>aLaunchSuff; 1; 1)
					INSERT IN ARRAY:C227(<>aLaunchApp; 1; 1)
					INSERT IN ARRAY:C227(<>aLaunchCrea; 1; 1)
					<>aLaunchSuff{1}:=$theSuffix
					<>aLaunchCrea{1}:=$theCreator
					<>aLaunchApp{1}:=$theApp
				End if 
			Until (OK=0)
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	Else 
		If (OptKey=0)
			//ALERT("Files does not exist.")
		End if 
	End if 
End if 