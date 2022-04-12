C_TEXT:C284($testConvert)

If ([DefaultQQQ:15]ShareCommand:61#"")
	OPEN URL:C673([DefaultQQQ:15]ShareCommand:61)
	// LAUNCH EXTERNAL PROCESS([Default]ShareCommand)
	DELAY PROCESS:C323(Current process:C322; 120)
	PathLaunchFolder([DefaultQQQ:15]SharePath:179)
End if 