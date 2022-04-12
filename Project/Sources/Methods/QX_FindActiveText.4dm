//%attributes = {"publishedWeb":true}
//Method: QX_FindActiveText
C_TEXT:C284($1; $2; $3; $0)
C_TEXT:C284($working; $start; $end)
ARRAY TEXT:C222($aResults; 0)
C_BOOLEAN:C305($endLoop)
C_LONGINT:C283($pBegin; $pEnd; $w; $i; $k)
$working:=$1
$endLoop:=False:C215
//TRACE
Repeat 
	$w:=Size of array:C274($aResults)+1
	INSERT IN ARRAY:C227($aResults; $w)
	$pBegin:=Position:C15($2; $working)
	If ($pBegin=0)
		$aResults{$w}:=$working
		$endLoop:=True:C214
	Else 
		$working:=Substring:C12($working; $pBegin+1)
		$pEnd:=Position:C15($3; $working)
		If ($pEnd=0)
			$aResults{$w}:=$working
			$endLoop:=True:C214
		Else 
			$aResults{$w}:=Substring:C12($working; 1; $pEnd-1)
			$working:=Substring:C12($working; $pEnd+1)
		End if 
	End if 
Until ($endLoop)
$k:=Size of array:C274($aResults)
$working:=""
For ($i; 1; $k)
	If (Length:C16($aResults{$i})>0)
		If (Character code:C91($aResults{$i}[[1]])=64)  //@
			$pEnd:=Position:C15(":"; $aResults{$i})
			If ($pEnd>0)
				$0:=$0+("; "*Num:C11($0#""))+Substring:C12($aResults{$i}; $pEnd+1)
			Else 
				$0:=$0+("; "*Num:C11($0#""))+$aResults{$i}
			End if 
		Else 
			$0:=$0+("; "*Num:C11($0#""))+$aResults{$i}
		End if 
	End if 
End for 