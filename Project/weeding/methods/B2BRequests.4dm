//%attributes = {"publishedWeb":true}
//If (False)
//	TCMod_606_67_03_04_Trans 
//	//Method: B2BRequests
//End if 
////
//C_TEXT($password;$userName;$1;$2;$3;$4;$5;$vRequest)
//C_TEXT($doc;$machine;$m;$theText;$temp;$theText)
//C_TEXT(WC_SiteInsert)
//C_BOOLEAN($doParameters)
//C_LONGINT($stream;$s;$err;$thePort;$6;$offSet)
////ON ERR CALL("jOECNoAction")
//$doParameters:=(Count parameters=2)
//vText1:=""
//vResponse:="Action not completed"
//$theURL:=$1
//$command:=$2
//$userName:=$3
//$passWord:=$4
//tcDomain:=$5
//$thePort:=$6
//$stream:=0
//$doc:=Substring($theURL;Position("//";$theURL)+2)
//If (Position("/";$doc)=0)
//	$doc:=$doc+"/"
//End if 
//$machine:=Substring($doc;1;Position("/";$doc)-1)
//$m:=$machine
//$doc:=Substring($doc;Position("/";$doc))
//ARRAY TEXT(aText1;0)
//
//$vRequest:=$vRequest+"GET "+$doc+" HTTP/1.1"+Storage.char.crlf
//$vRequest:=$vRequest+"Host: "+$machine+Storage.char.crlf
//$vRequest:=$vRequest+"Accept: */*"+Storage.char.crlf
//$vRequest:=$vRequest+"Connection: Keep-Alive"+Storage.char.crlf
//$vRequest:=$vRequest+"ACCEPT-Language: en-us"+Storage.char.crlf
//$vRequest:=$vRequest+"User-Agent: WebClerk"+Storage.char.crlf//Mozilla/4(compatible;MSIE 5.5;Windows 98)
//$vRequest:=$vRequest+Storage.char.crlf//second CRLF
//// open stream with the HTTP server
//TRACE
//C_BLOB($incomingBlob)
//$incomingBlob:=B2B_Exchange ($machine;$thePort;$vRequest)
//$testText:=BLOB to text($incomingBlob;Text without length ;$offSet;400)
//If ($testText="Error@")
//	ALERT($testText)
//Else 
//	C_LONGINT($vOffSet)
//	ARRAY TEXT($arrayText;0)
//	$vOffSet:=0
//	If (BLOB size($incomingBlob)>0)
//		Repeat 
//			$clipText:=BLOB to text($incomingBlob;$vOffSet;32000)//$vOffSet automatically increments
//			APPEND TO ARRAY($arrayText;$clipText)
//		Until ($vOffSet>=$bytesReceived)
//	End if 
//	
//	//
//	C_LONGINT($cntEffort;$cntUpdate)
//	If (Size of array($arrayText)>0)
//		CREATE EMPTY SET([Item];"Current")
//		myDoc:=create document(Storage.folder.jitF+"B2BSync"+String(DateTime_DTTo)+".txt")
//		SEND PACKET(myDoc;$vRequest+"\r"+"\r")
//		$endLoop:=False
//		$endLoop:=True
//		$theText:=$arrayText{1}
//		$theText:=Replace string($theText;"jjjjj";"\t")
//		$theText:=Replace string($theText;"zzzzz";"\r")
//		DELETE ELEMENT($arrayText;1;1)
//		$lenText:=Length($theText)
//		While ($lenText>0)
//			If (($lenText<10000)&(Size of array($arrayText)>0))
//				$theText:=$theText+$arrayText{1}
//				DELETE ELEMENT($arrayText;1;1)
//				//
//				$theText:=Replace string($theText;"jjjjj";"\t")
//				$theText:=Replace string($theText;"zzzzz";"\r")
//				//SET TEXT TO CLIPBOARD($theText)
//			End if 
//			$p:=Position("\r";$theText)
//			If ($p<1)
//				$lineText:=$theText
//				$theText:=""
//			Else 
//				$lineText:=Substring($theText;1;$p-1)
//				$theText:=Substring($theText;$p+1)
//			End if 
//			TextToArray ($lineText;->aText8;"\t")
//			If (Size of array(aText8)=3)
//				SEND PACKET(myDoc;$lineText+"\t")
//				$cntEffort:=$cntEffort+1
//				QUERY([Item];[Item]ItemNum=aText8{1})
//				If (Records in selection([Item])=1)
//					ADD TO SET([Item];"Current")
//					[Item]PriceA:=Num(aText8{2})
//					[Item]CostAverage:=Num(aText8{3})
//					SAVE RECORD([Item])
//					QUERY([ItemXRef];[ItemXRef]ItemNumMaster=[Item]ItemNum)
//					C_LONGINT($incXRef;$cntXRef)
//					$cntXRef:=Records in selection([ItemXRef])
//					FIRST RECORD([ItemXRef])
//					For ($incXRef;1;$cntXRef)
//						[ItemXRef]PriceA:=[Item]PriceA
//						[ItemXRef]Cost:=[Item]CostAverage
//						SAVE RECORD([ItemXRef])
//						NEXT RECORD([ItemXRef])
//					End for 
//					
//					$cntUpdate:=$cntUpdate+1
//					SEND PACKET(myDoc;"updated"+"\r")
//				Else 
//					SEND PACKET(myDoc;"No match"+"\r")
//				End if 
//			End if 
//			$lenText:=Length($theText)
//		End while 
//		vResponse:="Items updated:  "+String($cntUpdate)+"; Items from Server: "+String($cntEffort)
//		SEND PACKET(myDoc;"\r"+"\r"+vResponse)
//		CLOSE DOCUMENT(myDoc)
//		TRACE
//		If (Records in set("Current")>0)
//			COPY SET("Current";"<>curSelSet")
//			<>ptCurTable:=(->[Item])
//			<>prcControl:=1
//			$theName:="Named Item Numbers"  End if 
//		CLEAR SET("Current")
//	End if 
//	UNLOAD RECORD([Item])
//	UNLOAD RECORD([ItemXRef])
//	
//End if 
//