KeyModifierCurrent
If (OptKey=1)
	CONFIRM:C162("Save Defaults")
	If (OK=1)
		If (HFS_Exists(Storage:C1525.folder.jitPrefPath+"PackagePrefs.txt")=1)
			$w:=HFS_Delete(Storage:C1525.folder.jitPrefPath+"PackagePrefs.txt")
		End if 
		myDoc:=Create document:C266(Storage:C1525.folder.jitPrefPath+"PackagePrefs.txt")
		If (OK=1)
			SEND PACKET:C103(myDoc; XMLWriteOut("NoScale"; String:C10(iLoInteger1); ""; ""))
			SEND PACKET:C103(myDoc; XMLWriteOut("alerts"; String:C10(iLoInteger2); ""; ""))
			SEND PACKET:C103(myDoc; XMLWriteOut("AutoAllPackages2Invoice"; String:C10(iLoInteger3); ""; ""))
			SEND PACKET:C103(myDoc; XMLWriteOut("ScanByAction"; String:C10(viScanByAction); ""; ""))
			SEND PACKET:C103(myDoc; XMLWriteOut("WtPrecision"; String:C10(viWtPrecision); ""; ""))
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
End if 
OptKey:=0
jCancelButton
//