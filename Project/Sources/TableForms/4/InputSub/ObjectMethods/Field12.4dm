ItemMfgIDDefaults
C_LONGINT:C283($w)
$w:=Find in array:C230(<>aMfg; [Item:4]mfrid:53)
If ($w<1)
	[Item:4]location:9:=0
Else 
	[Item:4]location:9:=<>aMfgIdKey{$w}
End if 
