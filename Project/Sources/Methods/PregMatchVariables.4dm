//%attributes = {}


// ----------------------------------------------------
// User name (OS): J.Medlen
// Date and time: 2016-10-10T00:00:00, 18:22:28
// ----------------------------------------------------
// Method: PregMatchVariables
// Description
// Modified: 10/10/16
// 
// 
//
// Parameters
// ----------------------------------------------------



//Script Preg Match All Variables 20161010
//The REGEX Plugin defines . as any character except line feed \n (NOT carriage return \r)
//you either have to replace \r with \n to use . or negate it [^\r.]
//(?m) at the beginning makes the match Multi Line each line of text matches ^ and $

ConsoleLaunch

//==================================
// Type variables
//==================================

C_TEXT:C284(vtRegex; vText; vText1; vText2; vtFS; vtLine; vtClipboard)
C_LONGINT:C283(vi1; viMatch)
vtFS:=Char:C90(47)
vtLine:=vtFS+vtFS+("="*34)

ARRAY TEXT:C222(atBoolean; 0)
ARRAY TEXT:C222(atDate; 0)
ARRAY TEXT:C222(atLongInt; 0)
ARRAY TEXT:C222(atMatch; 0)
ARRAY TEXT:C222(atReal; 0)
ARRAY TEXT:C222(atText; 0)
ARRAY TEXT:C222(atTime; 0)
ARRAY TEXT:C222(atUnique; 0)
ARRAY TEXT:C222(atUnknown; 0)
ARRAY TEXT:C222(atUnknownReal; 0)
ARRAY TEXT:C222(atUnknownText; 0)

// $ local variables <> interprocess variables v process variables

vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b|\\ballowAlerts_boo\\b|\\b\\w+?\\s*?:=..)"  // 20160912

vText:=Get text from pasteboard:C524
vtClipboard:=vText
vText2:=""

vText:=Replace string:C233(vText; "\r"; "\n")
viMatch:=Preg Match All(vtRegex; vText; atMatch; Regex Multi Line)
SORT ARRAY:C229(atMatch; >)

vText1:=""
If (viMatch>=1)
	//ALERT(String(viMatch))
	For (vi1; 1; Size of array:C274(atMatch))
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
				
			: (atUnique{vi1}="@:=@\"")
				// exception do not type or initialize
				atUnique{vi1}:=Replace string:C233(atUnique{vi1}; " :="; ":=")
				atUnique{vi1}:=Substring:C12(atUnique{vi1}; 1; Position:C15(":="; atUnique{vi1})-1)
				APPEND TO ARRAY:C911(atUnknownText; atUnique{vi1})
				
			: (atUnique{vi1}="@:=@")
				// exception do not type or initialize
				atUnique{vi1}:=Replace string:C233(atUnique{vi1}; " :="; ":=")
				atUnique{vi1}:=Substring:C12(atUnique{vi1}; 1; Position:C15(":="; atUnique{vi1})-1)
				APPEND TO ARRAY:C911(atUnknownReal; atUnique{vi1})
				
			: ((atUnique{vi1}="$vb@") | (atUnique{vi1}="<>vb@") | (atUnique{vi1}="vb@") | (atUnique{vi1}="allowAlerts_boo"))
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
				
			Else 
				
				APPEND TO ARRAY:C911(atUnknown; atUnique{vi1})
				
		End case 
		
	End for 
End if 

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
	vText1:=vText1+vtFS+vtFS+" "
	For (vi1; 1; Size of array:C274(atUnknown))
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
		vText1:=vText1+atBoolean{vi1}+":=False\r"
	End for 
End if 

If (Size of array:C274(atDate)>0)
	For (vi1; 1; Size of array:C274(atDate))
		vText1:=vText1+atDate{vi1}+":=!00/00/00!\r"
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
SET TEXT TO PASTEBOARD:C523(vText1)

ALERT:C41("Variable Declarations copied to Clipboard")

