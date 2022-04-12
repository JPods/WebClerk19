//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/18/16, 11:47:22
// ----------------------------------------------------
// Method: Txt_IndentClip
// Description
// 
//
// Parameters
// ----------------------------------------------------


// Script Indent Text From Clip 20161118
// ### jwm ### 20161117_1619

ARRAY TEXT:C222(aText1; 0)
C_LONGINT:C283(viIndent)
viIndent:=0

vText:=Get text from pasteboard:C524
vText:=Replace string:C233(vText; Storage:C1525.char.crlf; "\r")
vText:=Replace string:C233(vText; "\n"; "\r")
TextToArray(vText; ->aText1; "\r"; True:C214)

ARRAY LONGINT:C221(aiIndent; Size of array:C274(aText1))


vi2:=Size of array:C274(aText1)

For (vi1; 1; vi2)
	If (Shift down:C543 & Caps lock down:C547)
		vi1:=vi2
	End if 
	
	aiIndent{vi1}:=viIndent
	Case of 
		: (Preg Match("^\\s*"+(Char:C90(47)*2)+".*"; aText1{vi1})=1)
			
		: (Preg Match(": \\(.*\\)"; aText1{vi1})=1)
			
		: (aText1{vi1}="@End If@")
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (aText1{vi1}="@End For@")
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (aText1{vi1}="@End Case@")
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (aText1{vi1}="@End While@")
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (aText1{vi1}="@If@")
			viIndent:=viIndent+1
			
		: (Preg Match("For\\b"; aText1{vi1})=1)
			viIndent:=viIndent+1
			
		: (aText1{vi1}="@Case of@")
			viIndent:=viIndent+1
			
		: (aText1{vi1}="@While@")
			viIndent:=viIndent+1
			
		: (aText1{vi1}="@Else@")
			aiIndent{vi1}:=aiIndent{vi1}-1
			
	End case 
End for 

vi2:=Size of array:C274(aText1)

vText1:=""
For (vi1; 1; vi2)
	If (Shift down:C543 & Caps lock down:C547)
		vi1:=vi2
	End if 
	
	vText1:=vText1+("\t"*aiIndent{vi1})+aText1{vi1}+"\r"
	
End for 

SET TEXT TO PASTEBOARD:C523(vText1)

ALERT:C41("Indented text on Clipboard")

