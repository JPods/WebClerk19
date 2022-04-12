//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/23/21, 23:47:16
// ----------------------------------------------------
// Method: Cat_DocumentListt
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $vtVendorID; $2; $vtVendorTag; $3; $vtPathToCatalog)

// text fields to manage each page
C_TEXT:C284($vtCatalog; $vtPathToCatalog)
C_TEXT:C284($vtWebData)

C_TEXT:C284($vtChangeReport)
$vtChangeReport:=""

// ON ERR CALL("OEC_Web")
ON ERR CALL:C155("")

If (Count parameters:C259=3)
	$vtVendorID:=$1
	$vtVendorTag:=$2
	$vtPathFolder:=$3
	OK:=1
Else 
	// CONFIRM("Open DuraVent Catagory Folder")
	OK:=1
	If (OK=1)
		$vtVendorID:="CCS"
		$vtPathFolder:="/Users/williamjames/Dropbox/AdvanceChimney/Copperfield-Data/CCS-text"
		$vtVendorTag:="-CCS"
		
		// $vtPathFolder=select folder("")
	End if 
End if 
If (OK=1)
	C_OBJECT:C1216($voCatalog)
	$voCatalog:=New object:C1471
	$voCatalog.vendorID:=$vtVendorID
	$voCatalog.vendorTag:=$vtVendorTag
	$voCatalog.dateProcessed:=Current date:C33
	$voCatalog.timeProcessed:=Current time:C178
	$voCatalog.dtProcessed:=DateTime_Enter
	$voCatalog.folder:=$vtPathFolder
	$vtPathFolder:=Convert path POSIX to system:C1107($vtPathFolder)
	ARRAY TEXT:C222($atFiles; 0)
	DOCUMENT LIST:C474($vtPathFolder; $atFiles)
	C_LONGINT:C283($w)
	C_LONGINT:C283($incFiles; $cntFiles)
	$cntFiles:=Size of array:C274($atFiles)
	For ($incFiles; 1; $cntFiles)
		$vtPathToCatalog:=$vtPathFolder+Folder separator:K24:12+$atFiles{$incFiles}
		If (Position:C15(".txt"; $atFiles{$incFiles})>0)
			Cat_DocToCollection($atFiles{$incFiles}; $vtPathFolder; $voCatalog)
		End if 
	End for 
End if 
$vtFullCatalog:=JSON Stringify:C1217($voCatalog)
C_TIME:C306($vhDocRef)
$vhDocRef:=Create document:C266($vtPathFolder+$vtVendorTag+Date_yyyy_mm_dd_hh_mm+"json.txt")
If (OK=1)
	CLOSE DOCUMENT:C267($vhDocRef)
	TEXT TO DOCUMENT:C1237(Document; $vtFullCatalog)
End if 
If (False:C215)
	C_OBJECT:C1216($voTallyResults)
	$voTallyResults:=ds:C1482.TallyResults.new()
	$voTallyResults.name:=$vtVendorID+" "+Date_yyyy_mm_dd_hh_mm
	$voTallyResults.purpose:="Catalog"
	$voTallyResults.dtCreated:=DateTime_Enter
	$voTallyResults.obGeneral:=New object:C1471
	$voTallyResults.obGeneral.catelog:=$voCatalog
	$voTallyResults.save()
End if 