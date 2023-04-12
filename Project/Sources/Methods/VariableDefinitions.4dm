//%attributes = {}

//Script Preg Match All Variables 20170412_1452
//The REGEX Plugin defines . as any character except line feed \n (NOT carriage return \r)
//you either have to replace \r with \n to use . or negate it [^\r.]
//(?m) at the beginning makes the match Multi Line each line of text matches ^ and $

ConsoleLaunch

//==================================
// Type variables
//==================================

C_TEXT:C284(vtRegex; vText; vText1; vText2; vtFS; vtLine; vtClipboard; vtDeclarations)
C_LONGINT:C283(vi1; viMatch; vicontinue; viLength)
C_TEXT:C284(vText1; "\n")
vtFS:=Char:C90(47)
vtLine:=vtFS+vtFS+("="*34)
vicontinue:=0
viLength:=0
vText1:=""

ARRAY TEXT:C222(atBlob; 0)
ARRAY TEXT:C222(atBoolean; 0)
ARRAY TEXT:C222(atDate; 0)
ARRAY TEXT:C222(atLongInt; 0)
ARRAY TEXT:C222(atMatch; 0)
ARRAY TEXT:C222(atReal; 0)
ARRAY TEXT:C222(atText; 0)
ARRAY TEXT:C222(atTime; 0)
ARRAY TEXT:C222(atPointer; 0)
ARRAY TEXT:C222(atUnique; 0)
ARRAY TEXT:C222(atUnknown; 0)
ARRAY TEXT:C222(atUnknownReal; 0)
ARRAY TEXT:C222(atUnknownText; 0)
ARRAY TEXT:C222(aText1; 0)
// $ local variables <> interprocess variables v process variables
//(?<!foo)bar negative look behind ignore "]"
//vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b|\\ballowAlerts_boo\\b|(?<!])\\b\\w+?\\s*?:=..)"  // 20160912
vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b|\\ballowAlerts_boo\\b|(?<!])\\b\\w+?\\s*?:=)"  // 20170120

vText:=Get text from pasteboard:C524

vText2:=""
vText:=Replace string:C233(vText; "\r\n"; "\r")
vText:=Replace string:C233(vText; "\r"; "\n")
vText:=Replace string:C233(vText; Char:C90(96); (Char:C90(47)*2))  // ` -> //

vtClipboard:=vText

viMatch:=Preg Match All(vtRegex; vText; atMatch; Regex Multi Line)
SORT ARRAY:C229(atMatch; >)

vText1:=""
If (viMatch>=1)
	//ALERT(String(viMatch))
	For (vi1; 1; Size of array:C274(atMatch))
		
		If (atMatch{vi1}="@:=@")
			atMatch{vi1}:=Replace string:C233(atMatch{vi1}; " :="; ":=")
			atMatch{vi1}:=Substring:C12(atMatch{vi1}; 1; Position:C15(":="; atMatch{vi1})-1)
		End if 
		
		vifound:=Find in array:C230(atUnique; atMatch{vi1})
		If (vifound=-1)
			APPEND TO ARRAY:C911(atUnique; atMatch{vi1})  // mark as unique
			ConsoleLog(atMatch{vi1})
		End if 
	End for 
	For (vi1; 1; Size of array:C274(atUnique))
		
		Case of 
				
			: (atUnique{vi1}="vHere")
				// exception do not type or initialize
				APPEND TO ARRAY:C911(atUnknown; atUnique{vi1})
				
			: (atUnique{vi1}="vResponse")
				// exception do not type or initialize
				APPEND TO ARRAY:C911(atText; atUnique{vi1})
				
			: (atUnique{vi1}="@:=@\"")  // deprecated grouped with unknown
				// exception do not type or initialize
				atUnique{vi1}:=Replace string:C233(atUnique{vi1}; " :="; ":=")
				atUnique{vi1}:=Substring:C12(atUnique{vi1}; 1; Position:C15(":="; atUnique{vi1})-1)
				APPEND TO ARRAY:C911(atUnknownText; atUnique{vi1})
				
			: (atUnique{vi1}="@:=@")  // deprecated grouped with unknown
				// exception do not type or initialize
				atUnique{vi1}:=Replace string:C233(atUnique{vi1}; " :="; ":=")
				atUnique{vi1}:=Substring:C12(atUnique{vi1}; 1; Position:C15(":="; atUnique{vi1})-1)
				APPEND TO ARRAY:C911(atUnknownReal; atUnique{vi1})
				
			: ((atUnique{vi1}="$vb@") | (atUnique{vi1}="<>vb@") | (atUnique{vi1}="vb@") | (atUnique{vi1}="allowAlerts_boo") | (atUnique{vi1}="booAccept"))
				APPEND TO ARRAY:C911(atBoolean; atUnique{vi1})
				
			: ((atUnique{vi1}="$vd@") | (atUnique{vi1}="<>vd@") | (atUnique{vi1}="vd@"))
				APPEND TO ARRAY:C911(atDate; atUnique{vi1})
				
			: ((atUnique{vi1}="$vi@") | (atUnique{vi1}="<>vi@") | (atUnique{vi1}="vi@"))
				APPEND TO ARRAY:C911(atLongInt; atUnique{vi1})
				
			: ((atUnique{vi1}="$vl@") | (atUnique{vi1}="<>vl@") | (atUnique{vi1}="vl@"))
				APPEND TO ARRAY:C911(atLongInt; atUnique{vi1})
				
			: ((atUnique{vi1}="$vr@") | (atUnique{vi1}="<>vr@") | (atUnique{vi1}="vr@"))
				APPEND TO ARRAY:C911(atReal; atUnique{vi1})
				
			: ((atUnique{vi1}="$vt@") | (atUnique{vi1}="<>vt@") | (atUnique{vi1}="vt@"))
				APPEND TO ARRAY:C911(atText; atUnique{vi1})
				
			: ((atUnique{vi1}="$vh@") | (atUnique{vi1}="<>vh@") | (atUnique{vi1}="vh@"))
				APPEND TO ARRAY:C911(atTime; atUnique{vi1})
				
			: ((atUnique{vi1}="$vx@") | (atUnique{vi1}="<>vx@") | (atUnique{vi1}="vx@"))
				APPEND TO ARRAY:C911(atBlob; atUnique{vi1})
				
			: ((atUnique{vi1}="$vp@") | (atUnique{vi1}="<>vp@") | (atUnique{vi1}="vp@"))
				APPEND TO ARRAY:C911(atPointer; atUnique{vi1})
				
				
			Else 
				
				APPEND TO ARRAY:C911(atUnknown; atUnique{vi1})
				
		End case 
		
	End for 
End if 

SORT ARRAY:C229(atBlob; >)
SORT ARRAY:C229(aText1; >)
SORT ARRAY:C229(atBoolean; >)
SORT ARRAY:C229(atDate; >)
SORT ARRAY:C229(atLongInt; >)
SORT ARRAY:C229(atMatch; >)
SORT ARRAY:C229(atReal; >)
SORT ARRAY:C229(atText; >)
SORT ARRAY:C229(atTime; >)
SORT ARRAY:C229(atUnique; >)
SORT ARRAY:C229(atUnknown; >)
SORT ARRAY:C229(atUnknownReal; >)
SORT ARRAY:C229(atUnknownText; >)

//Alert(String(Size of Array(atUnique))+" Unique Variables Found")

vText1:=vText1+"\r"+vtFS+vtFS+"<declarations>\r"
vText1:=vText1+vtLine+"\r"
vText1:=vText1+vtFS+vtFS+"  Type variables \r"
vText1:=vText1+vtLine+"\r\r"

If (Size of array:C274(atUnknown)>0)
	vText2:=""
	vText1:=vText1+vtFS+vtFS+" "
	For (vi1; 1; Size of array:C274(atUnknown))
		vText2:=vText2+atUnknown{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+"\r"
			vText1:=vText1+vtFS+vtFS+" "
			vText2:=""
		End if 
		vText1:=vText1+atUnknown{vi1}+";"
	End for 
	vText1:=vText1+"\r"
End if 

If (Size of array:C274(atUnknownReal)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+vtFS+vtFS+" "+"C_REAL("
	For (vi1; 1; Size of array:C274(atUnknownReal))
		vText2:=vText2+atUnknownReal{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+vtFS+vtFS+" "+"C_REAL("
			vText2:=""
		End if 
		vText1:=vText1+atUnknownReal{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atUnknownText)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+vtFS+vtFS+" "+"C_TEXT("
	For (vi1; 1; Size of array:C274(atUnknownText))
		vText2:=vText2+atUnknownText{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+vtFS+vtFS+" "+"C_TEXT("
			vText2:=""
		End if 
		vText1:=vText1+atUnknownText{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atBoolean)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+"C_BOOLEAN("
	For (vi1; 1; Size of array:C274(atBoolean))
		vText2:=vText2+atBoolean{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+"C_BOOLEAN("
			vText2:=""
		End if 
		vText1:=vText1+atBoolean{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atBlob)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+"C_BLOB("
	For (vi1; 1; Size of array:C274(atBlob))
		vText2:=vText2+atBlob{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+"C_BLOB("
			vText2:=""
		End if 
		vText1:=vText1+atBlob{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atDate)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+"C_DATE("
	For (vi1; 1; Size of array:C274(atDate))
		vText2:=vText2+atDate{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+"C_DATE("
			vText2:=""
		End if 
		vText1:=vText1+atDate{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atLongInt)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+"C_LONGINT("
	For (vi1; 1; Size of array:C274(atLongInt))
		vText2:=vText2+atLongInt{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+"C_LONGINT("
			vText2:=""
		End if 
		vText1:=vText1+atLongInt{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atReal)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+"C_REAL("
	For (vi1; 1; Size of array:C274(atReal))
		vText2:=vText2+atReal{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+"C_REAL("
			vText2:=""
		End if 
		vText1:=vText1+atReal{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atText)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText2:=""
	vText1:=vText1+"C_TEXT("
	For (vi1; 1; Size of array:C274(atText))
		vText2:=vText2+atText{vi1}+";"
		If (Length:C16(vText2)>80)
			vText1:=vText1+")\r"
			vText1:=vText1+"C_TEXT("
			vText2:=""
		End if 
		vText1:=vText1+atText{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

If (Size of array:C274(atTime)>0)
	If (Caps lock down:C547)
		vText1:=vText1+"FR Text\t"
	End if 
	vText1:=vText1+"C_TIME("
	For (vi1; 1; Size of array:C274(atTime))
		vText1:=vText1+atTime{vi1}+";"
	End for 
	vText1:=vText1+")\r"
End if 

vText1:=Replace string:C233(vText1; ";)"; ")")
vText1:=Replace string:C233(vText1; ";\r"; "\r")

//==================================
// Initialize variables
//==================================

vText1:=vText1+"\r"+vtLine+"\r"
vText1:=vText1+vtFS+vtFS+"  Initialize variables \r"
vText1:=vText1+vtLine+"\r\r"

If (Size of array:C274(atBoolean)>0)
	For (vi1; 1; Size of array:C274(atBoolean))
		If (atBoolean{vi1}="booAccept")
			vText1:=vText1+atBoolean{vi1}+":=True\r"
		Else 
			vText1:=vText1+atBoolean{vi1}+":=False\r"
		End if 
	End for 
End if 

If (Size of array:C274(atDate)>0)
	For (vi1; 1; Size of array:C274(atDate))
		vText1:=vText1+atDate{vi1}+":=!00/00/00!\r"
	End for 
End if 

If (Size of array:C274(atBlob)>0)
	For (vi1; 1; Size of array:C274(atBlob))
		vText1:=vText1+atBlob{vi1}+":=0\r"
	End for 
End if 

If (Size of array:C274(atLongInt)>0)
	For (vi1; 1; Size of array:C274(atLongInt))
		vText1:=vText1+atLongInt{vi1}+":=0\r"
	End for 
End if 

If (Size of array:C274(atReal)>0)
	For (vi1; 1; Size of array:C274(atReal))
		vText1:=vText1+atReal{vi1}+":=0\r"
	End for 
End if 

If (Size of array:C274(atText)>0)
	For (vi1; 1; Size of array:C274(atText))
		vText1:=vText1+atText{vi1}+":=\"\"\r"
	End for 
End if 

If (Size of array:C274(atTime)>0)
	For (vi1; 1; Size of array:C274(atTime))
		vText1:=vText1+atTime{vi1}+":=0\r"
	End for 
End if 

vText1:=vText1+vtFS+vtFS+"</declarations>\r\r"
//vText1:=vText1+vtClipboard
//SET TEXT TO PASTEBOARD(vText1)

//ALERT("Variable Declarations copied to Clipboard")


// Replace old declarations
vtDeclarations:="(?s)\n.."+vtFS+vtFS+"<declarations>.*?</declarations>\n"

viMatch:=Preg Match(vtDeclarations; vtClipboard)
If (viMatch=1)
	vText:=Preg Replace(vtDeclarations; vText1; vtClipboard)
Else 
	vText:=vText1+vtClipboard
End if 

// Script Indent Text From Clip 20161129
// ### jwm ### 20161117_1619

ARRAY TEXT:C222(aText1; 0)
C_LONGINT:C283(viIndent)
viIndent:=0

//vText:=Get text from pasteboard
vText:=Replace string:C233(vText; Storage:C1525.char.crlf; "\r")
vText:=Replace string:C233(vText; "\n"; "\r")
TextToArray(vText; ->aText1; "\r"; True:C214)

ARRAY LONGINT:C221(aiIndent; Size of array:C274(aText1))

//script Basic Subrecord Loop
//Shift & Caps Lock Key to Exit

Open window:C153(100; 200; 500; 300; 8; "Progress")
ERASE WINDOW:C160
GOTO XY:C161(6; 3)

MESSAGE:C88("Starting Script Basic Loop")

vi2:=Size of array:C274(aText1)

For (vi1; 1; vi2)
	If (Shift down:C543 & Caps lock down:C547)
		vi1:=vi2
	End if 
	
	vrPercent:=Round:C94((vi1/vi2*100); 0)
	
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88(" Record "+String:C10(vi1)+" of "+String:C10(vi2)+"  "+String:C10(vrPercent)+" %")
	
	aText1{vi1}:=Preg Replace("(?im)^\\s*"; ""; aText1{vi1})
	aText1{vi1}:=Preg Replace("\\s*"+(Char:C90(47)*2); "  "+(Char:C90(47)*2); aText1{vi1})
	
	aiIndent{vi1}:=viIndent
	Case of 
		: (Preg Match("(?im)^\\s*"+(Char:C90(47)*2)+".*"; aText1{vi1})=1)
			
		: (Preg Match(": \\(.*\\)"; aText1{vi1})=1)
			
		: (Preg Match("(?im)^\\s*End If\\b"; aText1{vi1})=1)
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (Preg Match("(?im)^\\s*End For\\b"; aText1{vi1})=1)
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (Preg Match("(?im)^\\s*End Case\\b"; aText1{vi1})=1)
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (Preg Match("(?im)^\\s*End While\\b"; aText1{vi1})=1)
			viIndent:=viIndent-1
			aiIndent{vi1}:=aiIndent{vi1}-1
			
		: (Preg Match("(?im)^\\s*If\\b"; aText1{vi1})=1)
			viIndent:=viIndent+1
			
		: (Preg Match("(?im)^\\s*For\\b"; aText1{vi1})=1)
			viIndent:=viIndent+1
			
		: (Preg Match("(?im)^\\s*Case of\\b"; aText1{vi1})=1)
			viIndent:=viIndent+1
			
		: (Preg Match("(?im)^\\s*While\\b"; aText1{vi1})=1)
			viIndent:=viIndent+1
			
		: (Preg Match("(?im)^\\s*Else\\b"; aText1{vi1})=1)
			aiIndent{vi1}:=aiIndent{vi1}-1
			
	End case 
End for 

vi2:=Size of array:C274(aText1)

vText1:=""
For (vi1; 1; vi2)
	If (Shift down:C543 & Caps lock down:C547)
		vi1:=vi2
	End if 
	
	vrPercent:=Round:C94((vi1/vi2*100); 0)
	
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88(" Record "+String:C10(vi1)+" of "+String:C10(vi2)+"  "+String:C10(vrPercent)+" %")
	
	vText1:=vText1+("\t"*aiIndent{vi1})+aText1{vi1}+"\r"
	
End for 

// Clean End of Script 20170118

vText1:=Replace string:C233(vText1; Storage:C1525.char.crlf; "\r")
vText1:=Replace string:C233(vText1; "\n"; "\r")
viLength:=Length:C16(vText1)
If (viLength>0)
	viContinue:=1
	While (viContinue=1)
		Case of 
			: (viLength=1)
				If (vText1[[viLength]]="\r")
					vText1:=""
				End if 
				viContinue:=0
				
			: (viLength>1)
				If (vText1[[viLength]]="\r")
					vText1:=Substring:C12(vText1; 1; viLength-1)
				Else 
					vicontinue:=0
				End if 
		End case 
		viLength:=Length:C16(vText1)
		
	End while 
	If (viLength>0)
		vText1:=vText1+"\r"
		
	End if 
	
End if 

// reduce 3 or more carriage returns to 2
vText1:=Preg Replace("\r{3,}"; "\r\r"; vText1)

SET TEXT TO PASTEBOARD:C523(vText1)

ERASE WINDOW:C160
GOTO XY:C161(6; 3)
MESSAGE:C88("Ending Script Basic Loop")
CLOSE WINDOW:C154

ALERT:C41("Updated Script on Clipboard")
