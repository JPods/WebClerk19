//%attributes = {"publishedWeb":true}
If (False:C215)
	// Method: PrefsGet (pref name) -> String
	TCStrong_nds
	//02/21/2002.nds 
End if 

C_TEXT:C284($0; $1; $prefName; $prefValue)
C_LONGINT:C283($element)

$prefName:=$1

$element:=Find in array:C230(<>aPrefNames; $prefName)

If ($element>0)
	$prefValue:=<>aPrefValues{$element}
	
Else 
	// We didn't find a value. So save our current preferences (we don't want to loose
	//   them), and run aa_InitPrefs to reload any developer defined default values.
	ARRAY TEXT:C222($aPrefNamesBackup; 0)
	ARRAY TEXT:C222($aPrefValuesBackup; 0)
	COPY ARRAY:C226(<>aPrefNames; $aPrefNamesBackup)
	COPY ARRAY:C226(<>aPrefValues; $aPrefValuesBackup)
	aa_InitPrefs  // This resets <>aPrefNames and <>aPrefValues.
	$element:=Find in array:C230(<>aPrefNames; $prefName)
	If ($element>0)
		$prefValue:=<>aPrefValues{$element}
	Else 
		$prefValue:=""  // This is the default if no other is found.
	End if 
	
	// Restore our original values for <>aPrefNames and <>aPrefValues.
	COPY ARRAY:C226($aPrefNamesBackup; <>aPrefNames)
	COPY ARRAY:C226($aPrefValuesBackup; <>aPrefValues)
	
	// If we found a value in aa_InitPrefs, let's keep it.
	If ($prefValue#"")
		PrefsPut($prefName; $prefValue)
	End if 
End if 

$0:=$prefValue