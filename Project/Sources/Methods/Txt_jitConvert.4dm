//%attributes = {"publishedWeb":true}
//Procedure: Txt_jitConvert
// QQQQ
C_TEXT:C284($0; $1)
$0:=$1

// Modified by: Bill James (2017-09-10T00:00:00)
// What was this used for in workorders
// no longer a need to work with Quark

If (False:C215)
	//ARRAY TEXT(aDisplay1;0)
	//Repeat //load in the document
	//vi1:=vi1+1
	//INSERT ELEMENT(aDisplay1;vi1;1)
	//RECEIVE PACKET(myDoc;aDisplay1{vi1};5000)
	//Until ((OK=0)|(Length(aDisplay1{vi1})<5000))
	ARRAY TEXT:C222(aDisplay1; 1)
	ARRAY TEXT:C222(aDisplay2; 0)
	aDisplay1{1}:=$1
	////
	////
	////       
	$docText:=""
	While (Size of array:C274(aDisplay1)>0)
		If ((Length:C16($docText)<4000) & (Size of array:C274(aDisplay1)>0))
			$docText:=$docText+aDisplay1{1}
			DELETE FROM ARRAY:C228(aDisplay1; 1; 1)
		End if 
		//
		$p:=Position:C15("_jitSort_"; $docText)
		If ($p>0)
			$myText:=Substring:C12($docText; $p+9; 20)
			$p:=Position:C15(<>midTag; $myText)
			$fileNum:=Num:C11(Substring:C12($myText; 1; $p-1))
			$myText:=Substring:C12($myText; $p+1)
			$p:=Position:C15(<>endTag; $myText)
			$myText:=Substring:C12($myText; 1; $p-1)
			$field1:=0
			$field2:=0
			$field3:=0
			C_LONGINT:C283($field1; $field2; $field3; $i)
			$i:=0
			Repeat 
				$i:=$i+1
				$p:=Position:C15(<>midTag; $myText)
				Case of 
					: ($i=1)
						If ($p=0)
							$p:=3
						End if 
						$field1:=Num:C11(Substring:C12($myText; 1; $p-1))
					: ($i=2)
						If ($p=0)
							$p:=3
						End if 
						$field2:=Num:C11(Substring:C12($myText; 1; $p-1))
					: ($i=3)
						If ($p=0)
							$p:=3
						End if 
						$field3:=Num:C11(Substring:C12($myText; 1; $p-1))
				End case 
				$myText:=Substring:C12($myText; $p+<>lenMidTag)
			Until (($p=0) | ($i=3))
			$i:=Get last field number:C255($fileNum)
			Case of 
				: (($field1>0) & ($field1<=$i) & ($field2>0) & ($field2<=$i) & ($field3>0) & ($field3<=$i))
					ORDER BY:C49(Table:C252($fileNum)->; Field:C253($fileNum; $field1)->; Field:C253($fileNum; $field2)->; Field:C253($fileNum; $field3)->)
				: (($field1>0) & ($field1<=$i) & ($field2>0) & ($field2<=$i))
					ORDER BY:C49(Table:C252($fileNum)->; Field:C253($fileNum; $field1)->; Field:C253($fileNum; $field2)->)
				: (($field1>0) & ($field1<=$i))
					ORDER BY:C49(Table:C252($fileNum)->; Field:C253($fileNum; $field1)->)
			End case 
			$myText:=""
		End if 
		vi1:=0
		
		$p:=Position:C15(<>jitTag; $docText)
		While ($p>0)
			$myText:=$myText+Substring:C12($docText; 1; $p-1)  //put the HTML infor up to the file/fld into $myText
			$docText:=Substring:C12($docText; $p+<>lenjitTag)  //clip off thru the <>jitTag string
			$p:=Position:C15(<>midTag; $docText)  //find the position of the file/field seperator
			$name:=Substring:C12($docText; 1; $p-1)  //read in the file number, does support >1 char nums
			
			If ($name="begin")
				$docText:=Substring:C12($docText; $p+1)
				$p:=Position:C15(<>midTag; $docText)
				$fileName:=Substring:C12($docText; 1; $p-1)
				$fileNum:=Num:C11($fileName)
				$docText:=Substring:C12($docText; $p+1)
				$p:=Position:C15(<>endTag; $docText)
				$field:=Substring:C12($docText; 1; $p-1)
				$docText:=Substring:C12($docText; $p+<>lenEndTag)
				//must send out the formating instructions then clear them, tables
				$sizeRay:=Size of array:C274(aDisplay2)+1
				INSERT IN ARRAY:C227(aDisplay2; $sizeRay; 1)
				aDisplay2{$sizeRay}:=$myText+$convText  //SEND PACKET(myDoc;$myText)
				$myText:=""
				$docText:=TagsToDataBlock($docText)
			Else 
				$fileNum:=Num:C11($name)
				$docText:=Substring:C12($docText; $p+1)  //clip off thru the ";" string
				$p:=Position:C15(<>endTag; $docText)  //find the position of the field end char <>endTag              
				$field:=Substring:C12($docText; 1; $p-1)
				$docText:=Substring:C12($docText; $p+<>lenEndTag)
				//
				C_TEXT:C284($convText)
				$myText:=Replace string:C233($myText; "rjit"; "_jit")  //added to put refs into the output
				$convText:=Tag2Value($fileNum; $field; 0)  //added to accumulate shopping cart
				//
				$sizeRay:=Size of array:C274(aDisplay2)+1
				INSERT IN ARRAY:C227(aDisplay2; $sizeRay; 1)
				aDisplay2{$sizeRay}:=$myText+$convText  //vi1:=vi1+ITK_TCPSend ($1;$myText+$convText;1)    
			End if 
			$myText:=""
			$p:=Position:C15(<>jitTag; $docText)  //find the next file/fld designator
		End while 
		$sizeRay:=Size of array:C274(aDisplay2)+1
		INSERT IN ARRAY:C227(aDisplay2; $sizeRay; 1)  //SEND PACKET(sumDoc;$docText)
		aDisplay2{$sizeRay}:=Replace string:C233($docText; "rjit"; "_jit")  //added to put refs into the output
	End while 
	$k:=Size of array:C274(aDisplay2)
	For ($i; 1; $k)
		$0:=$0+aDisplay2{$i}
	End for 
End if 