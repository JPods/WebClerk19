//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)  //pointer to Text from Zon Jr
C_LONGINT:C283($result)
Path_Set(Storage:C1525.folder.jitExportsF)
C_TEXT:C284($DocPathName)
C_TIME:C306(vtDOCRef)
$DocPathName:=TC_PutFileNameWC("Zon Jr Text File."; "ZonJr Receipt")
If ($DocPathName#"")
	vtDOCRef:=Create document:C266($DocPathName; "TEXT")
	SEND PACKET:C103(vtDOCRef; $1->)
	CLOSE DOCUMENT:C267(vtDOCRef)
End if 