//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/02/09, 15:04:07
// ----------------------------------------------------
// Method: Wiki_TxtList
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k; $addLink; $startAt)
C_TEXT:C284($textAdd)
$addLink:=0
$k:=Size of array:C274(aFieldLns)
$fileID:=String:C10(curTableNum)
$textAdd:="(:table border=1 cellpadding=2 cellspacing=0:)"
If ($k>0)
	If ($addLink=1)
		$textAdd:=$textAdd+"\r"+"(:cell:) GoTo"
	End if 
	C_TEXT:C284($theAlignment)
	For ($i; 1; $k)
		$theType:=Type:C295(Field:C253(curTableNum; theFldNum{aFieldLns{$i}})->)
		Case of 
			: (($theType=0) | ($theType=2) | ($theType=24))  //string or text
				$theAlignment:="(:cell align=left:) "
			: ($theType=4)  //date
				$theAlignment:="(:cell align=center:) "
			: (($theType=1) | ($theType=8))  //integer or real
				$theAlignment:="(:cell align=right:) "
			: ($theType=9)  //long int
				If (Field name:C257(Field:C253(curTableNum; theFldNum{aFieldLns{$i}}))="DT@")
					$theAlignment:="(:cell align=right:) "
				Else 
					$theAlignment:="(:cell align=right:) "
				End if 
			: ($theType=6)  //boolean
				$theAlignment:="(:cell align=left:) "
			: ($theType=11)  //time
				$theAlignment:="(:cell align=center:) "
			Else 
				$theAlignment:="(:cell align=left:) "
		End case 
		$textAdd:=$textAdd+"\r"+$theAlignment+theFields{aFieldLns{$i}}
	End for 
	$textAdd:=$textAdd+"\r"+"<!-- _jit_begin_"+String:C10(curTableNum)+"_1"+<>endTag+" -->"+"\r"
	If ($addLink=1)
		$textAdd:=$textAdd+"(:cellnr:) Insert link"
		$startAt:=1
	Else 
		$textAdd:=$textAdd+"(:cellnr:) "+HTML_jitTagMake(1; $fileID; String:C10(theFldNum{aFieldLns{1}}); theFields{aFieldLns{1}})
		$startAt:=2
	End if 
	For ($i; $startAt; $k)
		$textAdd:=$textAdd+"\r"+"(:cell:) "+HTML_jitTagMake(1; $fileID; String:C10(theFldNum{aFieldLns{$i}}); theFields{aFieldLns{$i}})
	End for 
	$textAdd:=$textAdd+"\r"+"<!- "+<>jitTag+"end"+<>midTag+<>endTag+"->"+"\r"+"(:tableend:)"
	
	Case of 
		: ((is4DWriteUser=3) & (eLetterArea>0))
			//**WR INSERT TEXT (eLetterArea;$textAdd)
		Else 
			vTextSummary:=$textAdd+"\r"+"\r"+vTextSummary
	End case 
	
End if 