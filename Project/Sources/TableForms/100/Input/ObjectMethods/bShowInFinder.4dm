// ### bj ### 20200101_1753
C_TEXT:C284($pathImage; $pathParent)
C_LONGINT:C283($error)
$pathImage:=[Document:100]Path:4
$error:=Test path name:C476($pathImage)
If ($error=-43)
	$pathImage:=Convert path POSIX to system:C1107($pathImage)
	$error:=Test path name:C476($pathImage)
End if 
If ($error=1)
	$pathParent:=HFS_ParentName($pathImage)
	PathLaunchFolder($pathParent)
End if 