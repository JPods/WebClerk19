//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/11/08, 13:40:17
// ----------------------------------------------------
// Method: CC_EncodeDecode
// Description
// 
//
// Parameters
C_LONGINT:C283($1; $setDirection; $theCharNum; $theOffSet)
C_TEXT:C284($0; $2; $theCardNumber; $theMix)
C_POINTER:C301($3)
// ----------------------------------------------------
$theCardNumber:=$2
$setDirection:=$1
$myText:=""
If (False:C215)  //zzztesting
	ALL RECORDS:C47([Customer:2])
	FIRST RECORD:C50([Customer:2])
End if 

If (Record number:C243([Customer:2])>-1)
	Case of 
		: ($setDirection=1)  //encrypt
			If (Position:C15("x"; $theCardNumber)>0)  // return the x'd out card number, never encrypt an x'd
				$0:=$theCardNumber
			Else 
				C_BLOB:C604($privKeyCC; $pubKeyCC; $testBlob)
				C_TEXT:C284($myText)
				C_LONGINT:C283($offset)
				If ($2#"")
					If ((Table:C252($3)=Table:C252(->[Payment:28])) & (Record number:C243([Payment:28])>-1))
						If ([Payment:28]customerid:4#[Customer:2]customerID:1)
							QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerid:4)
						End if 
					End if 
					If (Record number:C243([Customer:2])>-1)
						If (BLOB size:C605([Customer:2]sslPublicKey:115)=0)
							GENERATE ENCRYPTION KEYPAIR:C688([Customer:2]sslPrivateKey:116; [Customer:2]sslPublicKey:115)
							SAVE RECORD:C53([Customer:2])
						End if 
						TEXT TO BLOB:C554($2; $3->; UTF8 text without length:K22:17)
						ENCRYPT BLOB:C689($3->; [Customer:2]sslPrivateKey:116)
						$0:="encrypted"
						
						If (False:C215)  //for testing
							$encryptResult:=CC_EncodeDecode(0; ""; ->[Payment:28]creditCardBlob:53)  //save card encrypted
						End if 
					End if 
				End if 
			End if 
		: ($setDirection=0)  //de-encrypt
			$offset:=0
			C_BLOB:C604($testBlob)
			
			// $testBlob:=$3->
			If ((BLOB size:C605($3->)>0) & (Record number:C243([Customer:2])>-1))
				COPY BLOB:C558($3->; $testBlob; 0; 0; BLOB size:C605($3->))
				DECRYPT BLOB:C690($testBlob; [Customer:2]sslPublicKey:115)
				$offset:=0
				$myText:=BLOB to text:C555($testBlob; UTF8 text without length:K22:17)
				
				
				If (False:C215)
					COPY BLOB:C558([Payment:28]creditCardBlob:53; ILOBLOB1; 0; 0; BLOB size:C605([Payment:28]creditCardBlob:53))
					DECRYPT BLOB:C690([Payment:28]creditCardBlob:53; [Customer:2]sslPublicKey:115)
					ILOTEXT1:=BLOB to text:C555(ILOBLOB1; UTF8 text without length:K22:17)
					ALERT:C41(iLoText1)
				End if 
				$0:=$myText
			Else 
				$0:=pCreditCardLast4  // so it does not empty if there is no blob
			End if 
			
	End case 
End if 

If (False:C215)
	$testThis:=False:C215
	//If ($testThis)
	
	$0:=$2
	C_BOOLEAN:C305($testThis)
	$testThis:=False:C215
	If ($testThis)
		//This is what should be done.
		C_BOOLEAN:C305($skip)
		$skip:=False:C215
		If ($skip)
			C_BLOB:C604(<>privKeyCC; <>pubKeyCC; $testBlob)
			C_TEXT:C284($myText)
			C_LONGINT:C283($offset)
			GENERATE ENCRYPTION KEYPAIR:C688($privKeyCC; $pubKeyCC)
			
			TEXT TO BLOB:C554("This is a test"; $testBlob; 3)
			ENCRYPT BLOB:C689($testBlob; <>privKeyCC)
			$myText:=BLOB to text:C555($testBlob; 3; $offset; 25000)
			DECRYPT BLOB:C690($testBlob; <>pubKeyCC)
			$offset:=0
			$myText:=BLOB to text:C555($testBlob; 3; $offset; 25000)
		End if 
	End if 
	
	//If (False)
	//$theCardNumber:=$2
	$theCardNumber:="4321543265437654"
	$setDirection:=1
	$theMix:=""
	$k:=Length:C16($theCardNumber)
	If ($setDirection=1)
		If (($k<14) | ($k>16))
			$0:=$2
		Else 
			ARRAY LONGINT:C221($aSequence; $k)
			If (Character code:C91($theCardNumber[[1]])<58)
				//$theCardNumber:=Substring($theCardNumber;1;Length($theCardNumber)-4)
				$k:=Length:C16($theCardNumber)
				Case of 
					: ($k=14)
						$theLenChar:="d"
					: ($k=15)
						$theLenChar:="m"
					: ($k=16)
						$theLenChar:="g"
				End case 
				$theOffSet:=Num:C11($theCardNumber[[3]])
				$aSequence{4}:=Character code:C91("e")+Num:C11($theCardNumber[[1]])-2
				$aSequence{13}:=Character code:C91("j")+Num:C11($theCardNumber[[2]])-4
				$aSequence{3}:=Character code:C91("b")+Num:C11($theCardNumber[[3]])+0
				$aSequence{12}:=Character code:C91("h")+Num:C11($theCardNumber[[4]])-5+$theOffSet
				$aSequence{10}:=Character code:C91("f")+Num:C11($theCardNumber[[5]])-2+$theOffSet
				$aSequence{2}:=Character code:C91("i")+Num:C11($theCardNumber[[6]])-9+$theOffSet
				$aSequence{9}:=Character code:C91("m")+Num:C11($theCardNumber[[7]])-9+$theOffSet
				$aSequence{11}:=Character code:C91("d")+Num:C11($theCardNumber[[8]])-3+$theOffSet
				$aSequence{6}:=Character code:C91("a")+Num:C11($theCardNumber[[9]])+1+$theOffSet
				$aSequence{7}:=Character code:C91("g")+Num:C11($theCardNumber[[10]])-5+$theOffSet
				$aSequence{5}:=Character code:C91("a")+Num:C11($theCardNumber[[11]])+3+$theOffSet
				$aSequence{1}:=Character code:C91("c")+Num:C11($theCardNumber[[12]])-1+$theOffSet
				$aSequence{8}:=Character code:C91("a")+Num:C11($theCardNumber[[13]])+2+$theOffSet
				If ($k>13)
					$aSequence{14}:=Character code:C91("g")+Num:C11($theCardNumber[[14]])-2+$theOffSet
					If ($k>14)
						$aSequence{15}:=Character code:C91("a")+Num:C11($theCardNumber[[15]])+4+$theOffSet
						If ($k>15)
							$aSequence{16}:=Character code:C91("c")+Num:C11($theCardNumber[[16]])-2+$theOffSet
						End if 
					End if 
				End if 
				$theMix:=$theLenChar
				For ($i; 1; $k)
					$theMix:=$theMix+Char:C90($aSequence{$i})
				End for 
				$0:=$theMix
			End if 
		End if 
	Else 
		If (($k<15) | ($k>17))
			$0:=$theCardNumber
		Else 
			//If (Ascii($theCardNumber1)<58)
			Case of 
				: ($theCardNumber[[1]]="d")
					$k:=14
				: ($theCardNumber[[1]]="m")
					$k:=15
				: ($theCardNumber[[1]]="g")
					$k:=16
			End case 
			$theCardNumber:=Substring:C12($theCardNumber; 2)
			$k:=Length:C16($theCardNumber)
			ARRAY LONGINT:C221($aSequence; $k)
			$theOffSet:=-Character code:C91("b")+Character code:C91($theCardNumber[[3]])+0
			
			$aSequence{1}:=-Character code:C91("e")+Character code:C91($theCardNumber[[4]])+2
			$aSequence{2}:=-Character code:C91("j")+Character code:C91($theCardNumber[[13]])+4
			$aSequence{3}:=-Character code:C91("b")+Character code:C91($theCardNumber[[3]])+0
			$aSequence{4}:=-Character code:C91("h")+Character code:C91($theCardNumber[[12]])+5-$theOffSet
			$aSequence{5}:=-Character code:C91("f")+Character code:C91($theCardNumber[[10]])+2-$theOffSet
			$aSequence{6}:=-Character code:C91("i")+Character code:C91($theCardNumber[[2]])+9-$theOffSet
			$aSequence{7}:=-Character code:C91("m")+Character code:C91($theCardNumber[[9]])+9-$theOffSet
			$aSequence{8}:=-Character code:C91("d")+Character code:C91($theCardNumber[[11]])+3-$theOffSet
			$aSequence{9}:=-Character code:C91("a")+Character code:C91($theCardNumber[[6]])-1-$theOffSet
			$aSequence{10}:=-Character code:C91("g")+Character code:C91($theCardNumber[[7]])+5-$theOffSet
			$aSequence{11}:=-Character code:C91("a")+Character code:C91($theCardNumber[[5]])-3-$theOffSet
			$aSequence{12}:=-Character code:C91("c")+Character code:C91($theCardNumber[[1]])+1-$theOffSet
			$aSequence{13}:=-Character code:C91("a")+Character code:C91($theCardNumber[[8]])-2-$theOffSet
			If ($k>13)
				$aSequence{14}:=-Character code:C91("g")+Character code:C91($theCardNumber[[14]])+2-$theOffSet
				If ($k>14)
					$aSequence{15}:=-Character code:C91("a")+Character code:C91($theCardNumber[[15]])-4-$theOffSet
					If ($k>15)
						$aSequence{16}:=-Character code:C91("c")+Character code:C91($theCardNumber[[16]])+2-$theOffSet
					End if 
				End if 
			End if 
			$theMix:=""
			For ($i; 1; $k)
				$theMix:=$theMix+String:C10($aSequence{$i})
			End for 
			
			$0:=$theMix
			//End if 
		End if 
	End if 
	vText1:=$theMix
	//End if 
	//End if 
End if 
