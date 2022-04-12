//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	
	TCStrong_prf_v144_FilePack
	TCStrong_prf_v144_FilePackReTok
End if 

C_TEXT:C284($0; $1; $requestText; $2; $suggestedRequest; $fileFold; $myDocName)
$requestText:=$1
$suggestedRequest:=$2

TRACE:C157

$myDocName:=Request:C163($requestText; $suggestedRequest; "Name file, Select file in target folder")
If (OK=1)
	$fileFold:=Get_FolderName("")
	If ($fileFold#"")
		$0:=$fileFold+$myDocName
	Else 
		$0:=""
	End if 
Else 
	$0:=""
End if 