C_TEXT:C284($theFolder)

$theFolder:=PathToSystem([Document:100]Path:4)
$theFolder:=HFS_ParentName($theFolder)
PathLaunchFolder($theFolder)
