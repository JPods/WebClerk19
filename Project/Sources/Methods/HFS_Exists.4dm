//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
	//12/18/03.prf 
	//Added test for empty string as Test path name
	//returns "0" incorrectly in that case!
End if 
//TRACE
C_TEXT:C284($1; $pathname)
$pathname:=PathToSystem($1)
C_LONGINT:C283($0; $result)

If ($pathname#"")
	//1 = file exists
	//0 = folder exists
	//<0 = invalid path, return OS error code
	$result:=Test path name:C476($pathname)
	
	If ($result<0)
		$0:=0
	Else 
		$0:=1  //file or folder exists
	End if 
	
Else 
	$0:=0  //empty string
End if 