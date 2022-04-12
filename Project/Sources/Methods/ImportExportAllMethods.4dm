//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/16/16, 13:18:33
// ----------------------------------------------------
// Method: ImportExportAllMethods
// Description
// 
//
// Parameters
// ----------------------------------------------------
// Script Import Export all Methods 20160216
// 02/16/2016 13:12 - James W Medlen
C_TEXT:C284($folderPath; $vtCode)

$folderPath:=Get 4D folder:C485(Database folder:K5:14)+"methods"+Folder separator:K24:12
ARRAY TEXT:C222($aTextFileNames; 0)
ARRAY TEXT:C222($aTextCode; 0)
C_TEXT:C284($vtCode; $vtFileName)
C_LONGINT:C283($incRay; $cntRay)
C_BLOB:C604($vblob_x)
CONFIRM:C162("Import or export methods?"; "Import"; "Export")

If (OK=1)
	DOCUMENT LIST:C474($folderPath; $aTextFileNames)
	$cntRay:=Size of array:C274($aTextFileNames)
	For ($incRay; 1; $cntRay)
		$vtFileName:=$aTextFileNames{$incRay}
		DOCUMENT TO BLOB:C525($folderPath+$vtFileName; $vblob_x)
		//METHOD SET CODE($vtFileName;BLOB to text($vblob_x;UTF8 text without length))  // compiler error when all one line //
		$vtCode:=BLOB to text:C555($vblob_x; UTF8 text without length:K22:17)
		METHOD SET CODE:C1194($vtFileName; $vtCode)
	End for 
	ALERT:C41("Import Complete")
Else 
	If (Test path name:C476($folderPath)#Is a folder:K24:2)
		CREATE FOLDER:C475($folderPath; *)
	End if 
	//METHOD GET PATHS(Path Project method;$aTextFileNames)
	METHOD GET PATHS:C1163(Path all objects:K72:16; $aTextFileNames)  //Path project form
	METHOD GET CODE:C1190($aTextFileNames; $aTextCode)
	For ($incRay; 1; Size of array:C274($aTextFileNames))
		$vtFileName:=$aTextFileNames{$incRay}
		SET BLOB SIZE:C606($vblob_x; 0)
		TEXT TO BLOB:C554($aTextCode{$incRay}; $vblob_x; UTF8 text without length:K22:17)
		BLOB TO DOCUMENT:C526($folderPath+$vtFileName; $vblob_x)
	End for 
	ALERT:C41("Export Complete")
End if 
SHOW ON DISK:C922($folderPath)

