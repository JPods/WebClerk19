//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/24/18, 14:45:58
// ----------------------------------------------------
// Method: Macro_VariableDefinitions
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Test method for macros
//This method will be called when you choose the "Macro test" macro
C_TEXT:C284($Txt_method; $Txt_highlighted)

//In $Txt_method, the full method content
GET MACRO PARAMETER:C997(Full method text:K5:17; $Txt_method)

//ConsoleMessage ($Txt_method)

//Script Variable Definitions 20180413.4d
//The REGEX Plugin defines . as any character except line feed \n (NOT carriage return \r)
//you either have to replace \r with \n to use . or negate it [^\r.]
//(?m) at the beginning makes the match Multi Line each line of text matches ^ and $

ConsoleLaunch

//==================================
// Type variables
//==================================

C_TEXT:C284($vtRegex; $vtext; $vtext1; $vtext2; $vtFS; $vtLine; $vtClipboard; $vtDeclarations)
C_LONGINT:C283($vi1; $viMatch; $vicontinue; $viLength)
C_TEXT:C284($vtext1; "\n")
$vtFS:=Char:C90(47)
$vtLine:=$vtFS+$vtFS+("="*34)
$vicontinue:=0
$viLength:=0
$vtext1:=""

ARRAY TEXT:C222($atBlob; 0)
ARRAY TEXT:C222($atBoolean; 0)
ARRAY TEXT:C222($atDate; 0)
ARRAY TEXT:C222($atLongInt; 0)
ARRAY TEXT:C222($atMatch; 0)
ARRAY TEXT:C222($atReal; 0)
ARRAY TEXT:C222($atText; 0)
ARRAY TEXT:C222($atTime; 0)
ARRAY TEXT:C222($atPointer; 0)
ARRAY TEXT:C222($atUnique; 0)
ARRAY TEXT:C222($atUnknown; 0)
ARRAY TEXT:C222($atUnknownReal; 0)
ARRAY TEXT:C222($atUnknownText; 0)
ARRAY TEXT:C222($atText1; 0)
// $ local variables <> interprocess variables v process variables
//(?<!foo)bar negative look behind ignore "]"
//$vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b|\\ballowAlerts_boo\\b|(?<!])\\b\\w+?\\s*?:=..)"  // 20160912
$vtRegex:="(\\$.+?\\b|\\<>.+?\\b|\\bv.+?\\b|\\ballowAlerts_boo\\b|(?<!])\\b\\w+?\\s*?:=)"  // 20170120

//$vtext:=Get text from pasteboard
$vtext:=$Txt_method

$vtext2:=""
$vtext:=Replace string:C233($vtext; "\r\n"; "\r")
$vtext:=Replace string:C233($vtext; "\r"; "\n")
$vtext:=Replace string:C233($vtext; Char:C90(96); (Char:C90(47)*2))  // ` ->  //

$vtClipboard:=$vtext

$viMatch:=Preg Match All($vtRegex; $vtext; $atMatch; Regex Multi Line)
SORT ARRAY:C229($atMatch; >)

$vtext1:=""
If ($viMatch>=1)
	//ALERT(String($viMatch))
	For ($vi1; 1; Size of array:C274($atMatch))
		
		If ($atMatch{$vi1}="@:=@")
			$atMatch{$vi1}:=Replace string:C233($atMatch{$vi1}; " :="; ":=")
			$atMatch{$vi1}:=Substring:C12($atMatch{$vi1}; 1; Position:C15(":="; $atMatch{$vi1})-1)
		End if 
		
		$vifound:=Find in array:C230($atUnique; $atMatch{$vi1})
		If ($vifound=-1)
			APPEND TO ARRAY:C911($atUnique; $atMatch{$vi1})  // mark as unique
			
			If (<>viDebugMode>410)
				ConsoleMessage($atMatch{$vi1})
			End if 
			
		End if 
	End for 
	For ($vi1; 1; Size of array:C274($atUnique))
		
		Case of 
				
			: ($atUnique{$vi1}="vHere")
				// exception do not type or initialize
				APPEND TO ARRAY:C911($atUnknown; $atUnique{$vi1})
				
			: ($atUnique{$vi1}="vResponse")
				// exception do not type or initialize
				APPEND TO ARRAY:C911($atText; $atUnique{$vi1})
				
			: ($atUnique{$vi1}="@:=@\"")  // deprecated grouped with unknown
				// exception do not type or initialize
				$atUnique{$vi1}:=Replace string:C233($atUnique{$vi1}; " :="; ":=")
				$atUnique{$vi1}:=Substring:C12($atUnique{$vi1}; 1; Position:C15(":="; $atUnique{$vi1})-1)
				APPEND TO ARRAY:C911($atUnknownText; $atUnique{$vi1})
				
			: ($atUnique{$vi1}="@:=@")  // deprecated grouped with unknown
				// exception do not type or initialize
				$atUnique{$vi1}:=Replace string:C233($atUnique{$vi1}; " :="; ":=")
				$atUnique{$vi1}:=Substring:C12($atUnique{$vi1}; 1; Position:C15(":="; $atUnique{$vi1})-1)
				APPEND TO ARRAY:C911($atUnknownReal; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vb@") | ($atUnique{$vi1}="<>vb@") | ($atUnique{$vi1}="vb@") | ($atUnique{$vi1}="allowAlerts_boo") | ($atUnique{$vi1}="booAccept"))
				APPEND TO ARRAY:C911($atBoolean; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vd@") | ($atUnique{$vi1}="<>vd@") | ($atUnique{$vi1}="vd@"))
				APPEND TO ARRAY:C911($atDate; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vi@") | ($atUnique{$vi1}="<>vi@") | ($atUnique{$vi1}="vi@"))
				APPEND TO ARRAY:C911($atLongInt; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vl@") | ($atUnique{$vi1}="<>vl@") | ($atUnique{$vi1}="vl@"))
				APPEND TO ARRAY:C911($atLongInt; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vr@") | ($atUnique{$vi1}="<>vr@") | ($atUnique{$vi1}="vr@"))
				APPEND TO ARRAY:C911($atReal; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vt@") | ($atUnique{$vi1}="<>vt@") | ($atUnique{$vi1}="vt@"))
				APPEND TO ARRAY:C911($atText; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vh@") | ($atUnique{$vi1}="<>vh@") | ($atUnique{$vi1}="vh@"))
				APPEND TO ARRAY:C911($atTime; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vx@") | ($atUnique{$vi1}="<>vx@") | ($atUnique{$vi1}="vx@"))
				APPEND TO ARRAY:C911($atBlob; $atUnique{$vi1})
				
			: (($atUnique{$vi1}="$vp@") | ($atUnique{$vi1}="<>vp@") | ($atUnique{$vi1}="vp@"))
				APPEND TO ARRAY:C911($atPointer; $atUnique{$vi1})
				
				
			Else 
				
				APPEND TO ARRAY:C911($atUnknown; $atUnique{$vi1})
				
		End case 
		
	End for 
End if 

SORT ARRAY:C229($atBlob; >)
SORT ARRAY:C229($atText1; >)
SORT ARRAY:C229($atBoolean; >)
SORT ARRAY:C229($atDate; >)
SORT ARRAY:C229($atLongInt; >)
SORT ARRAY:C229($atMatch; >)
SORT ARRAY:C229($atReal; >)
SORT ARRAY:C229($atText; >)
SORT ARRAY:C229($atTime; >)
SORT ARRAY:C229($atPointer; >)
SORT ARRAY:C229($atUnique; >)
SORT ARRAY:C229($atUnknown; >)
SORT ARRAY:C229($atUnknownReal; >)
SORT ARRAY:C229($atUnknownText; >)

//Alert(String(Size of Array($atUnique))+" Unique Variables Found")

$vtext1:=$vtext1+"\r"+$vtFS+$vtFS+"<declarations>\r"
$vtext1:=$vtext1+$vtLine+"\r"
$vtext1:=$vtext1+$vtFS+$vtFS+"  Type variables \r"
$vtext1:=$vtext1+$vtLine+"\r\r"

If (Size of array:C274($atUnknown)>0)
	$vtext2:=""
	$vtext1:=$vtext1+$vtFS+$vtFS+" "
	For ($vi1; 1; Size of array:C274($atUnknown))
		$vtext2:=$vtext2+$atUnknown{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+"\r"
			$vtext1:=$vtext1+$vtFS+$vtFS+" "
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atUnknown{$vi1}+";"
	End for 
	$vtext1:=$vtext1+"\r"
End if 

If (Size of array:C274($atUnknownReal)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+$vtFS+$vtFS+" "+"C_REAL("
	For ($vi1; 1; Size of array:C274($atUnknownReal))
		$vtext2:=$vtext2+$atUnknownReal{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+$vtFS+$vtFS+" "+"C_REAL("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atUnknownReal{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atUnknownText)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+$vtFS+$vtFS+" "+"C_TEXT("
	For ($vi1; 1; Size of array:C274($atUnknownText))
		$vtext2:=$vtext2+$atUnknownText{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+$vtFS+$vtFS+" "+"C_TEXT("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atUnknownText{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atBoolean)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+"C_BOOLEAN("
	For ($vi1; 1; Size of array:C274($atBoolean))
		$vtext2:=$vtext2+$atBoolean{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+"C_BOOLEAN("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atBoolean{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atBlob)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+"C_BLOB("
	For ($vi1; 1; Size of array:C274($atBlob))
		$vtext2:=$vtext2+$atBlob{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+"C_BLOB("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atBlob{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atDate)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+"C_DATE("
	For ($vi1; 1; Size of array:C274($atDate))
		$vtext2:=$vtext2+$atDate{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+"C_DATE("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atDate{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atLongInt)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+"C_LONGINT("
	For ($vi1; 1; Size of array:C274($atLongInt))
		$vtext2:=$vtext2+$atLongInt{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+"C_LONGINT("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atLongInt{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atReal)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+"C_REAL("
	For ($vi1; 1; Size of array:C274($atReal))
		$vtext2:=$vtext2+$atReal{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+"C_REAL("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atReal{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atText)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext2:=""
	$vtext1:=$vtext1+"C_TEXT("
	For ($vi1; 1; Size of array:C274($atText))
		$vtext2:=$vtext2+$atText{$vi1}+";"
		If (Length:C16($vtext2)>80)
			$vtext1:=$vtext1+")\r"
			$vtext1:=$vtext1+"C_TEXT("
			$vtext2:=""
		End if 
		$vtext1:=$vtext1+$atText{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atTime)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext1:=$vtext1+"C_TIME("
	For ($vi1; 1; Size of array:C274($atTime))
		$vtext1:=$vtext1+$atTime{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

If (Size of array:C274($atPointer)>0)
	If (Caps lock down:C547)
		$vtext1:=$vtext1+"FR Text\t"
	End if 
	$vtext1:=$vtext1+"C_POINTER("
	For ($vi1; 1; Size of array:C274($atPointer))
		$vtext1:=$vtext1+$atPointer{$vi1}+";"
	End for 
	$vtext1:=$vtext1+")\r"
End if 

$vtext1:=Replace string:C233($vtext1; ";)"; ")")
$vtext1:=Replace string:C233($vtext1; ";\r"; "\r")

//==================================
// Initialize variables
//==================================

$vtext1:=$vtext1+"\r"+$vtLine+"\r"
$vtext1:=$vtext1+$vtFS+$vtFS+"  Initialize variables \r"
$vtext1:=$vtext1+$vtLine+"\r\r"

If (Size of array:C274($atBoolean)>0)
	For ($vi1; 1; Size of array:C274($atBoolean))
		If ($atBoolean{$vi1}="booAccept")
			$vtext1:=$vtext1+$atBoolean{$vi1}+":=True\r"
		Else 
			$vtext1:=$vtext1+$atBoolean{$vi1}+":=False\r"
		End if 
	End for 
End if 

If (Size of array:C274($atDate)>0)
	For ($vi1; 1; Size of array:C274($atDate))
		$vtext1:=$vtext1+$atDate{$vi1}+":=!00/00/00!\r"
	End for 
End if 

If (Size of array:C274($atBlob)>0)
	For ($vi1; 1; Size of array:C274($atBlob))
		$vtext1:=$vtext1+$atBlob{$vi1}+":=0\r"
	End for 
End if 

If (Size of array:C274($atLongInt)>0)
	For ($vi1; 1; Size of array:C274($atLongInt))
		$vtext1:=$vtext1+$atLongInt{$vi1}+":=0\r"
	End for 
End if 

If (Size of array:C274($atReal)>0)
	For ($vi1; 1; Size of array:C274($atReal))
		$vtext1:=$vtext1+$atReal{$vi1}+":=0\r"
	End for 
End if 

If (Size of array:C274($atText)>0)
	For ($vi1; 1; Size of array:C274($atText))
		$vtext1:=$vtext1+$atText{$vi1}+":=\"\"\r"
	End for 
End if 

If (Size of array:C274($atTime)>0)
	For ($vi1; 1; Size of array:C274($atTime))
		$vtext1:=$vtext1+$atTime{$vi1}+":=0\r"
	End for 
End if 


$vtext1:=$vtext1+$vtFS+$vtFS+"</declarations>\r\r"
//$vtext1:=$vtext1+$vtClipboard
//SET TEXT TO PASTEBOARD($vtext1)

//ALERT("Variable Declarations copied to Clipboard")


// Replace old declarations
$vtDeclarations:="(?s)\n.."+$vtFS+$vtFS+"<declarations>.*?</declarations>\n"

$viMatch:=Preg Match($vtDeclarations; $vtClipboard)
If ($viMatch=1)
	$vtext:=Preg Replace($vtDeclarations; $vtext1; $vtClipboard)
Else 
	$vtext:=$vtext1+$vtClipboard
End if 

// Script Indent Text From Clip 20161129
// ### jwm ### 20161117_1619

ARRAY TEXT:C222($atText1; 0)
C_LONGINT:C283($viIndent)
$viIndent:=0

//$vtext:=Get text from pasteboard
$vtext:=Replace string:C233($vtext; Storage:C1525.char.crlf; "\r")
$vtext:=Replace string:C233($vtext; "\n"; "\r")
TextToArray($vtext; ->$atText1; "\r"; True:C214)

ARRAY LONGINT:C221(aiIndent; Size of array:C274($atText1))

//script Basic Subrecord Loop
//Shift & Caps Lock Key to Exit

Open window:C153(100; 200; 500; 300; 8; "Progress")
ERASE WINDOW:C160
GOTO XY:C161(6; 3)

MESSAGE:C88("Starting Script Basic Loop")

$vi2:=Size of array:C274($atText1)

For ($vi1; 1; $vi2)
	If (Shift down:C543 & Caps lock down:C547)
		$vi1:=$vi2
	End if 
	
	$vrPercent:=Round:C94(($vi1/$vi2*100); 0)
	
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88(" Record "+String:C10($vi1)+" of "+String:C10($vi2)+"  "+String:C10($vrPercent)+" %")
	
	$atText1{$vi1}:=Preg Replace("(?im)^\\s*"; ""; $atText1{$vi1})
	$atText1{$vi1}:=Preg Replace("\\s*"+(Char:C90(47)*2); "  "+(Char:C90(47)*2); $atText1{$vi1})
	
	aiIndent{$vi1}:=$viIndent
	Case of 
		: (Preg Match("(?im)^\\s*"+(Char:C90(47)*2)+".*"; $atText1{$vi1})=1)
			
		: (Preg Match(": \\(.*\\)"; $atText1{$vi1})=1)
			
		: (Preg Match("(?im)^\\s*End If\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent-1
			aiIndent{$vi1}:=aiIndent{$vi1}-1
			
		: (Preg Match("(?im)^\\s*End For\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent-1
			aiIndent{$vi1}:=aiIndent{$vi1}-1
			
		: (Preg Match("(?im)^\\s*End Case\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent-1
			aiIndent{$vi1}:=aiIndent{$vi1}-1
			
		: (Preg Match("(?im)^\\s*End While\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent-1
			aiIndent{$vi1}:=aiIndent{$vi1}-1
			
		: (Preg Match("(?im)^\\s*If\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent+1
			
		: (Preg Match("(?im)^\\s*For\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent+1
			
		: (Preg Match("(?im)^\\s*Case of\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent+1
			
		: (Preg Match("(?im)^\\s*While\\b"; $atText1{$vi1})=1)
			$viIndent:=$viIndent+1
			
		: (Preg Match("(?im)^\\s*Else\\b"; $atText1{$vi1})=1)
			aiIndent{$vi1}:=aiIndent{$vi1}-1
			
	End case 
End for 

$vi2:=Size of array:C274($atText1)

$vtext1:=""
For ($vi1; 1; $vi2)
	If (Shift down:C543 & Caps lock down:C547)
		$vi1:=$vi2
	End if 
	
	$vrPercent:=Round:C94(($vi1/$vi2*100); 0)
	
	ERASE WINDOW:C160
	GOTO XY:C161(6; 3)
	MESSAGE:C88(" Record "+String:C10($vi1)+" of "+String:C10($vi2)+"  "+String:C10($vrPercent)+" %")
	
	$vtext1:=$vtext1+("\t"*aiIndent{$vi1})+$atText1{$vi1}+"\r"
	
End for 

// Clean End of Script 20170118

$vtext1:=Replace string:C233($vtext1; Storage:C1525.char.crlf; "\r")
$vtext1:=Replace string:C233($vtext1; "\n"; "\r")
$viLength:=Length:C16($vtext1)
If ($viLength>0)
	$viContinue:=1
	While ($viContinue=1)
		Case of 
			: ($viLength=1)
				If ($vtext1[[$viLength]]="\r")
					$vtext1:=""
				End if 
				$viContinue:=0
				
			: ($viLength>1)
				If ($vtext1[[$viLength]]="\r")
					$vtext1:=Substring:C12($vtext1; 1; $viLength-1)
				Else 
					$vicontinue:=0
				End if 
		End case 
		$viLength:=Length:C16($vtext1)
		
	End while 
	If ($viLength>0)
		$vtext1:=$vtext1+"\r"
		
	End if 
	
End if 

// reduce 3 or more carriage returns to 2
$vtext1:=Preg Replace("\r{3,}"; "\r\r"; $vtext1)

//SET TEXT TO PASTEBOARD($vtext1)

$Txt_method:=$vtext1

ERASE WINDOW:C160
GOTO XY:C161(6; 3)
MESSAGE:C88("Ending Script Basic Loop")
CLOSE WINDOW:C154

//ALERT("Updated Script on Clipboard")


SET MACRO PARAMETER:C998(Full method text:K5:17; $Txt_method)