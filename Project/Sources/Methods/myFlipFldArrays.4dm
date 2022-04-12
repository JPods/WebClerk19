//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/12/18, 21:39:45
// ----------------------------------------------------
// Method: myFlipFldArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
C_TEXT:C284($first; $second)
C_TEXT:C284($tempText)
TRACE:C157
$k:=Length:C16(vText)
$i:=0
$tempText:=""
If ((vText="SELECTION T@") | (vText="Array T@"))
	While (($i<$k) & (vText[[$i]]#"("))
		$i:=$i+1
		$tempText:=$tempText+vText[[$i]]
	End while 
	If ($tempText="Selection to Array(")
		$tempText:="Array to Selection("
	Else 
		$tempText:="Selection to Array("
	End if 
	While ($i<$k)
		$first:=""
		$second:=""
		Repeat   //While (($i<$k)&(vText$i#";"))
			$i:=$i+1
			$first:=$first+vText[[$i]]
		Until (($i=$k) | (vText[[$i]]=";"))  //(End while  
		If ($i<$k)
			Repeat   // While (($i<$k)&(vText$i#";")&(vText$i#")"))
				$i:=$i+1
				$second:=$second+vText[[$i]]
			Until (($i=$k) | (vText[[$i]]=";") | (vText[[$i]]=")"))  // End while     
		End if 
		If (vText[[$i]]=")")  //protect against trailing spaces
			$i:=$k
		End if 
		If ($i=$k)
			$second:=Substring:C12($second; 1; (Length:C16($second)-1))+";"
			$first:=Substring:C12($first; 1; (Length:C16($first)-1))+")"
		End if 
		$tempText:=$tempText+$second+$first
	End while 
Else 
	Repeat 
		$p:=Position:C15("\r"; vText)
		If ($p=0)
			$assign:=Position:C15(":="; vText)
			$flipStr:=vText
			vText:=""
		Else 
			$flipStr:=Substring:C12(vText; 1; $p-1)
			vText:=Substring:C12(vText; $p+1)
			$assign:=Position:C15(":="; $flipStr)
		End if 
		If ($assign>0)
			$revStr:=Substring:C12($flipStr; $assign+2)+":="+Substring:C12($flipStr; 1; $assign-1)
			$tempText:=$tempText+"\r"+$revStr
		Else 
			$tempText:=$tempText+"\r"+$flipStr
			vText:=""
		End if 
	Until (vText="")
	vText:=$tempText
End if 