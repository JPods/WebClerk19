//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: HFSPathNameSuffix
	TCJIT_prf_v201
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

C_TEXT:C284($1; $working; $2)
//C_POINTER($2;$3;$4)
C_TEXT:C284(docName; docSuffix; docPath; $vtPath)
If (Count parameters:C259=0)
	$vtPath:=Storage:C1525.folder.jitF+"jitPrefs"+Folder separator:K24:12+"images"+Folder separator:K24:12+"pallet.png"
Else 
	$vtPath:=$1
End if 
docPath:=HFS_ParentName($vtPath)
docName:=HFS_ShortName($vtPath)

C_OBJECT:C1216($obPath)
$obPath:=Path to object:C1547($vtPath)
docSuffix:=$obPath.extension
//$obPath.parentFolder="/first/"
//$obPath.name="second"
//$obPath.extension=".bundle"
//$obPath.isFolder=true

//

If (docSuffix="")
	docSuffix:="txt"
End if 

If (docPath="")
	docPath:=Storage:C1525.folder.jitF
End if 