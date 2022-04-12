//%attributes = {"publishedWeb":true}
If (False:C215)
	// Method: PrefsSave
	TCStrong_nds
	//02/21/2002.nds 
End if 

C_LONGINT:C283($i; $prefsCount)
C_BOOLEAN:C305(<>PrefsChange)

// If another process is saving the prefs, we don't need to do it again,
//   so just return without doing anything.
If (<>PrefsChange)
	If (Not:C34(Semaphore:C143("$PrefsSave")))  // Make sure you don't combine this with the line above.   
		SET CHANNEL:C77(10; <>PrefsPath)
		
		If (OK=1)
			$prefsCount:=Size of array:C274(<>aPrefNames)
			SEND VARIABLE:C80($prefsCount)  // The number of preferences.
			
			For ($i; 1; $prefsCount)
				SEND VARIABLE:C80(<>aPrefNames{$i})
				SEND VARIABLE:C80(<>aPrefValues{$i})
			End for 
			
			SET CHANNEL:C77(11; "")
			//If (<>Platform#Windows)
			//SET DOCUMENT TYPE(<>PrefsPath;"pref")// Change the file type of the prefs file.
			//End if 
			
		End if 
		
		<>PrefsChange:=False:C215
		CLEAR SEMAPHORE:C144("$PrefsSave")
	End if 
End if 