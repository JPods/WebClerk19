//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/24/06, 09:56:08
// ----------------------------------------------------
// Method: Method: KeyModifierCurrent
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283(CapKey; ShftKey; OptKey; CmdKey; CtlKey)
CapKey:=Num:C11(Caps lock down:C547)
ShftKey:=Num:C11(Shift down:C543)
If (Is macOS:C1572)
	OptKey:=Num:C11(Macintosh option down:C545)
Else 
	OptKey:=Num:C11(Windows Alt down:C563)
End if 
If (Is macOS:C1572)
	CmdKey:=Num:C11(Macintosh command down:C546)
Else 
	CmdKey:=Num:C11(Windows Ctrl down:C562)
End if 
CtlKey:=Num:C11((CmdKey=1) & (ShftKey=1) & (OptKey=1))
//Get Modifiers(CapKey;ShftKey;OptKey;CmdKey;CtlKey)
//$modKey:=US Modifiers
//$modKey:=$modKey\256
//CmdKey:=($modKey%2)
//$modKey:=$modKey\2
//ShftKey:=($modKey%2)
//$modKey:=$modKey\2
//CapKey:=($modKey%2)
//$modKey:=$modKey\2
//OptKey:=($modKey%2)
//$modKey:=$modKey\2
//CtlKey:=($modKey%2)