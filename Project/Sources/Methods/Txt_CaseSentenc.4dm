//%attributes = {"publishedWeb":true}
//Method: Txt_CaseSentenc
C_POINTER:C301($1)
C_LONGINT:C283($i; $k; $w)
C_TEXT:C284($0)
If (Count parameters:C259=0)
	ALERT:C41("Pass Pointer to Text.")
Else 
	$0:=Lowercase:C14($1->)
	$i:=1
	$k:=Length:C16($1->)
	If ($k>0)
		$0[[$i]]:=Uppercase:C13($0[[$i]])
		While ($i<$k)
			$i:=$i+1
			If (($0[[$i-1]]=" ") | ($0[[$i-1]]="\r") | ($0[[$i-1]]="\n"))
				$0[[$i]]:=Uppercase:C13($0[[$i]])
			End if 
		End while 
		Case of 
			: (Substring:C12($0; 1; 3)="po ")
				$0:="PO "+Substring:C12($0; 4)
			: (Substring:C12($0; 1; 3)="p.o. ")
				$0:="P.O. "+Substring:C12($0; 6)
		End case 
		If (Count parameters:C259=1)
			$1->:=$0
		End if 
	End if 
End if 
