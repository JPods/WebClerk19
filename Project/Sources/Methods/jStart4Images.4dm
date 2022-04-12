//%attributes = {}
If (False:C215)
	Version_0602
	jStart4Images
	
End if 
ARRAY LONGINT:C221(aLongInt1; 0)

PICTURE LIBRARY LIST:C564(aLongInt1; aText1)
READ PICTURE FILE:C678(Storage:C1525.folder.jitF+"jitPrefs"+Folder separator:K24:12+"images"+Folder separator:K24:12+"pallet.png"; <>pNavPallet)

If (False:C215)
	C_OBJECT:C1216($obPath)
	$obPath:=Path to object:C1547(Application file:C491)
	//$obPath.parentFolder="/first/"
	//$obPath.name="second"
	//$obPath.extension=".bundle"
	//$obPath.isFolder=true
	C_TEXT:C284($vtPath)
	$vtPath:=Convert path system to POSIX:C1106($obPath.parentFolder)
	READ PICTURE FILE:C678($vtPath+"RESOURCES/Images/library/pallet.png"; <>pNavPallet)
	// GET PICTURE FROM LIBRARY(22111; <>pNavPallet)
End if 