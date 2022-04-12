//%attributes = {"publishedWeb":true}


If (False:C215)
	//Method: emailParseReturns
	TCJIT_prf_v201
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
TRACE:C157
myDoc:=Open document:C264("")
vi8:=OK
ARRAY TEXT:C222(aText9; 0)
ARRAY TEXT:C222(aText8; 0)
C_LONGINT:C283(vi1; vi2)
If (vi8=1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; vText1; 15000)
		If (OK=1)
			vi9:=Size of array:C274(aText9)+1
			INSERT IN ARRAY:C227(aText9; vi9; 1)
			aText9{vi9}:=vText1
			vText1:=""
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
	//
	If (Size of array:C274(aText9)>0)
		vText1:=vText1+aText9{1}
		DELETE FROM ARRAY:C228(aText9; 1; 1)
	End if 
	$errorBeginAOL:="[<01>]"
	$errorBeginFollowing:="The following addresses had permanent fatal errors"
	
	While (Size of array:C274(aText9)>0)
		Repeat 
			$foundReplyRcptTo:=Position:C15("Rcpt To:"; vText1)+8
			If ($foundReplyRcptTo>8)
				vText1:=Substring:C12(vText1; $foundReplyRcptTo)
				$foundCR:=Position:C15("\r"; vText1)
				If ($foundCR>0)
					$addressStr:=Substring:C12(vText1; 1; $foundCR)
				Else 
					$addressStr:=Substring:C12(vText1; 1; 120)
				End if 
				$addressStr:=Tx_ClipBetween($addressStr; "<"; ">")
				$w:=Find in array:C230(aText8; $addressStr)
				If ($w<1)
					INSERT IN ARRAY:C227(aText8; 1; 1)
					aText8{1}:=$addressStr
				End if 
				//keep working area topped off
				If ((Length:C16(vText1)<15000) & (Size of array:C274(aText9)>0))
					vText1:=vText1+aText9{1}
					DELETE FROM ARRAY:C228(aText9; 1; 1)
				End if 
				KeyModifierCurrent
				If (CapKey=1)
					TRACE:C157
				End if 
			End if 
		Until ($foundReplyRcptTo<9)
		If ((Length:C16(vText1)>15000) & (Size of array:C274(aText9)>0))
			vText1:=Substring:C12(vText1; 1000)
		End if 
	End while 
	vText3:="As sent"+"\t"+"email"+"\t"+"Profile5"+"\t"+"OptOut"+"\r"
	vi2:=Size of array:C274(aText8)
	TRACE:C157
	$badEmailMessage:="BadEmail "+Date_strYyyymmdd(Current date:C33)+"\t"+"1"
	For (vi1; 1; vi2)
		$wcEmail:=aText8{vi1}
		vText3:=vText3+aText8{vi1}+"\t"+$wcEmail+"\t"+$badEmailMessage+"\r"
		
		QUERY:C277([Customer:2]; [Customer:2]email:81=vText5)
		vi4:=Records in selection:C76([Customer:2])
		If (vi4>0)
			FIRST RECORD:C50([Customer:2])
			For (vi3; 1; vi4)
				[Customer:2]profile5:30:="bad email"
				SAVE RECORD:C53([Customer:2])
				NEXT RECORD:C51([Customer:2])
			End for 
		End if 
		
		
	End for 
	SET TEXT TO PASTEBOARD:C523(vText3)
	myDoc:=Create document:C266("")
	If (OK=1)
		SEND PACKET:C103(myDoc; vText3)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 



If (False:C215)
	TRACE:C157
	myDoc:=Open document:C264("")
	vi8:=OK
	ARRAY TEXT:C222(aText9; 0)
	ARRAY TEXT:C222(aText8; 0)
	C_LONGINT:C283(vi1; vi2)
	If (vi8=1)
		Repeat 
			RECEIVE PACKET:C104(myDoc; vText1; 15000)
			If (OK=1)
				vi9:=Size of array:C274(aText9)+1
				INSERT IN ARRAY:C227(aText9; vi9; 1)
				aText9{vi9}:=vText1
				vText1:=""
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267(myDoc)
		//
		If (Size of array:C274(aText9)>0)
			vText1:=vText1+aText9{1}
			DELETE FROM ARRAY:C228(aText9; 1; 1)
		End if 
		$errorBeginAOL:="[<01>]"
		$errorBeginFollowing:="The following addresses had permanent fatal errors"
		
		While (Size of array:C274(aText9)>0)
			Repeat 
				
				
				
				
				
				$foundReplyTo:=Position:C15("Reply-To:"; vText1)+9
				If ($foundReplyTo>9)
					vText1:=Substring:C12(vText1; $foundReplyTo)
				End if 
				$foundTo:=Position:C15("To:"; vText1)
				If ($foundTo>0)
					$addressStr:=Substring:C12(vText1; $foundTo; $foundTo+120)
					$addressStr:=Tx_ClipBetween($addressStr; "<"; ">")
					INSERT IN ARRAY:C227(aText8; 1; 1)
					aText8{1}:=$addressStr
					vText1:=Substring:C12(vText1; $foundTo+3)
				End if 
				//keep working area topped off
				If ((Length:C16(vText1)<15000) & (Size of array:C274(aText9)>0))
					vText1:=vText1+aText9{1}
					DELETE FROM ARRAY:C228(aText9; 1; 1)
				End if 
				KeyModifierCurrent
				If (CapKey=1)
					TRACE:C157
				End if 
			Until (($foundReplyTo<10) & ($foundTo<1))
			If ((Length:C16(vText1)>15000) & (Size of array:C274(aText9)>0))
				vText1:=Substring:C12(vText1; 1000)
			End if 
			If ((Length:C16(vText1)<15000) & (Size of array:C274(aText9)>0))
				vText1:=vText1+aText9{1}
				DELETE FROM ARRAY:C228(aText9; 1; 1)
			End if 
		End while 
		vText3:=""
		vi2:=Size of array:C274(aText8)
		TRACE:C157
		For (vi1; 1; vi2)
			vText5:=vText4
			vText3:=vText3+aText8{vi1}+"\t"+vText4+"\r"
			
			QUERY:C277([Customer:2]; [Customer:2]email:81=vText5)
			vi4:=Records in selection:C76([Customer:2])
			If (vi4>0)
				FIRST RECORD:C50([Customer:2])
				For (vi3; 1; vi4)
					[Customer:2]profile5:30:="bad email"
					SAVE RECORD:C53([Customer:2])
					NEXT RECORD:C51([Customer:2])
				End for 
			End if 
			
			
		End for 
		SET TEXT TO PASTEBOARD:C523(vText3)
		myDoc:=Create document:C266("")
		If (OK=1)
			SEND PACKET:C103(myDoc; vText3)
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
End if 