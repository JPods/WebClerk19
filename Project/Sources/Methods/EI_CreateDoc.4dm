//%attributes = {"publishedWeb":true}
//Procedure: EI_CreateDoc
//  $myOK:=EI_CreateDoc (myDocName;myDoc;"")
C_LONGINT:C283($0; $result; $p)
C_POINTER:C301($1; $2)
C_TEXT:C284($3; $docName; $fileOnly; $docNameWSuffix)
C_TEXT:C284($suffix)
//Path_Set (Storage.folder.jitExportsF)
If ($1->="")
	$docName:="Untitled"
Else 
	$docName:=$1->
End if 

HFS_PathNameSuffix($docName)  //operates on variables: docName;docSuffix;docPath
C_TEXT:C284(docName; docSuffix; docPath)

$docName:=TC_PutFileNameWC("Name Export Document"; docName+"."+docSuffix; Storage:C1525.folder.jitExportsF)

//$docName:=Put_FileName ("Name Export Document";docName+"."+docSuffix)
//TRACE
If ($docName#"")
	$2->:=CreateDocumentXPlatform($docName)
	$0:=OK
	//$2->:=create document($docName)
	// Modified by: williamjames (110119)  Attempt to fix PC's changing all docs to txt
	If (False:C215)
		If (document#$docName)
			CLOSE DOCUMENT:C267($2->)
			$err:=HFS_Rename(document; HFS_ShortName($docName))
			$2->:=Open document:C264($docName)
			$0:=OK
		End if 
	End if 
	$1->:=document
Else 
	$0:=0
End if 