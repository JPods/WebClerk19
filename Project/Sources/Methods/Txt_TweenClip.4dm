//%attributes = {"publishedWeb":true}
//Method: Txt_TweenClip
C_LONGINT:C283($0; $5; $clipBackLen)  //clipBack
C_POINTER:C301($1; $2)  //inbound Text; outbound clipped
C_TEXT:C284($3; $4)  //$3=findWhat; $4=endClipValue
//
C_TEXT:C284($theText)
C_LONGINT:C283($i; $p; $w; $myOK)
C_LONGINT:C283($lenLead; $lenTrail)

If (Count parameters:C259>4)
	$clipBackLen:=$5
Else 
	
End if 

$myOK:=0
$p:=Position:C15($3; $1->)
$2->:=""
$0:=0
//MyTestAlert ($3)
If ($p>0)
	$lenLead:=Length:C16($3)
	If ($4="")
		$2->:=Substring:C12($1->; $p+$lenLead)
		If ($clipBackLen>0)
			$1->:=""
		End if 
		$myOK:=1
	Else 
		$theText:=Substring:C12($1->; $p+$lenLead)
		$p:=Position:C15($4; $theText)
		If ($p>0)
			$lenTrail:=Length:C16($4)
			$2->:=Substring:C12($theText; 1; $p-1)
			If ($clipBackLen>0)  //clip the text extracted
				$1->:=Substring:C12($1->; $p+$lenTrail)
			End if 
			If (Length:C16($2->)>0)
				If ($2->[[1]]="\"")
					$2->:=Substring:C12($2->; 2)
				End if 
				If ($2->[[Length:C16($2->)]]="\"")
					$2->:=Substring:C12($2->; 1; Length:C16($2->)-1)
				End if 
				$myOK:=1
				Txt_TrimSpaces($2->)
			End if 
			$0:=1
		End if 
	End if 
End if 

If (False:C215)
	$myOK:=0
	$p:=Position:C15($3; $1->)
	$2->:=""
	$0:=0
	//MyTestAlert ($3)
	If ($p>0)
		$lenLead:=Length:C16($3)
		If ($4="")
			$2->:=Substring:C12($1->; $p+$lenLead)
			If ($clipBackLen>0)
				$1->:=""
			End if 
			$myOK:=1
		Else 
			$1->:=Substring:C12($1->; $p+$lenLead)
			$p:=Position:C15($4; $1->)
			If ($p>0)
				$lenTrail:=Length:C16($4)
				$2->:=Substring:C12($1->; 1; $p-1)
				If ($clipBackLen>0)
					$1->:=Substring:C12($1->; $p+$lenTrail)
				Else 
					$1->:=$3+$2->+$1->  //track back on the data
				End if 
				If (Length:C16($2->)>0)
					If ($2->[[1]]="\"")
						$2->:=Substring:C12($2->; 2)
					End if 
					If ($2->[[Length:C16($2->)]]="\"")
						$2->:=Substring:C12($2->; 1; Length:C16($2->)-1)
					End if 
					$myOK:=1
					Txt_TrimSpaces($2->)
				End if 
				$0:=1
			End if 
		End if 
	End if 
	
End if 