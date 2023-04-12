C_TIME:C306($myDoc)
C_TEXT:C284($vtWorking; $vtDocPath)

$vtDocPath:=HFS_GetParent(Structure file:C489)+"Sources"+Folder separator:K24:12+"Forms"+Folder separator:K24:12+"ImportCheck"+Folder separator:K24:12+"form.4DForm"

//$vtDocPath:="Beldin:Applications:4D v18 R5:Project:Sources:TableForms:3:Output:form.4DForm"
If ($vtDocPath="")
	$myDoc:=Open document:C264(""; Get pathname:K24:6)
	If (OK=1)
		C_TEXT:C284($vtWorking)
		CLOSE DOCUMENT:C267($myDoc)
		$vtDocPath:=document
	End if 
End if 
$vtWorking:=Document to text:C1236($vtDocPath)
C_OBJECT:C1216(obData)
Form:C1466.obDisk:=JSON Parse:C1218($vtWorking)
