//%attributes = {"publishedWeb":true}
//Procedure: CC_ZonParseText
//break the text file down based on keyword
//Zon's differ in their output, this allows reading any we know of
C_BOOLEAN:C305($0)  //successfully parsed string
C_POINTER:C301($1; $2; $3; $4; $5; $6)  //pointer to Text from Zon Jr
C_LONGINT:C283($lenTx; $index; $rowCount; $ElemsFound; $TtlElems)
C_BOOLEAN:C305($ParseErr)
$lenTx:=Length:C16($1->)
If ($lenTx>0)
	For ($index; 1; 5)
		If (<>yZonRow{$index}>0)
			$TtlElems:=$TtlElems+1
		End if 
	End for 
	$ParseErr:=False:C215
	$index:=Position:C15(<>vsZonStStr; $1->)
	If ($index>0)  // Modified by: williamjames (111216 checked for <= length protection)
		$rowCount:=0
		$ElemsFound:=0
		Repeat 
			$index:=$index+1
			If (Character code:C91($1->[[$index]])=10)
				$rowCount:=$rowCount+1
				If ($rowCount=<>yZonRow{1})  //Total Sale
					$2->:=Num:C11(ParseNumStr($1; $index+<>yZonColMdl{1}))  //Total Sale
					$ElemsFound:=$ElemsFound+1
				End if 
				If ($rowCount=<>yZonRow{2})  //Card Number
					$3->:=ParseNumStr($1; $index+<>yZonColMdl{2})  //CC Number
					$ElemsFound:=$ElemsFound+1
				End if 
				If ($rowCount=<>yZonRow{3})  //Expir Date
					$4->:=CC_ApproveDate(ParseNumStr($1; $index+<>yZonColMdl{3}))  //Expire Date
					$ElemsFound:=$ElemsFound+1
				End if 
				If ($rowCount=<>yZonRow{4})  //Authorization Num
					$5->:=ParseNumStr($1; $index+<>yZonColMdl{4})  //Authorization Num
					$ElemsFound:=$ElemsFound+1
				End if 
				If ($rowCount=<>yZonRow{5})  //Reference Num
					$6->:=ParseNumStr($1; $index+<>yZonColMdl{5})
					$ElemsFound:=$ElemsFound+1
				End if 
			End if 
		Until (($index>$lenTx) | ($ElemsFound=$TtlElems))
		If ($ElemsFound<$TtlElems)
			$ParseErr:=True:C214
		End if 
	Else 
		$ParseErr:=True:C214
	End if 
	If (($ParseErr) & ($lenTx>500))  //write out the file so it can be read and reparsed
		$0:=False:C215
	Else 
		$0:=True:C214  // ended OK
	End if 
Else 
	$0:=False:C215
End if 