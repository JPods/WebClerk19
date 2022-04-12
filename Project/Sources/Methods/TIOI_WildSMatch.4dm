//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0)  //does $1 match the Buffer
C_POINTER:C301($1)  //pointer to text: the string to try and macth to the buffer, tTIOIBuffer
//
If ($1->[[1]]=Char:C90(<>ciTIOMarker))
	C_LONGINT:C283($pos)
	$pos:=Position:C15(Char:C90(<>ciTIOAnyChr); $1->)
	If ($pos>0)
		C_BOOLEAN:C305($match)
		If ($pos>2)  //Match 1st Segment, unless "*ABC..." then always match
			$match:=TIOI_WildSSegmt($1; 2; $pos-1; 1)
		Else 
			$match:=True:C214
		End if 
		If ($match)
			C_LONGINT:C283($index)
			$index:=$pos+1
			$TestLen:=Length:C16($1->)
			C_LONGINT:C283($BuffIndex)
			$BuffIndex:=$pos-1  //position of 1st non-match char
			C_LONGINT:C283($BuffLen)
			$BuffLen:=Length:C16(tTIOIBuffer)
			While (($match) & ($index<=$TestLen))
				If ($1->[[$index]]=Char:C90(<>ciTIOAnyChr))
					If ($pos<($index-1))  //Don't process "...**..."
						C_LONGINT:C283($TestSegLen)
						$TestSegLen:=($index-$pos)-1
						Repeat 
							$match:=TIOI_WildSSegmt($1; $pos+1; $index-1; $BuffIndex)  //Match 1st Segment
							If ($match)
								$BuffIndex:=$BuffIndex+$TestSegLen
							Else 
								$BuffIndex:=$BuffIndex+1
							End if 
						Until (($match) | ((($BuffIndex+$TestSegLen)-1)>$BuffLen))
					End if 
					$pos:=$index
				End if 
				$index:=$index+1
			End while 
			If ($match)
				If ($pos<$TestLen)  //Match Last Segment, unless "...ABC*" then always match
					$match:=TIOI_WildSSegmt($1; $pos+1; $TestLen; $BuffLen-($TestLen-($pos+1)))
				End if 
			End if 
		End if 
	Else 
		$match:=TIOI_WildSSegmt($1; 2; Length:C16($1->); 1)  //match whole string
	End if 
	$0:=$match
Else 
	$0:=($1->=tTIOIBuffer)
End if 