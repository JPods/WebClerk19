//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/13/18, 19:46:40
// ----------------------------------------------------
// Method: pathUsingTable
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptTable)
C_TEXT:C284($2; $baseFileName)
C_BOOLEAN:C305($3; $createPath)
C_TEXT:C284($0)
C_BOOLEAN:C305($doTable)
C_LONGINT:C283($lenSuffix)

$createPath:=False:C215
$baseFileName:=""
$ptTable:=ptCurTable
If (Count parameters:C259>0)
	$ptTable:=$1
	If (Count parameters:C259>1)
		$suff:=SuffixGet($2)
		$lenSuffix:=Length:C16($suff)
		If ($lenSuffix=0)
			$baseFileName:=$2
		Else 
			$lenSuffix:=$lenSuffix+1
			$baseFileName:=Substring:C12($2; 1; Length:C16($2)-$lenSuffix)
		End if 
		If (Count parameters:C259>2)
			$createPath:=$3
		End if 
	End if 
End if 
C_LONGINT:C283($taskID)
$0:=Storage:C1525.folder.jitF+Table name:C256($ptTable)+Folder separator:K24:12
Case of 
	: (Record number:C243($ptTable->)<0)  // no specific record
		// drop out
	: (ptCurTable=(->[Customer:2]))
		$0:=$0+[Customer:2]customerID:1+Folder separator:K24:12
	: (ptCurTable=(->[Contact:13]))
		$0:=$0+String:C10([Contact:13]idNum:28)+Folder separator:K24:12
	: (ptCurTable=(->[Vendor:38]))
		$0:=$0+[Vendor:38]vendorID:1+Folder separator:K24:12
	: (ptCurTable=(->[Item:4]))
		$0:=$0+[Item:4]itemNum:1+Folder separator:K24:12
	: (ptCurTable=(->[Employee:19]))
		$0:=$0+[Employee:19]nameID:1+Folder separator:K24:12
	: (ptCurTable=(->[Rep:8]))
		$0:=$0+[Rep:8]RepID:1+Folder separator:K24:12
	: (ptCurTable=(->[Invoice:26]))
		TaskIDReturn(->[Invoice:26]idNumTask:78)
		$0:=$0+String:C10([Invoice:26]idNumTask:78)+Folder separator:K24:12
	: (ptCurTable=(->[Order:3]))
		TaskIDReturn(->[Order:3]idNumTask:85)
		$0:=$0+String:C10([Order:3]idNumTask:85)+Folder separator:K24:12
	: (ptCurTable=(->[Proposal:42]))
		TaskIDReturn(->[Proposal:42]idNumTask:70)
		$0:=$0+String:C10([Proposal:42]idNumTask:70)+Folder separator:K24:12
	: (ptCurTable=(->[PO:39]))
		$0:=$0+String:C10([PO:39]idNum:5)+Folder separator:K24:12
		//  Else 
		// drop out
End case 

If ($createPath)
	If (Test path name:C476($0)#0)
		CREATE FOLDER:C475($0; *)
	End if 
End if 

If ($baseFileName#"")
	$0:=$0+$baseFileName+"-"+String:C10(DateTime_Enter)
	If ($suff#"")
		$0:=$0+"."+$suff
	End if 
End if 
