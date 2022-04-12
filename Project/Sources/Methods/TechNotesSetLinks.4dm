//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/25/08, 01:24:39
// ----------------------------------------------------
// Method: TechNotesSetLinks
// Find text in the middle of other text and operate on it to convert it to links
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($thePage; $theText; $1; $theDocPath)
C_BOOLEAN:C305($cleanFlag)
$document:=""
If (Count parameters:C259=1)
	$theDocPath:=$1
Else 
	$theDocPath:=""
End if 
myDoc:=Open document:C264($theDocPath)
If (OK=1)
	$leadDelimiter:="<font class="+Char:C90(34)+"f3"+Char:C90(34)+">"
	$trailDelimiter:="</font>"
	RECEIVE PACKET:C104(myDoc; vText5; 2000000000)
	If (OK=1)
		CLOSE DOCUMENT:C267(myDoc)
		$document:=document
		C_LONGINT:C283($noStyle)
		$noStyle:=Txt_Chunk(->vText5; ->vText4; ->vText6; $leadDelimiter; $trailDelimiter)
		//SET TEXT TO CLIPBOARD(vText4)//beginning chunk
		//SET TEXT TO CLIPBOARD(vText5)//ending clip
		//SET TEXT TO CLIPBOARD(vText6)    //clipped between
		vText6:=Replace string:C233(vText6; "&nbsp;"; "|")
		$cleanText:=""
		$cntChar:=Length:C16(vText6)
		For ($incChar; 1; $cntChar)
			If (vText6[[$incChar]]#"|")
				$cleanText:=$cleanText+vText6[[$incChar]]
				$cleanFlag:=True:C214
			Else 
				If ($cleanFlag)
					$cleanText:=$cleanText+";"
					$cleanFlag:=False:C215
				End if 
			End if 
		End for 
		TextToArray($cleanText; ->aText8; ";")
		$cntRay:=Size of array:C274(aText8)
		$myText:=""
		For ($incRay; 1; $cntRay)
			$myLink:="/Tech_List?keyword="+aText8{$incRay}
			$myText:=$myText+"<a href="+Txt_Quoted($myLink)+">"+aText8{$incRay}+"</a>  |   "
		End for 
		//SET TEXT TO CLIPBOARD($myText)
		DELETE DOCUMENT:C159($document)
		If (OK=1)
			myDoc:=Create document:C266($document)
			If (OK=1)
				SEND PACKET:C103(myDoc; vText4+"\r"+"\r")
				SEND PACKET:C103(myDoc; $myText+"\r"+"\r")
				SEND PACKET:C103(myDoc; vText5)
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
	End if 
End if 

