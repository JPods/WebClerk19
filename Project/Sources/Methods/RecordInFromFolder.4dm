//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-01T00:00:00, 12:43:50
// ----------------------------------------------------
// Method: RecordInFromFolder
// Description
// Modified: 06/01/17
// 
// 

// REF: ImportExportAllMethods
// REF: Records_In
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($folderPath)
ARRAY TEXT:C222($aTextFileNames; 0)
ARRAY TEXT:C222($aTextCode; 0)
C_LONGINT:C283($incRay; $cntRay)
C_TEXT:C284($vtCode; $vtFileName; $checkString)
C_LONGINT:C283($tableNum)


CONFIRM:C162("Load Records_Out from a folder.")
If (OK=1)
	// $folderPath:=Get 4D folder(Database folder)
	$folderPath:=Select folder:C670("Select Records_Out folder.")
	If (OK=1)
		DOCUMENT LIST:C474($folderPath; $aTextFileNames)
		$cntRay:=Size of array:C274($aTextFileNames)
		For ($incRay; 1; $cntRay)
			$vtFileName:=$aTextFileNames{$incRay}
			$tableNum:=Num:C11(Substring:C12($vtFileName; 1; 3))
			$checkString:=Substring:C12($vtFileName; 4; 5)
			If (($checkString="Recs_") & ($tableNum>0))
				allowAlerts_boo:=False:C215
				vText11:=$folderPath+$vtFileName
				Records_In(Table:C252($tableNum); ->vText11; False:C215)
				allowAlerts_boo:=True:C214
			End if 
		End for 
	End if 
End if 