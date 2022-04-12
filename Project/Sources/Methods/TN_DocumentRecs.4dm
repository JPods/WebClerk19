//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TN_DocumentRecs 
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
TRACE:C157
C_LONGINT:C283($err; $i; $k; $1; $doHtml)
C_TEXT:C284($fileFold; $theSite)
ARRAY TEXT:C222(aText1; 0)
vText1:=""
$fileFold:=Get_FolderName("Select folder to List Files.")
If ($fileFold#"")
	$error:=HFS_CatToArray($fileFold; "aText1")
	vText1:=""
	$theSite:=Replace string:C233($fileFold; Folder separator:K24:12; "/")
	$p:=Position:C15("/images/"; $theSite)
	If ($p=0)
		ALERT:C41("The path must contained a 'jitWeb' folder")
	Else 
		$theSite:=Substring:C12($theSite; $p)
		$k:=Size of array:C274(aText1)
		If (vHere>1)
			$thePrimary:=STR_GetProtectString(Table name:C256(ptCurTable))
			$tableNum:=Table:C252(ptCurTable)
		End if 
		
		For ($i; 1; $k)
			CREATE RECORD:C68([Document:100])
			If (vHere>1)
				[Document:100]customerID:7:=$thePrimary
				[Document:100]tableNum:6:=$tableNum
			End if 
			
			[Document:100]imageName:2:=aText1{$i}
			[Document:100]path:4:=$theSite
			SAVE RECORD:C53([Document:100])
		End for 
	End if 
End if 