//%attributes = {"publishedWeb":true}
If (False:C215)
	// Method: PrefsPut (pref name; value)
	
	TCStrong_nds
	//02/21/2002.nds 
	
End if 

C_LONGINT:C283($element)
C_TEXT:C284($1; $2)

If ($1#"")
	$element:=Find in array:C230(<>aPrefNames; $1)
	If ($element<=0)
		$element:=Size of array:C274(<>aPrefNames)+1
		INSERT IN ARRAY:C227(<>aPrefNames; $element)
		<>aPrefNames{$element}:=$1
		INSERT IN ARRAY:C227(<>aPrefValues; $element)
	End if 
	
	If (<>aPrefValues{$element}#$2)
		<>aPrefValues{$element}:=$2
		<>PrefsChange:=True:C214  // So the PrefsSave method knows the file must be updated.
	End if 
	
Else 
	BugAlert("PrefsPut method"; "An invalid preference name was passed to the method.")
End if 