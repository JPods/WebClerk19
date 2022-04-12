//%attributes = {"publishedWeb":true}
//Procedure: U_SafeHFSMove
C_TEXT:C284($1; $SourcePath)  //must be only a file with a path
$SourcePath:=$1
C_TEXT:C284($2; $DestPath)  //Must be only a path not a file with a path
$DestPath:=$2

C_TEXT:C284($ShortName)
$ShortName:=HFS_ShortName($SourcePath)
C_LONGINT:C283($result)
If ($ShortName#"")
	C_TEXT:C284($UniqueName)
	$UniqueName:=U_UniqueFileNam($DestPath; $ShortName)
	If ($UniqueName#$ShortName)
		$result:=HFS_Rename($SourcePath; $UniqueName)
		$SourcePath:=HFS_ParentName($SourcePath)+$UniqueName
	End if 
End if 
$result:=HFS_Move($SourcePath; $DestPath)